//
//  WeatherTableHeader.swift
//  WeatherApp
//
//  Created by Iuliia Volkova on 31.07.2022.
//

import UIKit


struct WeatherTableHeaderModel {
    
    let titleText: String?
    let buttonText: String
    
}


class WeatherTableHeader: UITableViewHeaderFooterView {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.toAutoLayout()
        return label
    }()
    
    let toDetailsButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
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
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: sideInset),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            toDetailsButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -sideInset),
            toDetailsButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private var sideInset: CGFloat { return 16 }

}

extension WeatherTableHeader: ConfigurableView {
    
    func configure(with model: WeatherTableHeaderModel) {
        let attributes: [NSAttributedString.Key: Any] = [.underlineStyle: NSUnderlineStyle.single.rawValue]
                    let attributedString = NSMutableAttributedString(
                        string: model.buttonText,
                        attributes: attributes
                    )
                    toDetailsButton.setAttributedTitle(attributedString, for: .normal)
        
        titleLabel.text = model.titleText
    }
}
