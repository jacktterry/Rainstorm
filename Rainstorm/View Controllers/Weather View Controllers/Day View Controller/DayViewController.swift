//
//  DayViewController.swift
//  Rainstorm
//
//  Created by Jack Terry on 3/26/19.
//  Copyright © 2019 Jack Terry. All rights reserved.
//

import UIKit

final class DayViewController: UIViewController {
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup view
        setupView()
    }
    
    // MARK: - Helper methods
    
    private func setupView() {
        // Configure view
        view.backgroundColor = .green
    }
}
