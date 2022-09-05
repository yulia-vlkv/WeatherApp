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
        
        dayIcon.image = model.dayIcon
        nightIcon.image = model.nightIcon
        dayTempLabel.text = "\(model.dayTemperature)°"
        nightTempLabel.text = "\(model.nightTemperature)°"
        feelsLikeDayTempLabel.text = "По ощущениям \(model.feelsLikeDay)°"
        feelsLikeNightTempLabel.text = "По ощущениям \(model.feelsLikeNight)°"

        windLabel.attributedText = {
            let text = "Ветер \(model.windDirection), \(model.windSpeed)"
            let textToHighlight = "\(model.windDirection)"
            let anotherTextToHighlight = "\(model.windSpeed)"
            let firstRange = (text as NSString).range(of: textToHighlight)
            let secondRange = (text as NSString).range(of: anotherTextToHighlight)
            let mutableAttributedString = NSMutableAttributedString.init(string: text)
            mutableAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: CustomColors.setColor(style: .deepBlue), range: firstRange)
            mutableAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: CustomColors.setColor(style: .deepBlue), range: secondRange)
            return mutableAttributedString
        }()
        humidityLabel.attributedText = {
            let text = "Влажность \(model.probabilityOfRain)%"
            let textToHighlight = "\(model.probabilityOfRain)%"
            let range = (text as NSString).range(of: textToHighlight)
            let mutableAttributedString = NSMutableAttributedString.init(string: text)
            mutableAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: CustomColors.setColor(style: .deepBlue), range: range)
            return mutableAttributedString
        }()
        cloudsLabel.attributedText = {
            let text = "Облачность \(model.clouds)%"
            let textToHighlight = "\(model.clouds)%"
            let range = (text as NSString).range(of: textToHighlight)
            let mutableAttributedString = NSMutableAttributedString.init(string: text)
            mutableAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: CustomColors.setColor(style: .deepBlue), range: range)
            return mutableAttributedString
        }()
        
        uvLabel.attributedText = {
            let text = "УФ-индекс: \(model.uvIndex)"
            let textToHighlight = "\(model.uvIndex)"
            let range = (text as NSString).range(of: textToHighlight)
            let mutableAttributedString = NSMutableAttributedString.init(string: text)
            mutableAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: CustomColors.setColor(style: .deepBlue), range: range)
            return mutableAttributedString
        }()
        
        sunriseLabel.text = model.sunrise
        sunsetLabel.text = model.sunset
        moonriseLabel.text = model.moonrise
        moonsetLabel.text = model.moonset
        
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
        image.contentMode = .scaleAspectFit
        image.toAutoLayout()
        return image
    }()
    
    private let dayTempLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.contentMode = .center
        label.font = UIFont.systemFont(ofSize: 28, weight: .medium)
        label.textColor = CustomColors.setColor(style: .deepBlue)
        label.toAutoLayout()
        return label
    }()
    
    private let feelsLikeDayTempLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textAlignment = .center
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
        label.font = UIFont.systemFont(ofSize: 28, weight: .medium)
        label.textColor = CustomColors.setColor(style: .lightBlue)
        label.toAutoLayout()
        return label
    }()
    
    private let feelsLikeNightTempLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = CustomColors.setColor(style: .lightBlue)
        label.toAutoLayout()
        return label
    }()
    
    // MARK: - General Info
    
    private let generalInfoStack: UIStackView = {
        let stack = UIStackView()
        stack.backgroundColor = CustomColors.setColor(style: .lightBlue)
        stack.layer.cornerRadius = 8
        stack.axis = .vertical
        stack.spacing = 8
        stack.distribution = .fillProportionally
        stack.clipsToBounds = true
        stack.layoutMargins = UIEdgeInsets(top: 24, left: 16, bottom: 16, right: 24)
        stack.isLayoutMarginsRelativeArrangement = true
        stack.toAutoLayout()
        return stack
    }()
    
    // MARK: - Clouds
    
    private let cloudsStack: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fillProportionally
        stack.axis = .horizontal
        stack.spacing = 16
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
        stack.spacing = 16
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
        stack.spacing = 16
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
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.textAlignment = .left
        label.lineBreakStrategy = .pushOut
        label.toAutoLayout()
        return label
    }()
    
    //MARK: UV-index
    private let uvStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 16
        stack.toAutoLayout()
        return stack
    }()
    
    private let uvImage: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "sun.min.fill"))
        image.contentMode = .scaleAspectFit
        image.toAutoLayout()
        return image
    }()
    
    private let uvLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.textAlignment = .left
        label.lineBreakStrategy = .pushOut
        label.toAutoLayout()
        return label
    }()
    
    // MARK: - Astronomical Info
    private let astronomicalInfoStack: UIStackView = {
        let stack = UIStackView()
        let gradient = CAGradientLayer()
        gradient.frame = stack.bounds
        gradient.colors = [CustomColors.setColor(style: .lightBlue).cgColor, CustomColors.setColor(style: .deepBlue).cgColor]
        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        stack.layer.insertSublayer(gradient, at: 0)
//        stack.backgroundColor =  CustomColors.setColor(style: .lightBlue)
        stack.layer.cornerRadius = 8
        stack.axis = .horizontal
        stack.spacing = 8
        stack.distribution = .fillEqually
        stack.clipsToBounds = false
        stack.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        stack.isLayoutMarginsRelativeArrangement = true
        stack.toAutoLayout()
        return stack
    }()
    
    // MARK: - Sun
    private let sunStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.toAutoLayout()
        return stack
    }()

    private let sunriseStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 16
        stack.toAutoLayout()
        return stack
    }()
    
    private let sunriseImage: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "sunrise.fill"))
        image.contentMode = .scaleAspectFit
        image.toAutoLayout()
        return image
    }()
    
    private let sunriseLabel: UILabel = {
        let label = UILabel()
        label.textColor = CustomColors.setColor(style: .deepBlue)
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.textAlignment = .center
        label.toAutoLayout()
        return label
    }()
    
    private let sunsetStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 16
        stack.toAutoLayout()
        return stack
    }()
    
    private let sunsetImage: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "sunset.fill"))
        image.contentMode = .scaleAspectFit
        image.toAutoLayout()
        return image
    }()
    
    private let sunsetLabel: UILabel = {
        let label = UILabel()
        label.textColor = CustomColors.setColor(style: .deepBlue)
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.textAlignment = .center
        label.toAutoLayout()
        return label
    }()
    
    // MARK: - Moon
    private let moonStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.toAutoLayout()
        return stack
    }()
    
    private let moonriseStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 16
        stack.toAutoLayout()
        return stack
    }()
    
    private let moonriseImage: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "moon.fill"))
        image.contentMode = .scaleAspectFit
        image.toAutoLayout()
        return image
    }()
    
    private let moonriseLabel: UILabel = {
        let label = UILabel()
        label.textColor = CustomColors.setColor(style: .deepBlue)
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.textAlignment = .center
        label.toAutoLayout()
        return label
    }()
    
    private let moonsetStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 16
        stack.toAutoLayout()
        return stack
    }()
    
    private let moonsetImage: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "moon"))
        image.contentMode = .scaleAspectFit
        image.toAutoLayout()
        return image
    }()
    
    private let moonsetLabel: UILabel = {
        let label = UILabel()
        label.textColor = CustomColors.setColor(style: .deepBlue)
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.textAlignment = .center
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
        backgroundLabel.addSubview(generalInfoStack)
        dayInfoStack.addArrangedSubview(dayStackView)
        dayStackView.addArrangedSubview(dayIcon)
        dayStackView.addArrangedSubview(dayTempLabel)
        dayInfoStack.addArrangedSubview(feelsLikeDayTempLabel)
        nightInfoStack.addArrangedSubview(nightStackView)
        nightStackView.addArrangedSubview(nightIcon)
        nightStackView.addArrangedSubview(nightTempLabel)
        nightInfoStack.addArrangedSubview(feelsLikeNightTempLabel)
        generalInfoStack.addArrangedSubview(windStack)
        windStack.addArrangedSubview(windImage)
        windStack.addArrangedSubview(windLabel)
        generalInfoStack.addArrangedSubview(cloudsStack)
        cloudsStack.addArrangedSubview(cloudsImage)
        cloudsStack.addArrangedSubview(cloudsLabel)
        generalInfoStack.addArrangedSubview(humidityStack)
        humidityStack.addArrangedSubview(humidityImage)
        humidityStack.addArrangedSubview(humidityLabel)
        generalInfoStack.addArrangedSubview(uvStack)
        uvStack.addArrangedSubview(uvImage)
        uvStack.addArrangedSubview(uvLabel)
        backgroundLabel.addSubview(astronomicalInfoStack)
        astronomicalInfoStack.addArrangedSubview(sunStack)
        sunStack.addArrangedSubview(sunriseStack)
        sunriseStack.addArrangedSubview(sunriseImage)
        sunriseStack.addArrangedSubview(sunriseLabel)
        sunStack.addArrangedSubview(sunsetStack)
        sunsetStack.addArrangedSubview(sunsetImage)
        sunsetStack.addArrangedSubview(sunsetLabel)
        astronomicalInfoStack.addArrangedSubview(moonStack)
        moonStack.addArrangedSubview(moonriseStack)
        moonriseStack.addArrangedSubview(moonriseImage)
        moonriseStack.addArrangedSubview(moonriseLabel)
        moonStack.addArrangedSubview(moonsetStack)
        moonsetStack.addArrangedSubview(moonsetImage)
        moonsetStack.addArrangedSubview(moonsetLabel)
        

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
        
            generalInfoStack.topAnchor.constraint(equalTo: topStackView.bottomAnchor, constant: regularSideInset),
            generalInfoStack.leadingAnchor.constraint(equalTo: backgroundLabel.leadingAnchor, constant: regularSideInset),
            generalInfoStack.trailingAnchor.constraint(equalTo: backgroundLabel.trailingAnchor, constant: -regularSideInset),
//            generalInfoLabel.heightAnchor.constraint(equalToConstant: self.frame.width)
            
            astronomicalInfoStack.topAnchor.constraint(equalTo: generalInfoStack.bottomAnchor, constant: regularSideInset),
            astronomicalInfoStack.leadingAnchor.constraint(equalTo: backgroundLabel.leadingAnchor, constant: regularSideInset),
            astronomicalInfoStack.trailingAnchor.constraint(equalTo: backgroundLabel.trailingAnchor, constant: -regularSideInset),
            astronomicalInfoStack.heightAnchor.constraint(equalToConstant: 100)
        
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
