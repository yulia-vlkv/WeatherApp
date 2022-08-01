//
//  DailyWeatherCell.swift
//  WeatherApp
//
//  Created by Iuliia Volkova on 31.07.2022.
//

import UIKit

class DailyWeatherTableCell: UITableViewCell {
    
    private let backgroundLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.toAutoLayout()
        return label
    }()
    
    private let frameLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.backgroundColor = CustomColors.setColor(style: .lightBlue)
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
        label.toAutoLayout()
        return label
    }()
    
    private let leftStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 6
        stack.alignment = .center
        stack.toAutoLayout()
        return stack
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "30/07"
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .center
        label.toAutoLayout()
        return label
    }()
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 6
        stack.contentMode = .scaleAspectFit
        stack.toAutoLayout()
        return stack
    }()
    
    private let weatherImage: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "cloud.sun.rain"))
        image.contentMode = .scaleAspectFill
        image.toAutoLayout()
        return image
    }()
    
    private let humidityLabel: UILabel = {
        let label = UILabel()
        label.text = "37%"
        label.textColor = CustomColors.setColor(style: .deepBlue)
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textAlignment = .center
        label.toAutoLayout()
        return label
    }()
    
    private let detailsLabel: UILabel = {
        let label = UILabel()
        label.text = "Облачно, солнечно и дождливо"
        label.numberOfLines = 1
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .left
        label.toAutoLayout()
        return label
    }()
    
    private let rightStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10
        stack.contentMode = .scaleAspectFit
        stack.toAutoLayout()
        return stack
    }()
    
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.text = "4-11°"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.textAlignment = .center
        label.toAutoLayout()
        return label
    }()

    private let rightChevronLabel: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "chevron.right"))
        image.tintColor = .black
//        image.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        image.contentMode = .scaleAspectFit
        image.toAutoLayout()
        return image
    }()
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .clear
        
        contentView.addSubview(backgroundLabel)
        backgroundLabel.addSubview(frameLabel)
        frameLabel.addSubview(leftStackView)
        leftStackView.addArrangedSubview(dateLabel)
        leftStackView.addArrangedSubview(stackView)
        stackView.addArrangedSubview(weatherImage)
        stackView.addArrangedSubview(humidityLabel)
        frameLabel.addSubview(detailsLabel)
        frameLabel.addSubview(rightStackView)
        rightStackView.addArrangedSubview(temperatureLabel)
        rightStackView.addArrangedSubview(rightChevronLabel)
        
        let constraints = [
            backgroundLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            backgroundLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            backgroundLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            backgroundLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            backgroundLabel.heightAnchor.constraint(equalToConstant: 66),
            
            frameLabel.topAnchor.constraint(equalTo: backgroundLabel.topAnchor),
            frameLabel.heightAnchor.constraint(equalToConstant: 56),
            frameLabel.leadingAnchor.constraint(equalTo: backgroundLabel.leadingAnchor, constant: 16),
            frameLabel.trailingAnchor.constraint(equalTo: backgroundLabel.trailingAnchor, constant: -16),
            
            leftStackView.topAnchor.constraint(equalTo: frameLabel.topAnchor, constant: 6),
            leftStackView.bottomAnchor.constraint(equalTo: frameLabel.bottomAnchor, constant: -6),
            leftStackView.leadingAnchor.constraint(equalTo: frameLabel.leadingAnchor, constant: 10),
            
            detailsLabel.centerYAnchor.constraint(equalTo: frameLabel.centerYAnchor),
            detailsLabel.leadingAnchor.constraint(equalTo: leftStackView.trailingAnchor, constant: 13),
            detailsLabel.trailingAnchor.constraint(equalTo: rightStackView.leadingAnchor, constant: -13),
            
            rightStackView.centerYAnchor.constraint(equalTo: frameLabel.centerYAnchor),
            rightStackView.trailingAnchor.constraint(equalTo: frameLabel.trailingAnchor, constant: -10),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }

}
