//
//  LocationManager.swift
//  Rainstorm
//
//  Created by Jack Terry on 3/28/19.
//  Copyright © 2019 Jack Terry. All rights reserved.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, LocationService {
    
    // MARK: - Properties
    
    private lazy var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        
        locationManager.delegate = self
        
        return locationManager
    }()
    
    // MARK: -
    
    private var didFetchLocation: FetchLocationCompletion?
    
    // MARK: - Helper methods
    func fetchLocation(completion: @escaping LocationManager.FetchLocationCompletion) {
        didFetchLocation = completion
        
        locationManager.requestLocation()
    }
  
}

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .notDetermined {
            // Request authorization
            locationManager.requestWhenInUseAuthorization()
        } else if status == .authorizedWhenInUse {
            // Fetch location
            locationManager.requestLocation()
        } else {
            // Initialize failure result
            let result: LocationServiceResult = .failure(.notAuthorizedToRequestLocation)
           
            // Invoke completion handler
            didFetchLocation?(result)
            
            // Reset completion handler
            didFetchLocation = nil
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        
        // Initialize success result
        let result: LocationServiceResult = .success(Location(location: location))
        
        // Set city in CityManager singleton
        CityManager.instance.setCityFromLocation(location)
        
        // Invoke completion handler
        didFetchLocation?(result)
        
        // Reset completion handler
        didFetchLocation = nil
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Unable to fetch location: \(error)")
    }
}

fileprivate extension Location {
    
    init(location: CLLocation) {
        latitude = location.coordinate.latitude
        longitude = location.coordinate.longitude
    }
}
