//
//  CityManager.swift
//  Rainstorm
//
//  Created by Jack Terry on 3/30/19.
//  Copyright © 2019 Jack Terry. All rights reserved.
//

import Foundation
import CoreLocation

class CityManager {
    
    // MARK: - Properties
    
    static let instance = CityManager()
    
    // MARK: -
    
    private var city: String?
    
    // MARK: - Initialization
    // Private to ensure there are no unique instances
    
    private init() { }
    
    // MARK: - Methods
    
    func setCityFromLocation(_ location: CLLocation) {
        let geocoder = CLGeocoder()
        
        DispatchQueue.main.async {
            geocoder.reverseGeocodeLocation(location) { [weak self] (placemarks, error) in
                if let error = error {
                    print("Could not determine city: \(error)")
                }
                
                guard let placemark = placemarks?.first else { return }
                
                self?.city = placemark.locality
            }
        }
    }
    
    func getCityFromLocation() -> String? {
        return city
    }
}
