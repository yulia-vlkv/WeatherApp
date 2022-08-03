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
        
        configureLayout()
    }
    
    // MARK: - Configure Layout

    private func configureLayout(){
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
            oneDayWeatherCollection.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: sideInset),
            oneDayWeatherCollection.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            oneDayWeatherCollection.heightAnchor.constraint(equalToConstant: height)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    // MARK: - Insets
    
    private var height: CGFloat { return 83 }
    
    private var width: CGFloat { return 42 }
    
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
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return inset
    }
    
}
