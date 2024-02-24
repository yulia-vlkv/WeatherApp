//
//  DailyWeatherView.swift
//  WeatherApp
//
//  Created by Iuliia Volkova on 21.08.2022.
//

import Foundation
import UIKit


extension DailyWeatherView: ConfigurableView {
    
    func configure(with model: DailyWeatherViewModel) {
//        navigationItem.title = model.city
        
        tableView.reloadData()
    }
}

class DailyWeatherView: UIViewController {
    
    public var model: DailyWeatherViewModel!
    
    private let tableView = UITableView(frame: .zero, style: .grouped)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        configureNavigationBar()
        self.model.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(true)
        
       // Set isSelected ot true for firstItem
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
        return model.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let sectionModel = model.sections[section]
        switch sectionModel{
        case .dateScroll, .dailyWeatherDetails:
            return 1
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionModel = model.sections[indexPath.section]
        switch sectionModel{
        case .dateScroll(let cellModel):
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DateScrollTableCell.self), for: indexPath) as! DateScrollTableCell
            cell.configure(with: cellModel)
            return cell
        case .dailyWeatherDetails(let cellModel):
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DailyWeatherDetailTableCell.self), for: indexPath) as! DailyWeatherDetailTableCell
            cell.configure(with: cellModel)
            return cell
        }
    }
   
}

