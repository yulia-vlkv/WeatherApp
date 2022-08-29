//
//  DailyWeatherDetailTableCell.swift
//  WeatherApp
//
//  Created by Iuliia Volkova on 21.08.2022.
//

import Foundation
import UIKit



extension DailyWeatherDetailTableCell: ConfigurableView {
    
    func configure(with model: DailyWeatherDetailTableCellModel) {
        
        self.dayIcon.image = model.dayIcon
        self.nightIcon.image = model.nightIcon
        self.dayTempLabel.text = "\(model.dayTemperature)°"
        self.nightTempLabel.text = "\(model.nightTemperature)°"
        self.feelsLikeDayTempLabel.text = "По ощущениям \(model.feelsLikeDay)°"
        self.feelsLikeNightTempLabel.text = "По ощущениям \(model.feelsLikeNight)°"

    }
}


class DailyWeatherDetailTableCell: UITableViewCell {
    
    private let backgroundLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.toAutoLayout()
        return label
    }()
    
    private let topStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 13
        stack.distribution = .fillEqually
        stack.toAutoLayout()
        return stack
    }()
    
    // MARK: - Day Info
    
    private let dayInfoStack: UIStackView = {
        let stack = UIStackView()
        stack.backgroundColor = CustomColors.setColor(style: .lightBlue)
        stack.layer.cornerRadius = 8
        stack.clipsToBounds = true
        stack.distribution = .fillProportionally
        stack.axis = .vertical
        stack.layoutMargins = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        stack.isLayoutMarginsRelativeArrangement = true
        stack.toAutoLayout()
        return stack
    }()
    
    private let dayStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.toAutoLayout()
        return stack
    }()
    
    private let dayIcon: UIImageView = {
        let image = UIImageView()
//        image.image = UIImage(systemName: "sun.max.fill")
        image.contentMode = .scaleAspectFit
        image.toAutoLayout()
        return image
    }()
    
    private let dayTempLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.contentMode = .center
//        label.text = "24°"
        label.font = UIFont.systemFont(ofSize: 28, weight: .medium)
        label.textColor = CustomColors.setColor(style: .deepBlue)
        label.toAutoLayout()
        return label
    }()
    
    private let feelsLikeDayTempLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textAlignment = .center
//        label.text = "По ощущениям 22°"
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = CustomColors.setColor(style: .deepBlue)
        label.toAutoLayout()
        return label
    }()
    
    // MARK: - Night Info
    
    private let nightInfoStack: UIStackView = {
        let stack = UIStackView()
        stack.backgroundColor = CustomColors.setColor(style: .deepBlue)
        stack.layer.cornerRadius = 8
        stack.clipsToBounds = true
        stack.distribution = .fillProportionally
        stack.axis = .vertical
        stack.layoutMargins = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        stack.isLayoutMarginsRelativeArrangement = true
        stack.toAutoLayout()
        return stack
    }()
    
    private let nightStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.toAutoLayout()
        return stack
    }()
    
    private let nightIcon: UIImageView = {
        let image = UIImageView()
//        image.image = UIImage(systemName: "moon.stars.fill")
        image.tintColor = CustomColors.setColor(style: .lightBlue)
        image.contentMode = .scaleAspectFit
        image.toAutoLayout()
        return image
    }()
    
    private let nightTempLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.contentMode = .center
//        label.text = "24°"
        label.font = UIFont.systemFont(ofSize: 28, weight: .medium)
        label.textColor = CustomColors.setColor(style: .lightBlue)
        label.toAutoLayout()
        return label
    }()
    
    private let feelsLikeNightTempLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textAlignment = .center
