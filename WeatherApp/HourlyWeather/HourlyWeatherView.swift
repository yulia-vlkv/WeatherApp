//
//  HourlyWeatherView.swift
//  WeatherApp
//
//  Created by Iuliia Volkova on 07.08.2022.
//

import Foundation
import UIKit


extension HourlyWeatherView: ConfigurableView {
    
    func configure(with model: HourlyWeatherViewModel) {
        navigationItem.title = model.city
        
        tableView.reloadData()
    }
}


class HourlyWeatherView: UIViewController {
    
    public var model: HourlyWeatherViewModel?
    
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
//        tableView.separatorStyle = .none
        tableView.separatorColor = CustomColors.setColor(style: .deepBlue)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(WeatherChartTableCell.self, forCellReuseIdentifier: String(describing: WeatherChartTableCell.self))
        tableView.register(HourlyWeatherDetailsTableCell.self, forCellReuseIdentifier: String(describing: HourlyWeatherDetailsTableCell.self))
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

extension HourlyWeatherView: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return 8
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
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: WeatherChartTableCell.self), for: indexPath) as! WeatherChartTableCell
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HourlyWeatherDetailsTableCell.self), for: indexPath) as! HourlyWeatherDetailsTableCell
            tableView.separatorStyle = .singleLine
            return cell
        }
    }
}

