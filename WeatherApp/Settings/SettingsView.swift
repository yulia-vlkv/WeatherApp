//
//  SettingsView.swift
//  WeatherApp
//
//  Created by Iuliia Volkova on 27.07.2022.
//

import Foundation
import UIKit

class SettingsView: UIViewController {
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = CustomColors.setColor(style: .deepBlue)
        view.toAutoLayout()
        return view
    }()
    
    // MARK: - Top Part
    
    private let topCloudsStack: UIStackView = {
        let stack = UIStackView()
        stack.toAutoLayout()
        stack.distribution = .fillProportionally
        stack.axis = .vertical
        return stack
    }()
    
    private let topCloudImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "topCloud")
        image.contentMode = .left
        image.alpha = 0.3
        image.toAutoLayout()
        return image
    }()
    
    private let middleCloudImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "middleCloud")
        image.contentMode = .right
        image.toAutoLayout()
        return image
    }()
    
        // MARK: - Middle Part
    
    private let settingsView: UIView = {
        let view = UIView()
        view.backgroundColor = CustomColors.setColor(style: .lightBlue)
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.toAutoLayout()
        return view
    }()
    
    private let settingsTitleLabel: UILabel = {
        let label = CustomLabel(
            font: UIFont.systemFont(ofSize: 18, weight: .medium),
            text: "Настройки")
        label.textColor = .black
        return label
    }()
    
    private let settingsSegmentedStackView: UIStackView = {
        let stack = UIStackView()
        stack.toAutoLayout()
        stack.distribution = .equalSpacing
        stack.axis = .vertical
        return stack
    }()
    
        // MARK: - Temperature
    
    private let temperatureStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        return stack
    }()
    
    private let temperatureLabel: UILabel = {
        let label = CustomSegmentedLabel(text: "Температура")
        return label
    }()

    private let temperatureSegmented: UISegmentedControl = {
        let segmented = CustomSegmented(items: ["F", "C"])
        return segmented
    }()
    
    // MARK: - Wind
    
    private let windSpeedStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        return stack
    }()

    private let windSpeedLabel: UILabel = {
        let label = CustomSegmentedLabel(text: "Скорость ветра")
        return label
    }()
    
    private let windSpeedSegmented: UISegmentedControl = {
        let segmented = CustomSegmented(items: ["Mi", "Km"])
        return segmented
    }()
    
    // MARK: - Time
    
    private let timeFormatStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        return stack
    }()

    private let timeFormatLabel: UILabel = {
        let label = CustomSegmentedLabel(text: "Формат времени")
        return label
    }()

    private let timeFormatSegmented: UISegmentedControl = {
        let segmented = CustomSegmented(items: ["12", "24"])
        return segmented
    }()
    
    // MARK: - Notifications

    private let notificationsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        return stack
    }()
    
    private let notificationsLabel: UILabel = {
        let label = CustomSegmentedLabel(text: "Уведомления")
        return label
    }()

    private let notificationsSegmented: UISegmentedControl = {
        let segmented = CustomSegmented(items: ["On", "Off"])
        return segmented
    }()
    
    // MARK: - Button
    
    private let setNewSettingsButton: UIButton = {
        let button = CustomButton(
            text: "Установить",
            buttonAction: {
                print("set new settings button is tapped")
            })
        return button
    }()
    
    // MARK: - Bottom Part
    
    private let bottomCloudStack: UIStackView = {
        let stack = UIStackView()
        stack.toAutoLayout()
        stack.distribution = .equalSpacing
        stack.axis = .vertical
        return stack
    }()
    
    private let bottomCloudImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "bottomCloud")
        image.contentMode = .scaleAspectFit
        image.contentMode = .center
        image.toAutoLayout()
        return image
    }()
    
    override func viewDidLoad() {
        self.view.backgroundColor = .cyan
        
        configureLayout()
    }
    
    // MARK: - configureLayout
    
    private func configureLayout(){
        
        view.addSubview(backgroundView)
        view.addSubview(topCloudsStack)
        topCloudsStack.addArrangedSubview(topCloudImage)
        topCloudsStack.addArrangedSubview(middleCloudImage)
        view.addSubview(settingsView)
        settingsView.addSubview(settingsTitleLabel)
        settingsView.addSubview(settingsSegmentedStackView)
        settingsSegmentedStackView.addArrangedSubview(temperatureStack)
        temperatureStack.addArrangedSubview(temperatureLabel)
        temperatureStack.addArrangedSubview(temperatureSegmented)
        settingsSegmentedStackView.addArrangedSubview(windSpeedStack)
        windSpeedStack.addArrangedSubview(windSpeedLabel)
        windSpeedStack.addArrangedSubview(windSpeedSegmented)
        settingsSegmentedStackView.addArrangedSubview(timeFormatStack)
        timeFormatStack.addArrangedSubview(timeFormatLabel)
        timeFormatStack.addArrangedSubview(timeFormatSegmented)
        settingsSegmentedStackView.addArrangedSubview(notificationsStack)
        notificationsStack.addArrangedSubview(notificationsLabel)
        notificationsStack.addArrangedSubview(notificationsSegmented)
        settingsView.addSubview(setNewSettingsButton)
        view.addSubview(bottomCloudStack)
        bottomCloudStack.addArrangedSubview(bottomCloudImage)

        let constraints = [
            
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            topCloudsStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topCloudsStack.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topCloudsStack.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topCloudsStack.bottomAnchor.constraint(equalTo: settingsView.topAnchor, constant: -topInset),
            
            settingsView.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            settingsView.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor),
            settingsView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: bigInset),
            settingsView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -bigInset),
            settingsView.heightAnchor.constraint(equalToConstant: height),
            
            settingsTitleLabel.topAnchor.constraint(equalTo: settingsView.topAnchor, constant: regularInset),
            settingsTitleLabel.leadingAnchor.constraint(equalTo: settingsView.leadingAnchor, constant: regularInset),
            
            settingsSegmentedStackView.topAnchor.constraint(equalTo: settingsTitleLabel.bottomAnchor, constant: regularInset),
            settingsSegmentedStackView.leadingAnchor.constraint(equalTo: settingsView.leadingAnchor, constant: regularInset),
            settingsSegmentedStackView.trailingAnchor.constraint(equalTo: settingsView.trailingAnchor, constant: -regularInset),
            settingsSegmentedStackView.bottomAnchor.constraint(equalTo: setNewSettingsButton.topAnchor, constant: -bigInset),
            
            setNewSettingsButton.bottomAnchor.constraint(equalTo: settingsView.bottomAnchor, constant: -bottomButtonInset),
            setNewSettingsButton.leadingAnchor.constraint(equalTo: settingsView.leadingAnchor, constant: buttonInset),
            setNewSettingsButton.trailingAnchor.constraint(equalTo: settingsView.trailingAnchor, constant: -buttonInset),

            bottomCloudStack.topAnchor.constraint(equalTo: settingsView.bottomAnchor),
            bottomCloudStack.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomCloudStack.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomCloudStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    // MARK: - Insets
    
    private var regularInset: CGFloat { return 20 }
    
    private var bigInset: CGFloat { return 20 }
    
    private var buttonInset: CGFloat { return 35 }
    
    private var bottomButtonInset: CGFloat { return 16 }
    
    private var topInset: CGFloat { return 25 }
    
    private var height: CGFloat { return 330 }
}
