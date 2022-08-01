//
//  HourlyWeatherCell.swift
//  WeatherApp
//
//  Created by Iuliia Volkova on 31.07.2022.
//

import UIKit

class HourlyWeatherCell: UICollectionViewCell {
    
    private let backgroundLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.layer.cornerRadius = 22
        label.layer.masksToBounds = true
        label.layer.borderColor = CustomColors.setColor(style: .lightBlue).cgColor
        label.layer.borderWidth = 0.6
        label.toAutoLayout()
        return label
    }()
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 7
        stack.toAutoLayout()
        return stack
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.text = "12.00"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = .gray
        label.toAutoLayout()
        return label
    }()
    
    private let weatherImage: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "sun.max"))
        image.contentMode = .scaleAspectFill
        image.toAutoLayout()
        return image
    }()
    
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.text = "24°"
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        label.toAutoLayout()
        return label
    }()
        
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        contentView.backgroundColor = .clear
        contentView.addSubview(backgroundLabel)
        backgroundLabel.addSubview(stackView)
        stackView.addArrangedSubview(timeLabel)
        stackView.addArrangedSubview(weatherImage)
        stackView.addArrangedSubview(temperatureLabel)
        
        let constraints = [
            backgroundLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            backgroundLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            backgroundLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            backgroundLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            stackView.topAnchor.constraint(equalTo: backgroundLabel.topAnchor, constant: 7),
            stackView.bottomAnchor.constraint(equalTo: backgroundLabel.bottomAnchor, constant: -7),
            stackView.leadingAnchor.constraint(equalTo: backgroundLabel.leadingAnchor, constant: 5),
            stackView.trailingAnchor.constraint(equalTo: backgroundLabel.trailingAnchor, constant: -5)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }

}
