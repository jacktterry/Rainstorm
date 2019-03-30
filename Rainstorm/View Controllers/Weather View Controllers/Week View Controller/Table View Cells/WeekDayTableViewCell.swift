//
//  WeekDayTableViewCell.swift
//  Rainstorm
//
//  Created by Jack Terry on 3/27/19.
//  Copyright © 2019 Jack Terry. All rights reserved.
//

import UIKit

class WeekDayTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    static var resuseIdentifier: String {
        return String(describing: self)
    }
    
    // MARK: -
    
    @IBOutlet var dayLabel: UILabel! {
        didSet {
            dayLabel.textColor = Styles.Colors.baseTextColor
            dayLabel.font = Styles.Fonts.heavyLarge
        }
    }
    
    @IBOutlet var dateLabel: UILabel! {
        didSet {
            dateLabel.textColor = .black
            dateLabel.font = Styles.Fonts.lightRegular
        }
    }
    
    @IBOutlet var iconImageView: UIImageView! {
        didSet {
            iconImageView.contentMode = .scaleAspectFit
            iconImageView.tintColor = Styles.Colors.baseTintColor
        }
    }
    
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var windSpeedLabel: UILabel!
    
    @IBOutlet var smallLabels: [UILabel]! {
        didSet {
            for label in smallLabels {
                label.textColor = .black
                label.font = Styles.Fonts.lightSmall
            }
        }
    }
    
    @IBOutlet var weatherDataViews: [UIView]! {
        didSet {
            for view in weatherDataViews {
                view.isHidden = false
            }
        }
    }
    
    // MARK: - View Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
    }
    
    // MARK: - Helper methods
    
    func configure(with representable: WeekDayRepresentable) {
        dayLabel.text = representable.day
        dateLabel.text = representable.date
        temperatureLabel.text = representable.temperature
        windSpeedLabel.text = representable.windSpeed
        iconImageView.image = representable.image
    }
    
}
