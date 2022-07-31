//
//  MainScreenView.swift
//  WeatherApp
//
//  Created by Iuliia Volkova on 28.07.2022.
//

import Foundation
import UIKit


class MainScreenView: UIViewController {
    
    
    override func viewDidLoad() {
        self.view.backgroundColor = .white
        
        configureHorizontalViewLayout()
        configureVerticalViewLayout()
    }
    
    // MARK: - Header
    
    // MARK: - horizontal scroll
    
    private let layout = UICollectionViewFlowLayout()
    private let collectionCellID = "collectionCellID"
    private lazy var oneDayWeatherCollection = UICollectionView(frame: .zero, collectionViewLayout: layout)
    
    private func configureHorizontalViewLayout(){
        view.addSubview(oneDayWeatherCollection)
        oneDayWeatherCollection.toAutoLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = CGFloat.greatestFiniteMagnitude
        oneDayWeatherCollection.dataSource = self
        oneDayWeatherCollection.delegate = self
        oneDayWeatherCollection.register(WeatherHorizontalCell.self, forCellWithReuseIdentifier: collectionCellID)
        
        
        let constraints = [
            oneDayWeatherCollection.topAnchor.constraint(equalTo: view.topAnchor),
            oneDayWeatherCollection.heightAnchor.constraint(equalToConstant: 200),
            oneDayWeatherCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            oneDayWeatherCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    // MARK: - vertical scroll
    
    private let dailyForecastTable = UITableView(frame: .zero, style: .grouped)
    private let tableCellID = "tableCellID"
    
    private func configureVerticalViewLayout(){
        view.addSubview(dailyForecastTable)
        dailyForecastTable.backgroundColor = .white
        dailyForecastTable.toAutoLayout()
        dailyForecastTable.separatorStyle = .none
        dailyForecastTable.dataSource = self
        dailyForecastTable.delegate = self
        dailyForecastTable.register(WeatherVerticalCell.self, forCellReuseIdentifier: tableCellID)
        dailyForecastTable.register(MyCustomHeader.self,
               forHeaderFooterViewReuseIdentifier: "sectionHeader")
        
        let constraints = [
            dailyForecastTable.topAnchor.constraint(equalTo: oneDayWeatherCollection.bottomAnchor, constant: 70),
            dailyForecastTable.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            dailyForecastTable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            dailyForecastTable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}


// MARK: - CollectionViewDataSource, CollectionViewDelegate
extension MainScreenView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionCellID, for: indexPath) as! WeatherHorizontalCell
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


extension MainScreenView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 25
    }
    
    func tableView(_ tableView: UITableView,
            viewForHeaderInSection section: Int) -> UIView? {
       let view = tableView.dequeueReusableHeaderFooterView(withIdentifier:
                   "sectionHeader") as! MyCustomHeader
       return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableCellID, for: indexPath) as! WeatherVerticalCell
        return cell
    }
    
}
