//
//  MainInfoTableCell.swift
//  WeatherApp
//
//  Created by Iuliia Volkova on 31.07.2022.
//

import UIKit


extension MainInfoTableCell: ConfigurableView {
    
    func configure(with model: MainInfoTableCellModel) {
        self.cells = model.cells
        self.mainInfoCollection.reloadData()
    }
}


class MainInfoTableCell: UITableViewCell {

    private var cells: [MainInfoCellModel] = []
    
    private let layout = UICollectionViewFlowLayout()
    private let collectionCellID = "CellID"
    
    private lazy var mainInfoCollection = UICollectionView(frame: .zero,
                                                           collectionViewLayout: layout)
    
    @objc private func pageControlDidChange(_ sender: UIPageControl) {
        let current = sender.currentPage
        mainInfoCollection.setContentOffset(CGPoint(x: CGFloat(current) * (contentView.frame.size.width - 32),
                                                    y: 0),
                                            animated: true)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
 
        contentView.backgroundColor = .white
        configureLayout()
    }
    
    // MARK: - Configure Layout

    private func configureLayout(){
        contentView.addSubview(mainInfoCollection)
        
        mainInfoCollection.toAutoLayout()
        mainInfoCollection.isPagingEnabled = true
        mainInfoCollection.showsHorizontalScrollIndicator = false
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = CGFloat.greatestFiniteMagnitude
        mainInfoCollection.dataSource = self
        mainInfoCollection.delegate = self
        mainInfoCollection.register(MainInfoCell.self, forCellWithReuseIdentifier: collectionCellID)
        
        let constraints = [
            
            mainInfoCollection.topAnchor.constraint(equalTo: contentView.topAnchor, constant: topInset * 2),
            mainInfoCollection.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            mainInfoCollection.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: sideInset),
            mainInfoCollection.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -sideInset),
            mainInfoCollection.heightAnchor.constraint(equalToConstant: height)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    // MARK: - Insets
    
    private var minInset: CGFloat { return 0 }
    
    private var height: CGFloat { return 212 }
    
    private var sideInset: CGFloat { return 16 }
    
    private var topInset: CGFloat { return 10 }
    
}


// MARK: - CollectionViewDataSource, CollectionViewDelegate

extension MainInfoTableCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = cells.count
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionCellID, for: indexPath) as! MainInfoCell
        if indexPath.item < cells.count {
            let model = cells[indexPath.item]
            cell.configure(with: model)
        }
        cell.backgroundColor = .white
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: contentView.frame.width - sideInset * 2, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return minInset
    }
    
}
