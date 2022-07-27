//
//  OnboardingView.swift
//  WeatherApp
//
//  Created by Iuliia Volkova on 27.07.2022.
//

import Foundation
import UIKit

class OnboardingView: UIViewController {
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = CustomColors.setColor(style: .deepBlue)
        view.toAutoLayout()
        return view
    }()
    
    private let weatherGirlImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "weatherGirl")
        image.contentMode = .scaleAspectFill
        image.toAutoLayout()
        return image
    }()
    
    private let permissionTitleLabel: UILabel = {
        let label = CustomLabel(
            font: UIFont.systemFont(ofSize: 16, weight: .regular),
            text: OnboardingText.addText(text: .onBoardingTitle)
        )
        return label
    }()

    private let permissionCommentLabel: UILabel = {
        let label = CustomLabel(
            font: UIFont.systemFont(ofSize: 14, weight: .regular),
            text: OnboardingText.addText(text: .onBoardingComment)
        )
        return label
    }()
    
    private let grantAccessButton: UIButton = {
        let button = CustomButton(
            text: OnboardingText.addText(text: .onBoardingGrantAccessButton),
            buttonAction: {
                print("button is tapped")
            })
        return button
    }()
    
    private let denyAccessButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setTitle(OnboardingText.addText(text: .onBoardingDenyButton),
                        for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        button.contentHorizontalAlignment = .right
        button.toAutoLayout()
        button.addTarget(self, action: #selector(buttonIsTapped), for: .touchUpInside)
        
        return button
    }()
    
    @objc func buttonIsTapped(){
        print("deny button is tapped")
    }
    
    override func viewDidLoad() {
        self.view.backgroundColor = .cyan
        
        configureLayout()
    }
    
    
    private func configureLayout(){
        
        view.addSubview(backgroundView)
        view.addSubview(weatherGirlImage)
        view.addSubview(permissionTitleLabel)
        view.addSubview(permissionCommentLabel)
        view.addSubview(grantAccessButton)
        view.addSubview(denyAccessButton)
        
        let constraints = [
            
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            weatherGirlImage.topAnchor.constraint(equalTo: backgroundView.safeAreaLayoutGuide.topAnchor, constant: 60),
            weatherGirlImage.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 20),
            weatherGirlImage.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -20),
            
            permissionTitleLabel.topAnchor.constraint(equalTo: weatherGirlImage.bottomAnchor, constant: 30),
            permissionTitleLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 20),
            permissionTitleLabel.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -20),
        
            permissionCommentLabel.topAnchor.constraint(equalTo: permissionTitleLabel.bottomAnchor, constant: 30),
            permissionCommentLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 20),
            permissionCommentLabel.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -20),
            
            grantAccessButton.topAnchor.constraint(equalTo: permissionCommentLabel.bottomAnchor, constant: 30),
            grantAccessButton.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 20),
            grantAccessButton.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -20),
            grantAccessButton.heightAnchor.constraint(equalToConstant: 40),
            
            denyAccessButton.topAnchor.constraint(equalTo: grantAccessButton.bottomAnchor, constant: 25),
            denyAccessButton.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -20)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
