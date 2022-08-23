//
//  HourlyWeatherTableCell.swift
//  WeatherApp
//
//  Created by Iuliia Volkova on 31.07.2022.
//

import UIKit

class HourlyWeatherTableCell: UITableViewCell {
    
    private var cells: [HourlyWeatherCellModel] = []
    
    private let layout = UICollectionViewFlowLayout()
    private let collectionCellID = "collectionCellID"
    private lazy var hourlyWeatherCollection = UICollectionView(frame: .zero, collectionViewLayout: layout)
    
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
        contentView.addSubview(hourlyWeatherCollection)
        hourlyWeatherCollection.toAutoLayout()
        hourlyWeatherCollection.showsHorizontalScrollIndicator = false
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = CGFloat.greatestFiniteMagnitude
        hourlyWeatherCollection.dataSource = self
        hourlyWeatherCollection.delegate = self
        hourlyWeatherCollection.register(HourlyWeatherCell.self, forCellWithReuseIdentifier: collectionCellID)
        
        let constraints = [
            hourlyWeatherCollection.topAnchor.constraint(equalTo: contentView.topAnchor),
            hourlyWeatherCollection.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            hourlyWeatherCollection.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: sideInset),
            hourlyWeatherCollection.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            hourlyWeatherCollection.heightAnchor.constraint(equalToConstant: height)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    // MARK: - Insets
    
    private var height: CGFloat { return 83 }
    
    private var width: CGFloat { return 48 }
    
    private var sideInset: CGFloat { return 16 }
    
    private var inset: CGFloat { return 8 }

}


// MARK: - CollectionViewDataSource, CollectionViewDelegate

extension HourlyWeatherTableCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionCellID, for: indexPath) as! HourlyWeatherCell
        if indexPath.item < cells.count {
            let model = cells[indexPath.item]
            cell.configure(with: model)
        }
//        cell.backgroundColor = CustomColors.setColor(style: .lightBlue)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return inset
    }
    
}


extension HourlyWeatherTableCell: ConfigurableView {
    
    func configure(with model: HourlyWeatherTableCellModel) {
        self.cells = model.cells
        self.hourlyWeatherCollection.reloadData()
    }
}
