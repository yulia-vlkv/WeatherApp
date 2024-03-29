//
//  DateScrollCell.swift
//  WeatherApp
//
//  Created by Iuliia Volkova on 21.08.2022.
//

import Foundation
import UIKit


extension DateScrollCell: ConfigurableView {

    public func configure(with model: DateScrollCellModel) {

        dateLabel.text = model.date
    }
}

class DateScrollCell: UICollectionViewCell {
    
//    override var isSelected: Bool {
//        didSet {
//            self.dateLabel.backgroundColor = isSelected ? CustomColors.setColor(style: .deepBlue) : CustomColors.setColor(style: .lightBlue)
//        }
//    }
    
//    override func updateConfiguration(using state: UICellConfigurationState) {
//        if state.isSelected {
//            self.dateLabel.backgroundColor = CustomColors.setColor(style: .deepBlue)
//            print("selected")
//        } else {
//            self.dateLabel.backgroundColor = CustomColors.setColor(style: .lightBlue)
//            print("deselected")
//        }
//        super.updateConfiguration(using:state)
//    }
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.backgroundColor = CustomColors.setColor(style: .lightBlue)
        label.layer.cornerRadius = 12
        label.clipsToBounds = true
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
        configureLayout()
        
    }
    
    // MARK: - Configure Layout

    private func configureLayout(){
        
        contentView.addSubview(dateLabel)
        
        let constraints = [
            dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    // MARK: - Insets
    
    private var inset: CGFloat { return (contentView.layer.frame.width / 10) - 15 }
    
    private var bottomInset: CGFloat { return 25 }
    
}

