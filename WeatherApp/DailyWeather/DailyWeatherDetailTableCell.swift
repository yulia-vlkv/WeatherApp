//
//  DailyWeatherDetailTableCell.swift
//  WeatherApp
//
//  Created by Iuliia Volkova on 21.08.2022.
//

import Foundation
import UIKit


class DailyWeatherDetailTableCell: UITableViewCell {
    
    private let backgroundLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .cyan
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
    
    private let dayInfoLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = CustomColors.setColor(style: .lightBlue)
        label.layer.cornerRadius = 8
        label.clipsToBounds = true
        label.toAutoLayout()
        return label
    }()
    
    private let nightInfoLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = CustomColors.setColor(style: .deepBlue)
        label.layer.cornerRadius = 8
        label.clipsToBounds = true
        label.toAutoLayout()
        return label
    }()
    
    private let generalInfoLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = CustomColors.setColor(style: .brightOrange)
        label.layer.cornerRadius = 8
        label.clipsToBounds = true
        label.toAutoLayout()
        return label
    }()
    
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
        topStackView.addArrangedSubview(dayInfoLabel)
        topStackView.addArrangedSubview(nightInfoLabel)
        backgroundLabel.addSubview(generalInfoLabel)

        
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
            generalInfoLabel.heightAnchor.constraint(equalToConstant: self.frame.width)
        
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
