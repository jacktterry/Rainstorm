//
//  RootViewController.swift
//  Rainstorm
//
//  Created by Jack Terry on 3/26/19.
//  Copyright © 2019 Jack Terry. All rights reserved.
//

import UIKit

final class RootViewController: UIViewController {
    
    // MARK: - Types
    
    private enum AlertType {
        case notAuthorizedToRequestLocation
        case failedToRequestLocation
        case noWeatherDataAvailable
    }
    
    // MARK: - Properties
    
    var viewModel: RootViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            
            setupViewModel(with: viewModel)
        }
    }
    
    private let dayViewController: DayViewController = {
        // Safely unwrap the view controller
        guard let viewController = UIStoryboard.main.instantiateViewController(withIdentifier: DayViewController.storyboardIdentifier) as? DayViewController else {
            fatalError("Unable to instantiate the Day View Controller")
        }
        
        // Configure Day View Controller
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        return viewController
    }()

    private lazy var weekViewController: WeekViewController = {
        // Safely unwrap the view controller
        guard let viewController = UIStoryboard.main.instantiateViewController(withIdentifier: WeekViewController.storyboardIdentifier) as? WeekViewController else {
            fatalError("Unable to instantiate the Week View Controller")
        }
        
        // Configure Day View Controller
        viewController.delegate = self
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        return viewController
    }()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup child view controllers
        setupChildViewControllers()
        
        viewModel?.refresh()
    }

    // MARK: - Helper methods
    
    private func setupChildViewControllers() {
        // Add view controllers to RootViewController
        addChild(dayViewController)
        addChild(weekViewController)
        
        // Add the view controller views to the view of RootViewController
        view.addSubview(dayViewController.view)
        view.addSubview(weekViewController.view)
        
        // Add constraints to the views
        dayViewController.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        dayViewController.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        dayViewController.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        weekViewController.view.topAnchor.constraint(equalTo: dayViewController.view.bottomAnchor).isActive = true
        weekViewController.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        weekViewController.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        weekViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        // Move view controllers to RootViewController
        dayViewController.didMove(toParent: self)
        weekViewController.didMove(toParent: self)
    }
    
    // MARK: -

    private func setupViewModel(with viewModel: RootViewModel) {
        viewModel.didFetchWeatherData = { [weak self] (result) in
            switch result {
            case .success(let weatherData):
                // Initialize view models
                let dayViewModel = DayViewModel(weatherData: weatherData.current, locality: CityManager.instance.getCityFromLocation())
                let weekViewModel = WeekViewModel(weatherData: weatherData.forecast)
                
                // Update view controllers
                self?.dayViewController.viewModel = dayViewModel
                self?.weekViewController.viewModel = weekViewModel
            case .failure(let error):
                let alertType: AlertType
                
                // Determine the type of error
                switch error {
                case .notAuthorizedToRequestLocation:
                    alertType = .notAuthorizedToRequestLocation
                case .failedToRequestLocation:
                    alertType = .failedToRequestLocation
                case .noWeatherDataAvailable:
                    alertType = .noWeatherDataAvailable
                }
                
                // Noftify user
                self?.presentAlert(of: alertType)
                
                self?.dayViewController.viewModel = nil
                self?.weekViewController.viewModel = nil
            }
        }
    }
    
    // MARK: -
    
    private func presentAlert(of alertType: AlertType) {
        // Helpers
        let title: String
        let message: String
        
        // Set helpers to the type of alert
        switch alertType {
        case .notAuthorizedToRequestLocation:
            title = "Unable to fetch weather data for your location"
            message = "Rainstorm is not authorized to access your location for displaying weather data."
        case .failedToRequestLocation:
            title = "Unable to fetch weather data for your location"
            message = "Rainstorm is experiencing technical issues"
        case .noWeatherDataAvailable:
            title = "Unable to fetch weather data for your location"
            message = "The application is unable to fetch data. Please ensure that your device is connected to the internet."
        }
        
        // Configure an alert controller
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        // Configure the cancel action
        let cancelAction = UIAlertAction(title: "Confirm", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        // Show the user the alert
        present(alertController, animated: true)
    }
    
}

extension RootViewController: WeekViewControllerDelegate {
    
    func controllerDidRefresh(_ controller: WeekViewController) {
        viewModel?.refresh()
    }
    
}
