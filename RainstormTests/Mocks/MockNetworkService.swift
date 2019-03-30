//
//  MockNetworkService.swift
//  RainstormTests
//
//  Created by Jack Terry on 3/29/19.
//  Copyright © 2019 Jack Terry. All rights reserved.
//

import Foundation
@testable import Rainstorm

class MockNetworkService: NetworkService {
    
    // MARK: - Properties
    
    var data: Data?
    var error: Error?
    var statusCode: Int = 200
    
    // MARK: - Methods
    
    func fetchData(with url: URL, completion: @escaping NetworkService.FetchDataCompletion) {
        let response = HTTPURLResponse(url: url, statusCode: statusCode, httpVersion: nil, headerFields: nil)
        
        completion(data, response, error)
    }
}
