//
//  MockLocationService.swift
//  RainstormTests
//
//  Created by Jack Terry on 3/29/19.
//  Copyright © 2019 Jack Terry. All rights reserved.
//

import Foundation
@testable import Rainstorm

class MockLocationService: LocationService {
    
    // MARK: - Properties
    
    var location: Location? = Location(latitude: 0.0, longitude: 0.0)
    
    var delay: TimeInterval = 0.0
    
    // MARK: - Methods
    
    func fetchLocation(completion: @escaping LocationService.FetchLocationCompletion) {
        let result: LocationServiceResult
        
        if let location = location {
            result = .success(location)
        } else {
            result = .failure(.notAuthorizedToRequestLocation)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            completion(result)
        }
    }
    
}
