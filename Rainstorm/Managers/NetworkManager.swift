//
//  NetworkManager.swift
//  Rainstorm
//
//  Created by Jack Terry on 3/29/19.
//  Copyright © 2019 Jack Terry. All rights reserved.
//

import Foundation

class NetworkManager: NetworkService {
    
    func fetchData(with url: URL, completion: @escaping NetworkService.FetchDataCompletion) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
}
