//
//  DailyWeatherCell.swift
//  WeatherApp
//
//  Created by Iuliia Volkova on 31.07.2022.
//

import UIKit


extension DailyWeatherTableCell: ConfigurableView {
    
    func configure(with model: DailyWeatherTableCellModel) {
        dateLabel.text = model.date
        weatherImage.image = model.icon
        detailsLabel.text = model.description
        temperatureLabel.text = "\(model.nightTemperature)°-\(model.dayTemperature)°"
    }
}


class DailyWeatherTableCell: UITableViewCell {
    
    private var cells: [DailyWeatherTableCellModel] = []
    
    private let cellBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.toAutoLayout()
        return view
    }()

    private let frameView: UIView = {
        let view = UIView()
        view.backgroundColor = CustomColors.setColor(style: .lightBlue)
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        view.toAutoLayout()
        return view
    }()
    
    // MARK: - Left content
    
    private let leftStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 6
        stack.alignment = .center
        stack.toAutoLayout()
        return stack
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .center
        label.toAutoLayout()
        return label
    }()
    
    private let weatherImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.toAutoLayout()
        return image
    }()
    
    // MARK: - Middle content
    
    private let detailsLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .left
        label.toAutoLayout()
        return label
    }()
    
    // MARK: - Right content
    
    private let rightStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10
        stack.contentMode = .scaleAspectFit
        stack.alignment = .trailing
        stack.toAutoLayout()
        return stack
    }()
    
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.textAlignment = .right
        label.toAutoLayout()
        return label
    }()

    private let rightChevronLabel: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "chevron.right"))
        image.tintColor = .black
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
        
        configureLayout()
    }
    
    // MARK: - Configure Layout

    private func configureLayout(){
        contentView.addSubview(cellBackgroundView)
        cellBackgroundView.addSubview(frameView)
        frameView.addSubview(leftStackView)
        leftStackView.addArrangedSubview(dateLabel)
        leftStackView.addArrangedSubview(weatherImage)
        frameView.addSubview(detailsLabel)
        frameView.addSubview(rightStackView)
        rightStackView.addArrangedSubview(temperatureLabel)
        rightStackView.addArrangedSubview(rightChevronLabel)
        
        let constraints = [
            cellBackgroundView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            cellBackgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cellBackgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cellBackgroundView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            cellBackgroundView.heightAnchor.constraint(equalToConstant: backgroundHeight),
            
            frameView.topAnchor.constraint(equalTo: cellBackgroundView.topAnchor),
            frameView.heightAnchor.constraint(equalToConstant: labelHeight),
            frameView.leadingAnchor.constraint(equalTo: cellBackgroundView.leadingAnchor, constant: sideInset),
            frameView.trailingAnchor.constraint(equalTo: cellBackgroundView.trailingAnchor, constant: -sideInset),
            
            leftStackView.centerYAnchor.constraint(equalTo: frameView.centerYAnchor),
            leftStackView.leadingAnchor.constraint(equalTo: frameView.leadingAnchor, constant: smallSideInset),
            leftStackView.widthAnchor.constraint(equalToConstant: 50),
            
            detailsLabel.centerYAnchor.constraint(equalTo: frameView.centerYAnchor),
            detailsLabel.leadingAnchor.constraint(equalTo: leftStackView.trailingAnchor, constant: regularSideInset),
            detailsLabel.trailingAnchor.constraint(equalTo: rightStackView.leadingAnchor, constant: -regularSideInset),
            
            rightStackView.centerYAnchor.constraint(equalTo: frameView.centerYAnchor),
            rightStackView.trailingAnchor.constraint(equalTo: frameView.trailingAnchor, constant: -smallSideInset),
            
            rightChevronLabel.widthAnchor.constraint(equalToConstant: 30)
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


