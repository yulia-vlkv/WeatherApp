//
//  DailyWeatherView.swift
//  WeatherApp
//
//  Created by Iuliia Volkova on 21.08.2022.
//

import Foundation
import UIKit

class DailyWeatherView: UIViewController {
    
    private let tableView = UITableView(frame: .zero, style: .grouped)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        configureNavigationBar()
    }
    
    // MARK: - Configure TableView
    
    private func configureTableView(){
        view.addSubview(tableView)
        tableView.backgroundColor = .white
        tableView.toAutoLayout()
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(DateScrollTableCell.self, forCellReuseIdentifier: String(describing: DateScrollTableCell.self))
        tableView.register(DailyWeatherDetailTableCell.self, forCellReuseIdentifier: String(describing: DailyWeatherDetailTableCell.self))
        tableView.register(WeatherTableHeader.self,
               forHeaderFooterViewReuseIdentifier: "sectionHeader")
        
        let constraints = [
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    // MARK: - move to MainCoordinator
    private func configureNavigationBar(){
        
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.backgroundColor = .white
        navigationItem.title = "Город, страна"
        navigationController?.navigationBar.tintColor = .black
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        navigationController?.navigationBar.scrollEdgeAppearance  = appearance
        navigationController?.navigationBar.standardAppearance  = appearance

    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension DailyWeatherView: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView,
                   viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "sectionHeader") as! WeatherTableHeader
            view.titleLabel.text = "Страна, город"
            return view
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 40
        default:
            return 20
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DateScrollTableCell.self), for: indexPath) as! DateScrollTableCell
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DailyWeatherDetailTableCell.self), for: indexPath) as! DailyWeatherDetailTableCell
            return cell
        }
    }
}

