//
//  WeatherVerticalCell.swift
//  WeatherApp
//
//  Created by Iuliia Volkova on 31.07.2022.
//

import UIKit

class WeatherVerticalCell: UITableViewCell {
    
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

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .clear
        
        contentView.addSubview(backgroundLabel)
        backgroundLabel.addSubview(frameLabel)
        
        let constraints = [
            backgroundLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            backgroundLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            backgroundLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            backgroundLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            backgroundLabel.heightAnchor.constraint(equalToConstant: 66),
            
            frameLabel.topAnchor.constraint(equalTo: backgroundLabel.topAnchor),
            frameLabel.heightAnchor.constraint(equalToConstant: 56),
            frameLabel.leadingAnchor.constraint(equalTo: backgroundLabel.leadingAnchor),
            frameLabel.trailingAnchor.constraint(equalTo: backgroundLabel.trailingAnchor),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }

}
