//
//  HourlyWeatherTableCell.swift
//  WeatherApp
//
//  Created by Iuliia Volkova on 31.07.2022.
//

import UIKit

class HourlyWeatherTableCell: UITableViewCell {
    
    private let layout = UICollectionViewFlowLayout()
    private let collectionCellID = "collectionCellID"
    private lazy var oneDayWeatherCollection = UICollectionView(frame: .zero, collectionViewLayout: layout)
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .clear
        contentView.addSubview(oneDayWeatherCollection)
        oneDayWeatherCollection.toAutoLayout()
        oneDayWeatherCollection.showsHorizontalScrollIndicator = false
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = CGFloat.greatestFiniteMagnitude
        oneDayWeatherCollection.dataSource = self
        oneDayWeatherCollection.delegate = self
        oneDayWeatherCollection.register(HourlyWeatherCell.self, forCellWithReuseIdentifier: collectionCellID)
        
        let constraints = [
            oneDayWeatherCollection.topAnchor.constraint(equalTo: contentView.topAnchor),
            oneDayWeatherCollection.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            oneDayWeatherCollection.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            oneDayWeatherCollection.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            oneDayWeatherCollection.heightAnchor.constraint(equalToConstant: 83)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }

}


// MARK: - CollectionViewDataSource, CollectionViewDelegate
extension HourlyWeatherTableCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionCellID, for: indexPath) as! HourlyWeatherCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 42, height: 83)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return inset
    }
    
    private var inset: CGFloat {return 8}
    
}
