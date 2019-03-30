//
//  NetworkService.swift
//  Rainstorm
//
//  Created by Jack Terry on 3/29/19.
//  Copyright © 2019 Jack Terry. All rights reserved.
//

import Foundation

protocol NetworkService {
    
    // MARK: - Type Aliases
    
    typealias FetchDataCompletion = (Data?, URLResponse?, Error?) -> Void
    
    func fetchData(with url: URL, completion: @escaping FetchDataCompletion)
    
}
