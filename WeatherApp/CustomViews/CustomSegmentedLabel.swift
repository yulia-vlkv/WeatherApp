//
//  CustomSegmentedLabel.swift
//  WeatherApp
//
//  Created by Iuliia Volkova on 27.07.2022.
//

import Foundation
import UIKit

class CustomSegmentedLabel: UILabel {
    
    init(text: String) {
        super.init(frame: .zero)
        
        self.text = text
        self.textAlignment = .left
        self.textColor = .lightGray
        self.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        self.toAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
