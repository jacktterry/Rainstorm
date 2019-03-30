//
//  DayViewModel.swift
//  Rainstorm
//
//  Created by Jack Terry on 3/27/19.
//  Copyright © 2019 Jack Terry. All rights reserved.
//

import UIKit

struct DayViewModel {
    
    // MARK: - Properties
    
    let weatherData: CurrentWeatherConditions
    
    let locality: String?
    
    private let dateFormatter = DateFormatter()
    
    var date: String {
        dateFormatter.dateFormat = "EEE, MMMM d YYYY"
        
        return dateFormatter.string(from: weatherData.time)
    }
    
    var time: String {
        dateFormatter.dateFormat = "hh:mm a"
        
        return dateFormatter.string(from: weatherData.time)
    }
    
    var summary: String {
        return weatherData.summary
    }
    
    var temperature: String {
        return String(format: "%.1f °F", weatherData.temperature)
    }
    
    var windSpeed: String {
        return String(format: "%.f MPH", weatherData.windSpeed)
    }
    
    var image: UIImage? {
        return UIImage.imageForIcon(with: weatherData.icon)
    }
    
    var city: String? {
        return locality ?? ""
    }
    
}
