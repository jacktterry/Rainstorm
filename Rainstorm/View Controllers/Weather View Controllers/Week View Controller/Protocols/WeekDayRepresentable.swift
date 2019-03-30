//
//  WeekDayRepresentable.swift
//  Rainstorm
//
//  Created by Jack Terry on 3/28/19.
//  Copyright © 2019 Jack Terry. All rights reserved.
//

import UIKit

protocol WeekDayRepresentable {
    
    var day: String { get }
    var date: String { get }
    var temperature: String { get }
    var windSpeed: String { get }
    var image: UIImage? { get }
    
}
