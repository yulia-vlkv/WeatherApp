//
//  MainInfoCell.swift
//  WeatherApp
//
//  Created by Iuliia Volkova on 31.07.2022.
//

import UIKit

class MainInfoCell: UICollectionViewCell {
    
    private let backgroundLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = CustomColors.setColor(style: .deepBlue)
        label.layer.cornerRadius = 22
        label.layer.masksToBounds = true
        label.toAutoLayout()
        return label
    }()
    
    private let contentStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 7
        stack.toAutoLayout()
        return stack
    }()
    
    private let generalTemperatureLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.text = "7°/13°"
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .white
        label.toAutoLayout()
        return label
    }()
    
    private let currentTemperatureLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.text = "13°"
        label.font = UIFont.systemFont(ofSize: 36, weight: .medium)
        label.textColor = .white
        label.toAutoLayout()
        return label
    }()
    
    private let commentLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.numberOfLines = 1
        label.text = "Возможен небольшой дождь"
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .white
        label.toAutoLayout()
        return label
    }()
    
    private let detailsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        stack.distribution = .equalSpacing
        stack.toAutoLayout()
        return stack
    }()
    
    private let cloudsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 2
        stack.toAutoLayout()
        return stack
    }()
    
    private let cloudsImage: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "cloud"))
        image.contentMode = .scaleAspectFill
        image.toAutoLayout()
        return image
    }()
    
    private let cloudsLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 11, weight: .regular)
        label.textAlignment = .center
        label.toAutoLayout()
        return label
    }()
    
    private let windStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 2
        stack.toAutoLayout()
        return stack
    }()
    
    private let windImage: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "wind"))
        image.contentMode = .scaleAspectFill
        image.toAutoLayout()
        return image
    }()
    
    private let windLabel: UILabel = {
        let label = UILabel()
        label.text = "3 м/с"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 11, weight: .regular)
        label.textAlignment = .center
        label.toAutoLayout()
        return label
    }()
    
    private let humidityStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 2
        stack.toAutoLayout()
        return stack
    }()
    
    private let humidityImage: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "humidity"))
        image.contentMode = .scaleAspectFill
        image.toAutoLayout()
        return image
    }()
    
    private let humidityLabel: UILabel = {
        let label = UILabel()
        label.text = "75%"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 11, weight: .regular)
        label.textAlignment = .center
        label.toAutoLayout()
        return label
    }()
    
    private func drawSemicircle() {
        let path = UIBezierPath(arcCenter: CGPoint(x: (contentView.layer.frame.width) / 2, y: 140), radius: (contentView.layer.frame.width / 3), startAngle: -CGFloat.pi, endAngle: 0, clockwise: true)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = CustomColors.setColor(style: .brightYellow).cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 3
        
        backgroundLabel.layer.addSublayer(shapeLayer)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)

        contentView.backgroundColor = .clear
        contentView.addSubview(backgroundLabel)
        drawSemicircle()
        backgroundLabel.addSubview(contentStack)
        contentStack.addArrangedSubview(generalTemperatureLabel)
        contentStack.addArrangedSubview(currentTemperatureLabel)
        contentStack.addArrangedSubview(commentLabel)
        contentStack.addArrangedSubview(detailsStack)
        detailsStack.addArrangedSubview(cloudsStack)
        cloudsStack.addArrangedSubview(cloudsImage)
        cloudsStack.addArrangedSubview(cloudsLabel)
        detailsStack.addArrangedSubview(windStack)
        windStack.addArrangedSubview(windImage)
        windStack.addArrangedSubview(windLabel)
        detailsStack.addArrangedSubview(humidityStack)
        humidityStack.addArrangedSubview(humidityImage)
        humidityStack.addArrangedSubview(humidityLabel)
        
//        contentStack.addArrangedSubview(contentStack)
        
 
        let constraints = [
            backgroundLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            backgroundLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            backgroundLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            backgroundLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }

}
