//
//  HourlyWeatherCell.swift
//  WeatherApp
//
//  Created by Iuliia Volkova on 31.07.2022.
//

import UIKit


extension HourlyWeatherCell: ConfigurableView {
    
    func configure(with model: HourlyWeatherCellModel) {
        timeLabel.text = model.time
        weatherImage.image = model.icon
        temperatureLabel.text = "\(model.temperature)°"
    }
}


class HourlyWeatherCell: UICollectionViewCell {
    
    private let cellBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = CustomColors.setColor(style: .lightBlue)
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        view.toAutoLayout()
        return view
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
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = .gray
        label.toAutoLayout()
        return label
    }()
    
    private let weatherImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.toAutoLayout()
        return image
    }()
    
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textAlignment = .center
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
        contentView.addSubview(cellBackgroundView)
        cellBackgroundView.addSubview(stackView)
        stackView.addArrangedSubview(timeLabel)
        stackView.addArrangedSubview(weatherImage)
        stackView.addArrangedSubview(temperatureLabel)
        
        let constraints = [
            cellBackgroundView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            cellBackgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cellBackgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cellBackgroundView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            stackView.topAnchor.constraint(equalTo: cellBackgroundView.topAnchor, constant: topBottomInset),
            stackView.bottomAnchor.constraint(equalTo: cellBackgroundView.bottomAnchor, constant: -topBottomInset),
            stackView.leadingAnchor.constraint(equalTo: cellBackgroundView.leadingAnchor, constant: sideInset),
            stackView.trailingAnchor.constraint(equalTo: cellBackgroundView.trailingAnchor, constant: -sideInset)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    // MARK: - Insets
    
    private var sideInset: CGFloat { return 5 }
    
    private var topBottomInset: CGFloat { return 7 }

}
