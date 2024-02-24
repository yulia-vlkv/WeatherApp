//
//  CustomLabel.swift
//  WeatherApp
//
//  Created by Iuliia Volkova on 27.07.2022.
//

import UIKit

class CustomLabel: UILabel {
    
    init(font: UIFont, text: String) {
        super.init(frame: .zero)
        
        self.font = font
        self.text = text
        self.backgroundColor = .clear
        self.textColor = .white
        self.numberOfLines = 0
        self.lineBreakMode = .byWordWrapping
        self.contentMode = .left
        self.adjustsFontSizeToFitWidth = true
        toAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
