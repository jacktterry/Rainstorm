//
//  WeekDayViewModelTests.swift
//  RainstormTests
//
//  Created by Jack Terry on 3/28/19.
//  Copyright © 2019 Jack Terry. All rights reserved.
//

import XCTest
@testable import Rainstorm

class WeekDayViewModelTests: XCTestCase {
    
    // MARK: - Properties
    
    var viewModel: WeekDayViewModel!

    override func setUp() {
        super.setUp()
        
        // Load Stub
        let data = loadStub(name: "darksky", extension: "json")
        
        // Initialize JSONDecoder
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        
        // Initialize Dark Sky response
        let darkSkyReponse = try! decoder.decode(DarkSkyResponse.self, from: data)
        
        // Initialize view model
        viewModel = WeekDayViewModel(weatherData: darkSkyReponse.forecast[5])
    }

    override func tearDown() {
        super.tearDown()
    }

    func testDay() {
        XCTAssertEqual(viewModel.day, "Monday")
    }
    
    func testDate() {
        XCTAssertEqual(viewModel.date, "April 1")
    }
    
    func testTemperature() {
        XCTAssertEqual(viewModel.temperature, "56.8 °F - 65.5 °F")
    }
    
    func testWindSpeed() {
        XCTAssertEqual(viewModel.windSpeed, "5 MPH")
    }

    func testImage() {
        let viewModelImage = viewModel.image
        let viewModelImageData = viewModelImage?.pngData()
        let dataRepresentation = UIImage(named: "cloudy")?.pngData()
        
        XCTAssertNotNil(viewModelImage)
        XCTAssertEqual(viewModelImageData, dataRepresentation)
    }
}
