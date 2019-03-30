//
//  WeekViewController.swift
//  Rainstorm
//
//  Created by Jack Terry on 3/26/19.
//  Copyright © 2019 Jack Terry. All rights reserved.
//

import UIKit

protocol WeekViewControllerDelegate: class {
    func controllerDidRefresh(_ controller: WeekViewController)
}

final class WeekViewController: UIViewController {
    
    // MARK: - Properties
    
    weak var delegate: WeekViewControllerDelegate?
    
    var viewModel: WeekViewModel? {
        didSet {
            refreshControl.endRefreshing()
            
            if let viewModel = viewModel {
                // Setup view model
                setupViewModel(with: viewModel)
            }
            
        }
    }
    
    // MARK: -
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        
        refreshControl.tintColor = Styles.Colors.baseTintColor
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        
        return refreshControl
    }()
    
    // MARK: -
    
    @IBOutlet var tableView: UITableView! {
        didSet {
            tableView.isHidden = true
            tableView.dataSource = self
            tableView.separatorInset = .zero
            tableView.estimatedRowHeight = 44.0
            tableView.rowHeight = UITableView.automaticDimension
            tableView.showsVerticalScrollIndicator = false
            
            tableView.refreshControl = refreshControl
        }
    }
    
    // MARK: -
    
    @IBOutlet var activityIndicatorView: UIActivityIndicatorView! {
        didSet {
            activityIndicatorView.startAnimating()
            activityIndicatorView.hidesWhenStopped = true
        }
    }
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup view
        setupView()
    }
    
    // MARK: - Helper methods
    
    private func setupView() {
        // Configure view
        view.backgroundColor = .white
    }
    
    // MARK: -
    
    @objc private func refresh(_ sender: UIRefreshControl) {
        delegate?.controllerDidRefresh(self)
    }
    
    // MARK: -
    
    private func setupViewModel(with viewModel: WeekViewModel) {
        // Hide activity indicator
        activityIndicatorView.stopAnimating()
        
        // Display table view data
        tableView.reloadData()
        tableView.isHidden = false
    }
}

extension WeekViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfDays ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeekDayTableViewCell.resuseIdentifier, for: indexPath) as? WeekDayTableViewCell else {
            fatalError("Unable to dequeue a cell of the WeekDayTableViewCell type")
        }
        
        guard let viewModel = viewModel else {
            fatalError("No view model present")
        }
        
        cell.configure(with: viewModel.viewModel(for: indexPath.row))
        return cell
    }
    
}
