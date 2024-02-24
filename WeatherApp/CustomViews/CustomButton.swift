//
//  CustomButton.swift
//  WeatherApp
//
//  Created by Iuliia Volkova on 27.07.2022.
//

import Foundation
import UIKit

final class CustomButton: UIButton {
    
    private var buttonAction: () -> Void
    
    init(text: String, buttonAction: @escaping() -> Void) {
        self.buttonAction = buttonAction
        
        super.init(frame: .zero)
        
        self.setTitle(text, for: .normal)
        self.backgroundColor = CustomColors.setColor(style: .brightOrange)
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        self.titleLabel?.numberOfLines = 1
        self.titleLabel?.adjustsFontSizeToFitWidth = true
        self.contentEdgeInsets = UIEdgeInsets(top: 12, left: 22, bottom: 12, right: 22)
        self.toAutoLayout()
        self.setTitleColor(.white, for: .normal)
        
        self.addTarget(self, action: #selector(buttonIsTapped), for: .touchUpInside)
    }
    
    @objc private func buttonIsTapped() {
        self.buttonAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
