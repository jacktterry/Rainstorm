//
//  WeekViewModel.swift
//  Rainstorm
//
//  Created by Jack Terry on 3/27/19.
//  Copyright © 2019 Jack Terry. All rights reserved.
//

import Foundation

struct WeekViewModel {
    
    // MARK: - Properties
    
    let weatherData: [ForecastWeatherConditions]
    
    // MARK: -
    
    var numberOfDays: Int {
        return weatherData.count
    }
    
    // MARK: - Methods
    
    func viewModel(for index: Int) -> WeekDayViewModel {
        return WeekDayViewModel(weatherData: weatherData[index])
    }
}
