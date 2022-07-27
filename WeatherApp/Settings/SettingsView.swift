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
    
    private let topCloudImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "topCloud")
        image.contentMode = .scaleAspectFill
        image.contentMode = .left
        image.alpha = 0.3
        image.toAutoLayout()
        return image
    }()
    
    private let middleCloudImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "middleCloud")
        image.contentMode = .scaleAspectFill
        image.contentMode = .right
        image.toAutoLayout()
        return image
    }()
    
    private let bottomCloudImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "bottomCloud")
        image.contentMode = .scaleAspectFit
        image.contentMode = .center
        image.toAutoLayout()
        return image
    }()
    
    private let settingsTitleLabel: UILabel = {
        let label = CustomLabel(
            font: UIFont.systemFont(ofSize: 18, weight: .medium),
            text: "Настройки")
        label.textColor = .black
        return label
    }()
    
    private let temperatureLabel: UILabel = {
        let label = CustomSegmentedLabel(text: "Температура")
        return label
    }()
    
    private let temperatureSegmented: UISegmentedControl = {
        let segmented = CustomSegmented(leftItem: "F", rightItem: "C")
        return segmented
    }()
    
    private let windSpeedLabel: UILabel = {
        let label = CustomSegmentedLabel(text: "Скорость ветра")
        return label
    }()
    
    private let windSpeedSegmented: UISegmentedControl = {
        let segmented = CustomSegmented(leftItem: "Mi", rightItem: "Km")
        return segmented
    }()
    
    private let timeFormatLabel: UILabel = {
        let label = CustomSegmentedLabel(text: "Формат времени")
        return label
    }()
    
    private let timeFormatSegmented: UISegmentedControl = {
        let segmented = CustomSegmented(leftItem: "12", rightItem: "24")
        return segmented
    }()
    
    private let notificationsLabel: UILabel = {
        let label = CustomSegmentedLabel(text: "Уведомления")
        return label
    }()
    
    private let notificationsSegmented: UISegmentedControl = {
        let segmented = CustomSegmented(leftItem: "On", rightItem: "Off")
        return segmented
    }()
    
    private let setNewSettingsButton: UIButton = {
        let button = CustomButton(
            text: "Установить",
            buttonAction: {
                print("set new settings button is tapped")
            })
        return button
    }()
    
    override func viewDidLoad() {
        self.view.backgroundColor = .cyan
        
        configureLayout()
    }
    
    
    private func configureLayout(){
        
        view.addSubview(backgroundView)

        let constraints = [
            
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
