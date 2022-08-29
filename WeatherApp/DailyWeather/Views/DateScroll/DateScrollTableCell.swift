//
//  DateScrollTableCell.swift
//  WeatherApp
//
//  Created by Iuliia Volkova on 21.08.2022.
//

import Foundation
import UIKit


extension DateScrollTableCell: ConfigurableView {
    
    func configure(with model: DateScrollTableCellModel) {
        self.cells = model.cells
        self.dailyWeatherCollection.reloadData()
    }
}

class DateScrollTableCell: UITableViewCell {
    
    private var cells: [DateScrollCellModel] = []
    
    private let layout = UICollectionViewFlowLayout()
    private let collectionCellID = "collectionCellID"
    private lazy var dailyWeatherCollection = UICollectionView(frame: .zero, collectionViewLayout: layout)
    
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
        contentView.addSubview(dailyWeatherCollection)
        dailyWeatherCollection.toAutoLayout()
        dailyWeatherCollection.showsHorizontalScrollIndicator = false
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = CGFloat.greatestFiniteMagnitude
        dailyWeatherCollection.dataSource = self
        dailyWeatherCollection.delegate = self
        dailyWeatherCollection.register(DateScrollCell.self, forCellWithReuseIdentifier: collectionCellID)
        
        let constraints = [
            dailyWeatherCollection.topAnchor.constraint(equalTo: contentView.topAnchor),
            dailyWeatherCollection.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            dailyWeatherCollection.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: sideInset),
            dailyWeatherCollection.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            dailyWeatherCollection.heightAnchor.constraint(equalToConstant: height)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    // MARK: - Insets
    
    private var height: CGFloat { return 50 }
    
    private var width: CGFloat { return 80 }
    
    private var sideInset: CGFloat { return 16 }
    
    private var inset: CGFloat { return 8 }

}


// MARK: - CollectionViewDataSource, CollectionViewDelegate

extension DateScrollTableCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionCellID, for: indexPath) as! DateScrollCell
        if indexPath.item < cells.count {
            let model = cells[indexPath.item]
            cell.configure(with: model)
        }
        cell.backgroundColor = .clear
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return inset
    }
    
}
