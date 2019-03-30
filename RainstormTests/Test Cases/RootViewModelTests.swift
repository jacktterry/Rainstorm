//
//  RootViewModelTests.swift
//  RainstormTests
//
//  Created by Jack Terry on 3/29/19.
//  Copyright © 2019 Jack Terry. All rights reserved.
//

import XCTest
@testable import Rainstorm

class RootViewModelTests: XCTestCase {
    
    // MARK: - Properties
    
    var viewModel: RootViewModel!
    
    var networkService: MockNetworkService!
    var locationService: MockLocationService!

    // MARK: - Set Up & Tear Down
    
    override func setUp() {
        super.setUp()
        
        // Initialize mock network service
        networkService = MockNetworkService()
        
        // Configure mock network service
        networkService.data = loadStub(name: "darksky", extension: "json")
        
        // Initialize mock loccation service
        locationService = MockLocationService()
        
        // Initialize view model
        viewModel = RootViewModel(networkService: networkService, locationService: locationService)
    }

    override func tearDown() {
        super.tearDown()
        
        UserDefaults.standard.removeObject(forKey: "didFetchWeatherData")
    }

    // MARK: - Test refresh
    
    func testRefresh_Success() {
        // Define expectation
        let expectation = XCTestExpectation(description: "Fetch weather data")
        
        // Install handler
        viewModel.didFetchWeatherData = { (result) in
            if case .success(let weatherData) = result {
                XCTAssertEqual(weatherData.latitude, 37.8267)
                XCTAssertEqual(weatherData.longitude, -122.4233)
                
                expectation.fulfill()
            }
        }
        
        // Invoke method under test
        viewModel.refresh()
        
        // Ensure the expectation is met
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testRefresh_FailedToFetchLocation() {
        // Fetching location of device failed
        locationService.location = nil
        
        // Define expectation
        let expectation = XCTestExpectation(description: "Fetch weather data")
        
        // Install handler
        viewModel.didFetchWeatherData = { (result) in
            if case .failure(let error) = result {
                XCTAssertEqual(error, RootViewModel.WeatherDataError.notAuthorizedToRequestLocation)
                
                expectation.fulfill()
            }
        }
        
        // Invoke method under test
        viewModel.refresh()
        
        // Ensure the expectation is met
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testRefresh_FailedToFetchWeatherData_RequestFailed() {
        networkService.error = NSError(domain: "com.JackTerry.com.network.service", code: 1, userInfo: nil)
        
        // Define expectation
        let expectation = XCTestExpectation(description: "Fetch weather data")
        
        // Install handler
        viewModel.didFetchWeatherData = { (result) in
            if case .failure(let error) = result {
                XCTAssertEqual(error, RootViewModel.WeatherDataError.noWeatherDataAvailable)
                
                expectation.fulfill()
            }
        }
        
        // Invoke method under test
        viewModel.refresh()
        
        // Ensure the expectation is met
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testRefresh_FailedToFetchWeatherData_InvaliedResponse() {
        networkService.data = "data".data(using: .utf8)
        
        // Define expectation
        let expectation = XCTestExpectation(description: "Fetch weather data")
        
        // Install handler
        viewModel.didFetchWeatherData = { (result) in
            if case .failure(let error) = result {
                XCTAssertEqual(error, RootViewModel.WeatherDataError.noWeatherDataAvailable)
                
                expectation.fulfill()
            }
        }
        
        // Invoke method under test
        viewModel.refresh()
        
        // Ensure the expectation is met
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testRefresh_FailedToFetchWeatherData_NoErrorNoResponse() {
        networkService.data = nil
        
        // Define expectation
        let expectation = XCTestExpectation(description: "Fetch weather data")
        
        // Install handler
        viewModel.didFetchWeatherData = { (result) in
            if case .failure(let error) = result {
                XCTAssertEqual(error, RootViewModel.WeatherDataError.noWeatherDataAvailable)
                
                expectation.fulfill()
            }
        }
        
        // Invoke method under test
        viewModel.refresh()
        
        // Ensure the expectation is met
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testApplicationWillEnterForeground_NoTimestamp() {
        UserDefaults.standard.removeObject(forKey: "didFetchWeatherData")
        
        // Define expectation
        let expectation = XCTestExpectation(description: "Fetch weather data")
        
        // Install handler
        viewModel.didFetchWeatherData = { (result) in
            // Fullfill expectation
            expectation.fulfill()
        }
        
        NotificationCenter.default.post(name: UIApplication.willEnterForegroundNotification, object: nil)

        // Ensure the expectation is met
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testApplicationWillEnterForeground_ShouldRefresh() {
        UserDefaults.standard.set(Date().addingTimeInterval(-3600.0), forKey: "didFetchWeatherData")
        
        // Define expectation
        let expectation = XCTestExpectation(description: "Fetch weather data")
        
        // Install handler
        viewModel.didFetchWeatherData = { (result) in
            // Fullfill expectation
            expectation.fulfill()
        }
        
        NotificationCenter.default.post(name: UIApplication.willEnterForegroundNotification, object: nil)
        
        // Ensure the expectation is met
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testApplicationWillEnterForeground_ShouldNotRefresh() {
        UserDefaults.standard.set(Date(), forKey: "didFetchWeatherData")
        
        // Define expectation
        let expectation = XCTestExpectation(description: "Fetch weather data")
        
        expectation.isInverted = true
        
        // Install handler
        viewModel.didFetchWeatherData = { (result) in
            // Fullfill expectation
            expectation.fulfill()
        }
        
        NotificationCenter.default.post(name: UIApplication.willEnterForegroundNotification, object: nil)
        
        // Ensure the expectation is met
        wait(for: [expectation], timeout: 2.0)
    }
    
}
