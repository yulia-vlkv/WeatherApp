//
//  OnboardingView.swift
//  WeatherApp
//
//  Created by Iuliia Volkova on 27.07.2022.
//

import Foundation
import UIKit

class OnboardingView: UIViewController {
    
    //    public var onPermitAccess: (() -> Void)?
    //    public var onDenyAccess: (() -> Void)?
    //    public var model = LocationService.shared
    
    public var model: OnboardingViewModel!
    
    private let scroll: UIScrollView = {
        let scroll = UIScrollView()
        scroll.toAutoLayout()
        scroll.alwaysBounceVertical = true
        scroll.backgroundColor = CustomColors.setColor(style: .deepBlue)
        return scroll
    }()
    
    private let contentStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 25
        stack.toAutoLayout()
        return stack
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
    
    private lazy var grantAccessButton: UIButton = {
        let button = CustomButton(
            text: OnboardingText.addText(text: .onBoardingGrantAccessButton),
            buttonAction: {
                self.model.grantAccess()
                print("button is tapped")
            })
        return button
    }()
    
    private lazy var denyAccessButton: UIButton = {
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
        self.model.onManualLocationTap()
        
//        let alert = UIAlertController(title: "Укажите вашу локацию", message: nil, preferredStyle: .alert)
//        alert.addTextField() { newTextField in
//            newTextField.placeholder = "Мой город"
//        }
//        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel))
//        alert.addAction(UIAlertAction(title: "Ок", style: .default) { _ in
//            if let textFields = alert.textFields,
//               let tf = textFields.first,
//               let text = tf.text {
//                self.model.addLocation(for: text)
//            } else {
//                print("Can't find the location")
//            }
//        })
//        self.present(alert, animated: true)
//        print("deny button is tapped")
    }
    
    override func viewDidLoad() {
        
        configureLayout()
    }
    
    // MARK: - configureLayout
    
    private func configureLayout(){
        
        view.addSubview(scroll)
        scroll.addSubview(contentStack)
        contentStack.addArrangedSubview(weatherGirlImage)
        contentStack.addArrangedSubview(permissionTitleLabel)
        contentStack.addArrangedSubview(permissionCommentLabel)
        contentStack.addArrangedSubview(grantAccessButton)
        contentStack.addArrangedSubview(denyAccessButton)
        
        let constraints = [
            
            scroll.topAnchor.constraint(equalTo: view.topAnchor),
            scroll.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scroll.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scroll.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scroll.widthAnchor.constraint(equalTo: view.widthAnchor),
            scroll.heightAnchor.constraint(equalTo: view.heightAnchor),
            
            contentStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: sideInset),
            contentStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant:  -sideInset),
            contentStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            contentStack.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    // MARK: - Insets
    
    private var sideInset: CGFloat { return 20 }
    
}
