//
//  HourlyWeatherDetailsTableCell.swift
//  WeatherApp
//
//  Created by Iuliia Volkova on 07.08.2022.
//

import UIKit


extension HourlyWeatherDetailsTableCell: ConfigurableView {
    
    func configure(with model: HourlyWeatherDetailsTableCellModel) {
        
        dateLabel.text = model.date
        timeLabel.text = model.time
        temperatureLabel.text = "\(model.currentTemperature)°"
        weatherImage.image = model.icon
        descriptionLabel.attributedText = {
            let text = "\(model.description). По ощущениям \(model.feelsLikeTemperature)°"
            let textToHighlight = "\(model.feelsLikeTemperature)°"
            let range = (text as NSString).range(of: textToHighlight)
            let mutableAttributedString = NSMutableAttributedString.init(string: text)
            mutableAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: CustomColors.setColor(style: .deepBlue), range: range)
            return mutableAttributedString
        }()
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
        
    }
    
}


class HourlyWeatherDetailsTableCell: UITableViewCell {
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillProportionally
        stack.spacing = 15
        stack.backgroundColor = CustomColors.setColor(style: .lightBlue)
        stack.layoutMargins = UIEdgeInsets(top: 16, left: 30, bottom: 16, right: 30)
        stack.isLayoutMarginsRelativeArrangement = true
        stack.toAutoLayout()
        return stack
    }()
    
    private let dateStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fillProportionally
        stack.layoutMargins = UIEdgeInsets(top: 15, left: 0, bottom: 15, right: 0)
        stack.isLayoutMarginsRelativeArrangement = true
        stack.toAutoLayout()
        return stack
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.textAlignment = .center
        label.toAutoLayout()
        return label
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.textAlignment = .center
        label.toAutoLayout()
        return label
    }()
    
    private let infoStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fillProportionally
        stack.layoutMargins = UIEdgeInsets(top: 15, left: 0, bottom: 15, right: 0)
        stack.isLayoutMarginsRelativeArrangement = true
        stack.toAutoLayout()
        return stack
    }()
    
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.textColor = .black
        label.toAutoLayout()
        return label
    }()
    
    private let weatherImage: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
//        image.frame.size = CGSize(width: 50, height: 50)
        image.contentMode = .scaleAspectFit
        image.toAutoLayout()
        return image
    }()
    
    
    private let detailsStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.spacing = 10
        stack.toAutoLayout()
        return stack
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.numberOfLines = 3
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .left
        label.lineBreakStrategy = .pushOut
        label.toAutoLayout()
        return label
    }()
    
    private let windLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
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
        contentView.addSubview(stackView)
//        backgroundLabel.addSubview(stackView)
        
        stackView.addArrangedSubview(dateStackView)
        dateStackView.addArrangedSubview(dateLabel)
        dateStackView.addArrangedSubview(timeLabel)
        
        stackView.addArrangedSubview(detailsStackView)
        detailsStackView.addArrangedSubview(descriptionLabel)
        detailsStackView.addArrangedSubview(windLabel)
        detailsStackView.addArrangedSubview(humidityLabel)
        detailsStackView.addArrangedSubview(cloudsLabel)
        
        stackView.addArrangedSubview(infoStackView)
        infoStackView.addArrangedSubview(temperatureLabel)
        infoStackView.addArrangedSubview(weatherImage)

        
        let constraints = [
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            stackView.heightAnchor.constraint(equalToConstant: height),
            
            dateStackView.widthAnchor.constraint(equalToConstant: 50),
            infoStackView.widthAnchor.constraint(equalToConstant: 50)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    // MARK: - Insets
    
    private var inset: CGFloat { return 16 }
    
    private var sideInset: CGFloat { return 30 }
    
    private var height: CGFloat { return 210 }
    

}
