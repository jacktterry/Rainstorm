//
//  WeatherData.swift
//  Rainstorm
//
//  Created by Jack Terry on 3/27/19.
//  Copyright © 2019 Jack Terry. All rights reserved.
//

import Foundation

protocol WeatherData {
    
    var latitude: Double { get }
    var longitude: Double { get }
    
    var current: CurrentWeatherConditions { get }
    var forecast: [ForecastWeatherConditions] { get }
    
}

protocol WeatherConditions {
    
    var time: Date { get }
    var icon: String { get }
    var windSpeed: Double { get }
    
}

protocol CurrentWeatherConditions: WeatherConditions {
    
    var summary: String { get }
    var temperature: Double { get }
    
}

protocol ForecastWeatherConditions: WeatherConditions {
    
    var temperatureMax: Double { get }
    var temperatureMin: Double { get }
    
}
