//
//  UIViewController.swift
//  Rainstorm
//
//  Created by Jack Terry on 3/26/19.
//  Copyright © 2019 Jack Terry. All rights reserved.
//

import UIKit

extension UIViewController {
    
    // MARK: - Static properties
    
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
    
}
