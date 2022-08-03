//
//  MainInfoTableCell.swift
//  WeatherApp
//
//  Created by Iuliia Volkova on 31.07.2022.
//

import UIKit

class MainInfoTableCell: UITableViewCell {

    private let layout = UICollectionViewFlowLayout()
    private let collectionCellID = "CellID"
    
    private lazy var mainInfoCollection = UICollectionView(frame: .zero,
                                                           collectionViewLayout: layout)
    
    private lazy var pageControl: UIPageControl = {
        let control = UIPageControl()
        control.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        control.isUserInteractionEnabled = true
        control.hidesForSinglePage = true
        control.currentPageIndicatorTintColor = .systemBlue
        control.pageIndicatorTintColor = .systemGray5
        control.addTarget(self,
                          action: #selector(pageControlDidChange(_:)),
                          for: .valueChanged)
        control.toAutoLayout()
        return control
    }()
    
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
        contentView.addSubview(pageControl)
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
            pageControl.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: topInset),
            pageControl.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            mainInfoCollection.topAnchor.constraint(equalTo: pageControl.bottomAnchor, constant: topInset * 2),
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
        let count = 4
        pageControl.numberOfPages = count
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionCellID, for: indexPath) as! MainInfoCell
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
    
// MARK: - UIScrollViewDelegate

extension MainInfoTableCell: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

        pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }

    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {

        pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
       let witdh = scrollView.frame.width - (scrollView.contentInset.left*2)
       let index = (scrollView.contentOffset.x) / witdh
       let roundedIndex = round(index)
       self.pageControl.currentPage = Int(roundedIndex)
   }
}

