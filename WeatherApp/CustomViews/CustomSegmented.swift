//
//  CustomSegmented.swift
//  WeatherApp
//
//  Created by Iuliia Volkova on 27.07.2022.
//

import Foundation
import UIKit

class CustomSegmented: UISegmentedControl {
    
    init(items: [String]) {
        super.init(items: items)
        
        self.selectedSegmentIndex = 1
        self.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        self.selectedSegmentTintColor = CustomColors.setColor(style: .deepBlue)
        self.contentMode = .right
        self.setWidth(50, forSegmentAt: 0)
        self.setWidth(50, forSegmentAt: 1)
        self.toAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
