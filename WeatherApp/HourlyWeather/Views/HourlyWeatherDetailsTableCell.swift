//
//  HourlyWeatherDetailsTableCell.swift
//  WeatherApp
//
//  Created by Iuliia Volkova on 07.08.2022.
//

import UIKit

class HourlyWeatherDetailsTableCell: UITableViewCell {
    
    private let backgroundLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = CustomColors.setColor(style: .lightBlue)
        label.toAutoLayout()
        return label
    }()
    
    private let topStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.toAutoLayout()
        return stack
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "30/07"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textAlignment = .left
        label.toAutoLayout()
        return label
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "14:26"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textAlignment = .right
        label.toAutoLayout()
        return label
    }()
    
    private let bottomStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.spacing = 10
        stack.toAutoLayout()
        return stack
    }()
    
    private let infoStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fillProportionally
        stack.toAutoLayout()
        return stack
    }()
    
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.text = "24°"
        label.font = UIFont.systemFont(ofSize: 22, weight: .regular)
        label.textColor = .black
        label.toAutoLayout()
        return label
    }()
    
    private let weatherImage: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "cloud.sun.rain"))
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.toAutoLayout()
        return image
    }()
    
    
    private let detailsStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.toAutoLayout()
        return stack
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        let text = "Облачно, солнечно и дождливо. По ощущениям 10°"
        let textToHighlight = "10°"
        let range = (text as NSString).range(of: textToHighlight)
        let mutableAttributedString = NSMutableAttributedString.init(string: text)
        mutableAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: CustomColors.setColor(style: .deepBlue), range: range)
        label.attributedText = mutableAttributedString
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .left
        label.lineBreakStrategy = .pushOut
        label.toAutoLayout()
        return label
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
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .left
        label.lineBreakStrategy = .pushOut
        label.toAutoLayout()
        return label
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
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .left
        label.lineBreakStrategy = .pushOut
        label.toAutoLayout()
        return label
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
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .left
        label.lineBreakStrategy = .pushOut
        label.toAutoLayout()
        return label
    }()
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .green
        
        configureLayout()
    }
    
    // MARK: - Configure Layout

    private func configureLayout(){
        self.separatorInset = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
        contentView.addSubview(backgroundLabel)
        backgroundLabel.addSubview(topStackView)
//        frameLabel.addSubview(topStackView)
        topStackView.addArrangedSubview(dateLabel)
        topStackView.addArrangedSubview(timeLabel)
        backgroundLabel.addSubview(bottomStackView)
        bottomStackView.addArrangedSubview(infoStackView)
        infoStackView.addArrangedSubview(temperatureLabel)
        infoStackView.addArrangedSubview(weatherImage)
        bottomStackView.addArrangedSubview(detailsStackView)
        detailsStackView.addArrangedSubview(descriptionLabel)
        detailsStackView.addArrangedSubview(windLabel)
        detailsStackView.addArrangedSubview(humidityLabel)
        detailsStackView.addArrangedSubview(cloudsLabel)
        
        let constraints = [
            backgroundLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            backgroundLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            backgroundLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            backgroundLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            backgroundLabel.heightAnchor.constraint(equalToConstant: 190),
            
//            frameLabel.topAnchor.constraint(equalTo: backgroundLabel.topAnchor),
//            frameLabel.leadingAnchor.constraint(equalTo: backgroundLabel.leadingAnchor),
//            frameLabel.trailingAnchor.constraint(equalTo: backgroundLabel.trailingAnchor),
//            frameLabel.heightAnchor.constraint(equalToConstant: 170),
            
            topStackView.topAnchor.constraint(equalTo: backgroundLabel.topAnchor, constant: inset),
            topStackView.leadingAnchor.constraint(equalTo: backgroundLabel.leadingAnchor, constant: sideInset),
            topStackView.trailingAnchor.constraint(equalTo: backgroundLabel.trailingAnchor, constant: -sideInset),
            topStackView.heightAnchor.constraint(equalToConstant: 26),
            
            temperatureLabel.topAnchor.constraint(equalTo: topStackView.bottomAnchor, constant: inset),
            temperatureLabel.leadingAnchor.constraint(equalTo: backgroundLabel.leadingAnchor, constant: sideInset),
            temperatureLabel.heightAnchor.constraint(equalToConstant: 28),
            temperatureLabel.widthAnchor.constraint(equalToConstant: 50),
            
            bottomStackView.topAnchor.constraint(equalTo: topStackView.bottomAnchor, constant: inset),
            bottomStackView.leadingAnchor.constraint(equalTo: backgroundLabel.leadingAnchor, constant: sideInset),
            bottomStackView.trailingAnchor.constraint(equalTo: backgroundLabel.trailingAnchor, constant: -sideInset),
            bottomStackView.bottomAnchor.constraint(equalTo: backgroundLabel.bottomAnchor, constant: -inset),
            
//            temperatureLabel.heightAnchor.constraint(equalToConstant: 30),
//            weatherImage.heightAnchor.constraint(equalToConstant: 50)
            
        ]
            
            
        
        NSLayoutConstraint.activate(constraints)
    }
    
    // MARK: - Insets
    
    private var inset: CGFloat { return 16 }
    
    private var sideInset: CGFloat { return 30 }
    

}
