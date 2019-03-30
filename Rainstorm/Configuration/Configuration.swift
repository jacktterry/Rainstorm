//
//  Configuration.swift
//  Rainstorm
//
//  Created by Jack Terry on 3/26/19.
//  Copyright © 2019 Jack Terry. All rights reserved.
//

import Foundation

enum Defaults {
    
    static let location = Location(latitude: 37.335114, longitude: -122.008928)
    
}

enum Configuration {
    
    static var refreshThreshold: TimeInterval {
        #if DEBUG
        return 60.0
        #else
        return 10.0 * 60.0
        #endif
    }
    
}

enum WeatherService {
    
    private static let apiKey = "668a99a717b0f83ec11686093d0880ab"
    private static let baseUrl = URL(string: "https://api.darksky.net/forecast/")!
    
    static var authenticatedBaseUrl: URL {
        return baseUrl.appendingPathComponent(apiKey)
    }
}
