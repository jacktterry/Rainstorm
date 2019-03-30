//
//  DayViewModelTests.swift
//  RainstormTests
//
//  Created by Jack Terry on 3/27/19.
//  Copyright © 2019 Jack Terry. All rights reserved.
//

import XCTest
@testable import Rainstorm

class DayViewModelTests: XCTestCase {

    // MARK: - Properties
    
    var viewModel: DayViewModel!
    
    override func setUp() {
        super.setUp()
        
        let data = loadStub(name: "darksky", extension: "json")
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        
        let darkSkyReponse = try! decoder.decode(DarkSkyResponse.self, from: data)
        
        viewModel = DayViewModel(weatherData: darkSkyReponse.current)
    }

    override func tearDown() {
        super.tearDown()
    }

    func testDate() {
        XCTAssertEqual(viewModel.date, "Wed, March 27 2019")
    }
    
    func testTime() {
        XCTAssertEqual(viewModel.time, "02:00 PM")
    }
    
    func testSummary() {
        XCTAssertEqual(viewModel.summary, "Mostly Cloudy")
    }
    
    func testTemperature() {
        XCTAssertEqual(viewModel.temperature, "55.5 °F")
    }
    
    func testWindSpeed() {
        XCTAssertEqual(viewModel.windSpeed, "9 MPH")
    }
    
    func testImage() {
        let viewModelImage = viewModel.image
        let viewModelImageData = viewModelImage?.pngData()
        let imageDataReference = UIImage(named: "cloudy")?.pngData()
        
        XCTAssertNotNil(viewModelImage)
        XCTAssertEqual(viewModelImageData, imageDataReference)
    }
    
}
