//
//  WeatherTableHeader.swift
//  WeatherApp
//
//  Created by Iuliia Volkova on 31.07.2022.
//

import UIKit

class MyCustomHeader: UITableViewHeaderFooterView {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Ежедневный прогноз"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.toAutoLayout()
        return label
    }()
    
    private let toDetailsButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 16, weight: .regular),
            .foregroundColor: UIColor.black,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        let attributedString = NSMutableAttributedString(
            string: "25 дней",
            attributes: attributes
        )
        button.setAttributedTitle(attributedString, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        button.contentHorizontalAlignment = .right
        button.toAutoLayout()
        button.addTarget(self, action: #selector(buttonIsTapped), for: .touchUpInside)
        return button
    }()
    
    @objc func buttonIsTapped(){
        print("button is tapped")
    }

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureContents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureContents() {
        contentView.backgroundColor = .white
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(toDetailsButton)

        let constraints = [
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            toDetailsButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            toDetailsButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }

}