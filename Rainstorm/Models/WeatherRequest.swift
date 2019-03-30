//
//  WeatherRequest.swift
//  Rainstorm
//
//  Created by Jack Terry on 3/26/19.
//  Copyright © 2019 Jack Terry. All rights reserved.
//

import Foundation

struct WeatherRequest {
    
    let baseUrl: URL
    
    var location: Location
    
    private var latitude: Double {
        return location.latitude
    }
    
    private var longitude: Double {
        return location.longitude
    }
    
    var url: URL {
        return baseUrl.appendingPathComponent("\(latitude),\(longitude)")
    }
}
