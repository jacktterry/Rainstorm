//
//  Styles.swift
//  Rainstorm
//
//  Created by Jack Terry on 3/27/19.
//  Copyright © 2019 Jack Terry. All rights reserved.
//

import UIKit

enum Styles {
    
    enum Colors {
        
        static let baseTextColor: UIColor = UIColor(red: 0.31, green: 0.72, blue: 0.81, alpha: 1)
        static let baseTintColor: UIColor = UIColor(red: 0.31, green: 0.72, blue: 0.81, alpha: 1)
        
        static let lightGrayBackgroundColor = UIColor(red: 0.975, green: 0.975, blue: 0.975, alpha: 1)
        
    }
    
    enum Fonts {
        
        static let lightRegular: UIFont = UIFont.systemFont(ofSize: 17.0, weight: .light)
        static let lightSmall: UIFont = UIFont.systemFont(ofSize: 15.0, weight: .light)
        
        static let heavyLarge: UIFont = UIFont.systemFont(ofSize: 20.0, weight: .heavy)
        
    }
}
