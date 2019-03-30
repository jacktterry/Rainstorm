//
//  DayViewController.swift
//  Rainstorm
//
//  Created by Jack Terry on 3/26/19.
//  Copyright © 2019 Jack Terry. All rights reserved.
//

import UIKit

final class DayViewController: UIViewController {
    
    // MARK: - Properties
    
    var viewModel: DayViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            
            setupViewModel(with: viewModel)
        }
    }
    
    // MARK: -
    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    @IBOutlet var iconImageView: UIImageView! {
        didSet {
            iconImageView.contentMode = .scaleAspectFit
            iconImageView.tintColor = Styles.Colors.baseTintColor
        }
    }
    
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var windSpeedLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    @IBOutlet var activityIndicatorView: UIActivityIndicatorView! {
        didSet {
            activityIndicatorView.startAnimating()
            activityIndicatorView.hidesWhenStopped = true
        }
    }
    
    // MARK: -
    
    @IBOutlet var largeLabels: [UILabel]! {
        didSet {
            for label in largeLabels {
                label.textColor = Styles.Colors.baseTextColor
                label.font = Styles.Fonts.heavyLarge
            }
        }
    }
    
    @IBOutlet var regularLabels: [UILabel]! {
        didSet {
            for label in regularLabels {
                label.textColor = .black
                label.font = Styles.Fonts.lightRegular
            }
        }
    }
    
    @IBOutlet var smallLabels: [UILabel]! {
        didSet {
            for label in smallLabels {
                label.textColor = .black
                label.font = Styles.Fonts.lightSmall
            }
        }
    }
    
    @IBOutlet var weatherDataViews: [UIView]! {
        didSet {
            for view in weatherDataViews {
                view.isHidden = true
            }
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
        view.backgroundColor = Styles.Colors.lightGrayBackgroundColor
    }
    
    // MARK: -
    
    private func setupViewModel(with viewModel: DayViewModel) {
        // Stop activity indicator
        activityIndicatorView.stopAnimating()
        
        // Setup view with viewModel properties
        cityLabel.text = viewModel.city
        dateLabel.text = viewModel.date
        timeLabel.text = viewModel.time
        temperatureLabel.text = viewModel.temperature
        windSpeedLabel.text = viewModel.windSpeed
        descriptionLabel.text = viewModel.summary
        
        iconImageView.image = viewModel.image
        
        // Show the WeatherDataViews
        for view in weatherDataViews {
            view.isHidden = false
        }
    }
}