//        label.text = "По ощущениям 22°"
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = CustomColors.setColor(style: .lightBlue)
        label.toAutoLayout()
        return label
    }()
    
    // MARK: - General Info
    
    private let generalInfoLabel: UIStackView = {
        let stack = UIStackView()
        stack.backgroundColor = CustomColors.setColor(style: .lightBlue)
        stack.layer.cornerRadius = 8
        stack.axis = .vertical
        stack.spacing = 8
        stack.distribution = .fillProportionally
        stack.clipsToBounds = true
        stack.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        stack.isLayoutMarginsRelativeArrangement = true
        stack.toAutoLayout()
        return stack
    }()
    
    // MARK: - Clouds
    
    private let cloudsStack: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fillProportionally
        stack.axis = .horizontal
        stack.spacing = 8
        stack.toAutoLayout()
        return stack
    }()
    
    private let cloudsImage: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "cloud"))
        image.contentMode = .scaleAspectFit
        image.toAutoLayout()
        return image
    }()
    
    private let cloudsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        let text = "Облачность 13%"
        let textToHighlight = "13%"
        let range = (text as NSString).range(of: textToHighlight)
        let mutableAttributedString = NSMutableAttributedString.init(string: text)
        mutableAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: CustomColors.setColor(style: .deepBlue), range: range)
        label.attributedText = mutableAttributedString
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.textAlignment = .left
        label.lineBreakStrategy = .pushOut
        label.toAutoLayout()
        return label
    }()
    
    // MARK: - Wind
    
    private let windStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        stack.toAutoLayout()
        return stack
    }()
    
    private let windImage: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "wind"))
        image.contentMode = .scaleAspectFit
        image.toAutoLayout()
        return image
    }()
    
    private let windLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        let text = "Ветер северо-западный, 2 м/с"
        let textToHighlight = "северо-западный"
        let anotherTextToHighlight = "2"
        let firstRange = (text as NSString).range(of: textToHighlight)
        let secondRange = (text as NSString).range(of: anotherTextToHighlight)
        let mutableAttributedString = NSMutableAttributedString.init(string: text)
        mutableAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: CustomColors.setColor(style: .deepBlue), range: firstRange)
        mutableAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: CustomColors.setColor(style: .deepBlue), range: secondRange)
        label.attributedText = mutableAttributedString
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.textAlignment = .left
        label.lineBreakStrategy = .pushOut
        label.toAutoLayout()
        return label
    }()
    
    // MARK: - Humidity
    
    private let humidityStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        stack.toAutoLayout()
        return stack
    }()
    
    private let humidityImage: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "humidity"))
        image.contentMode = .scaleAspectFit
        image.toAutoLayout()
        return image
    }()
    
    private let humidityLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        let text = "Влажность 13%"
        let textToHighlight = "13%"
        let range = (text as NSString).range(of: textToHighlight)
        let mutableAttributedString = NSMutableAttributedString.init(string: text)
        mutableAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: CustomColors.setColor(style: .deepBlue), range: range)
        label.attributedText = mutableAttributedString
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.textAlignment = .left
        label.lineBreakStrategy = .pushOut
        label.toAutoLayout()
        return label
    }()
    
    // MARK: - Astronomical Info
    private let astronomicalInfoLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = CustomColors.setColor(style: .lightBlue)
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
        label.toAutoLayout()
        return label
    }()
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .systemGreen
        
        configureLayout()
    }
    
    // MARK: - Configure Layout

    private func configureLayout(){
        contentView.addSubview(backgroundLabel)
        backgroundLabel.addSubview(topStackView)
        topStackView.addArrangedSubview(dayInfoStack)
        topStackView.addArrangedSubview(nightInfoStack)
        backgroundLabel.addSubview(generalInfoLabel)
        dayInfoStack.addArrangedSubview(dayStackView)
        dayStackView.addArrangedSubview(dayIcon)
        dayStackView.addArrangedSubview(dayTempLabel)
        dayInfoStack.addArrangedSubview(feelsLikeDayTempLabel)
        nightInfoStack.addArrangedSubview(nightStackView)
        nightStackView.addArrangedSubview(nightIcon)
        nightStackView.addArrangedSubview(nightTempLabel)
        nightInfoStack.addArrangedSubview(feelsLikeNightTempLabel)
        generalInfoLabel.addArrangedSubview(windStack)
        windStack.addArrangedSubview(windImage)
        windStack.addArrangedSubview(windLabel)
        generalInfoLabel.addArrangedSubview(cloudsStack)
        cloudsStack.addArrangedSubview(cloudsImage)
        cloudsStack.addArrangedSubview(cloudsLabel)
        generalInfoLabel.addArrangedSubview(humidityStack)
        humidityStack.addArrangedSubview(humidityImage)
        humidityStack.addArrangedSubview(humidityLabel)
        

//        dayInfoStack.addArrangedSubview(dayTempLabel)
//        dayInfoStack.addArrangedSubview(dayTempStack)
//        dayTempStack.addArrangedSubview(dayTempLabel)
//        dayTempStack.addArrangedSubview(feelsLikeDayTempLebel)

        
        let constraints = [
            backgroundLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            backgroundLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            backgroundLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            backgroundLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            backgroundLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            backgroundLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            
            topStackView.topAnchor.constraint(equalTo: backgroundLabel.topAnchor, constant: regularSideInset),
            topStackView.leadingAnchor.constraint(equalTo: backgroundLabel.leadingAnchor, constant: regularSideInset),
            topStackView.trailingAnchor.constraint(equalTo: backgroundLabel.trailingAnchor, constant: -regularSideInset),
            topStackView.heightAnchor.constraint(equalToConstant: (self.frame.width - (regularSideInset * 3)) / 2 ),
        
            generalInfoLabel.topAnchor.constraint(equalTo: topStackView.bottomAnchor, constant: regularSideInset),
            generalInfoLabel.leadingAnchor.constraint(equalTo: backgroundLabel.leadingAnchor, constant: regularSideInset),
            generalInfoLabel.trailingAnchor.constraint(equalTo: backgroundLabel.trailingAnchor, constant: -regularSideInset),
//            generalInfoLabel.heightAnchor.constraint(equalToConstant: self.frame.width)
            
            
        
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    // MARK: - Insets
    
    private var backgroundHeight: CGFloat { return 66 }
    
    private var labelHeight: CGFloat { return 56 }
    
    private var sideInset: CGFloat { return 16 }
    
    private var regularSideInset: CGFloat { return 13 }
    
    private var smallSideInset: CGFloat { return 10 }
}
