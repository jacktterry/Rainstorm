//
//  RootViewModel.swift
//  Rainstorm
//
//  Created by Jack Terry on 3/26/19.
//  Copyright © 2019 Jack Terry. All rights reserved.
//

import UIKit

class RootViewModel: NSObject {
    
    // MARK: - Types
    
    enum WeatherDataError: Error {
        case notAuthorizedToRequestLocation
        case failedToRequestLocation
        case noWeatherDataAvailable
    }
    
    enum WeatherDataResult {
        case success(WeatherData)
        case failure(WeatherDataError)
    }
    
    // MARK: - Type Aliases
    
    typealias FetchWeatherDataCompletion = (WeatherDataResult) -> Void
    
    // MARK: - Properties
    
    var didFetchWeatherData: FetchWeatherDataCompletion?
    
    // MARK: -
    
    private let networkService: NetworkService
    private let locationService: LocationService
    
    // MARK: - Initialization
    
    init(networkService: NetworkService, locationService: LocationService) {
        // Set services
        self.networkService = networkService
        self.locationService = locationService
        
        super.init()
        
        // Setup notification handling
        setupNotificationHandling()
    }
    
    // MARK: - Helper Methods
    
    private func fetchWeatherData(for location: Location) {
        // Initialize Weather Request
        let weatherRequest = WeatherRequest(baseUrl: WeatherService.authenticatedBaseUrl, location: location)
        
        // Create Data Task
        networkService.fetchData(with: weatherRequest.url) { [weak self] (data, response, error) in
            if let response = response as? HTTPURLResponse {
                print("Status Code: \(response.statusCode)")
            }
            
            DispatchQueue.main.async {
                if let error = error {
                    print("Unable to Fetch Weather Data \(error)")
                    
                    // Initialize failure
                    let result: WeatherDataResult = .failure(.noWeatherDataAvailable)
                    
                    // Invoke completion handler
                    self?.didFetchWeatherData?(result)
                } else if let data = data {
                    // Initialize JSON Decoder
                    let decoder = JSONDecoder()
                    
                    decoder.dateDecodingStrategy = .secondsSince1970
                    
                    do {
                        // Decode JSON Response
                        let darkSkyResponse = try decoder.decode(DarkSkyResponse.self, from: data)
                        
                        // Update the refresh timestamp
                        UserDefaults.didFetchWeatherData = Date()
                        
                        // Initialize success
                        let result: WeatherDataResult = .success(darkSkyResponse)
                        
                        // Invoke Completion Handler
                        self?.didFetchWeatherData?(result)
                    } catch {
                        print("Unable to Decode JSON Response \(error)")
                        
                        // Initialize failure
                        let result: WeatherDataResult = .failure(.noWeatherDataAvailable)
                        
                        // Invoke completion handler
                        self?.didFetchWeatherData?(result)
                    }
                } else {
                    // Initialize failure
                    let result: WeatherDataResult = .failure(.noWeatherDataAvailable)
                    
                    // Invoke completion handler
                    self?.didFetchWeatherData?(result)
                }
            }
        }
    }
    
    // MARK: -
    
    private func fetchLocation() {
        locationService.fetchLocation { [weak self] (result) in
            switch result {
            case .success(let location):
                // Invoke completion handler
                self?.fetchWeatherData(for: location)
            case .failure(let error):
                print("Unable to fetch location: \(error)")
                
                // Initialize failure
                let result: WeatherDataResult = .failure(.notAuthorizedToRequestLocation)
                
                // Invoke completion handler
                self?.didFetchWeatherData?(result)
            }
        }
    }
    
    // MARK: -
    
    private func setupNotificationHandling() {
        NotificationCenter.default.addObserver(forName: UIApplication.willEnterForegroundNotification,
                                               object: nil,
                                               queue: OperationQueue.main) { [weak self] (_) in
                                                guard let didFetchWeatherData = UserDefaults.didFetchWeatherData else {
                                                    self?.refresh()
                                                    return
                                                }
                                                
                                                if Date().timeIntervalSince(didFetchWeatherData) > Configuration.refreshThreshold {
                                                    self?.refresh()
                                                }
        }
    }
    
    // MARK: -
    
    func refresh() {
        fetchLocation()
    }
    
}

extension UserDefaults {
    
    private enum Keys {
        static let didFetchWeatherData = "didFetchWeatherData"
    }
    
    fileprivate class var didFetchWeatherData: Date? {
        get {
            return UserDefaults.standard.object(forKey: Keys.didFetchWeatherData) as? Date
        }
        
        set(newValue) {
            UserDefaults.standard.set(newValue, forKey: Keys.didFetchWeatherData)
        }
    }
    
}


