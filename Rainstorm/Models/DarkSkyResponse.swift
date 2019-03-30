//
//  DarkSkyResponse.swift
//  Rainstorm
//
//  Created by Jack Terry on 3/27/19.
//  Copyright © 2019 Jack Terry. All rights reserved.
//

import Foundation

struct DarkSkyResponse: Codable {
    
    struct Conditions: Codable {
        let time: Date
        let icon: String
        let summary: String
        let windSpeed: Double
        let temperature: Double
    }
    
    struct Daily: Codable {
        let data: [Conditions]
        
        struct Conditions: Codable {
            let time: Date
            let icon: String
            let windSpeed: Double
            let temperatureMax: Double
            let temperatureMin: Double
        }
    }
    
    let latitude: Double
    let longitude: Double
    
    let currently: Conditions
    let daily: Daily
}

extension DarkSkyResponse: WeatherData {
    
    var current: CurrentWeatherConditions {
        return currently
    }
    
    var forecast: [ForecastWeatherConditions] {
        return daily.data
    }
    
}

extension DarkSkyResponse.Conditions: CurrentWeatherConditions { }
extension DarkSkyResponse.Daily.Conditions: ForecastWeatherConditions { }
