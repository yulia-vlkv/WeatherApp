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
//        navigationItem.title = model.city
        
        tableView.reloadData()
    }
}


class HourlyWeatherView: UIViewController {
    
    public var model: HourlyWeatherViewModel!
    
    private let tableView = UITableView(frame: .zero, style: .grouped)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        configureNavigationBar()
        model.viewDidLoad()
    }
    
    // MARK: - Configure TableView
    
    private func configureTableView(){
        view.addSubview(tableView)
        tableView.backgroundColor = .white
        tableView.toAutoLayout()
        tableView.showsVerticalScrollIndicator = false
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
        return model.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let sectionModel = model.sections[section]
        switch sectionModel{
        case .temperatureChart(let items):
            if items.isEmpty {
                return 0
            } else {
                return 1
            }
        case .hourlyWeatherDetails(let items):
            return  items.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionModel = model.sections[indexPath.section]
        switch sectionModel{
        case .temperatureChart(let points):
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: WeatherChartTableCell.self), for: indexPath) as! WeatherChartTableCell
            cell.configure(with: WeatherChartTableCellModel(points: points))
            return cell
        case .hourlyWeatherDetails(let items):
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HourlyWeatherDetailsTableCell.self), for: indexPath) as! HourlyWeatherDetailsTableCell
            cell.configure(with: items[indexPath.row])
            return cell
        }
    }
    
}

