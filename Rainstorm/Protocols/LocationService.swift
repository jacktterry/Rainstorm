//
//  LocationService.swift
//  Rainstorm
//
//  Created by Jack Terry on 3/28/19.
//  Copyright © 2019 Jack Terry. All rights reserved.
//

import Foundation

enum LocationServiceError {
    case notAuthorizedToRequestLocation
}

enum LocationServiceResult {
    case success(Location)
    case failure(LocationServiceError)
}

protocol LocationService {
    
    typealias FetchLocationCompletion = (LocationServiceResult) -> Void
    
    func fetchLocation(completion: @escaping FetchLocationCompletion)
}
