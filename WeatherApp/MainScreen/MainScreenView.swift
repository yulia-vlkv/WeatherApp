//
//  MainScreenView.swift
//  WeatherApp
//
//  Created by Iuliia Volkova on 31.07.2022.
//


import UIKit


extension MainScreenView: ConfigurableView {
    
    func configure(with model: MainScreenViewModel) {
        navigationItem.title = model.city
        
        mainTableView.reloadData()
    }
}


class MainScreenView: UIViewController {
    
    public var model: MainScreenViewModel!
    
    private var cells: [DailyWeatherTableCellModel] = []

    private let mainTableView = UITableView(frame: .zero, style: .grouped)

    override func viewDidLoad() {
        super.viewDidLoad()

        configureTableView()
        configureNavigationBar()
        
        model.onViewDidLoad()
    }
    
    // MARK: - Configure TableView
    
    private func configureTableView(){
        view.addSubview(mainTableView)
        mainTableView.backgroundColor = .white
        mainTableView.toAutoLayout()
        mainTableView.showsVerticalScrollIndicator = false
        mainTableView.separatorStyle = .none
        mainTableView.dataSource = self
        mainTableView.delegate = self
        mainTableView.register(DailyWeatherTableCell.self, forCellReuseIdentifier: String(describing: DailyWeatherTableCell.self))
        mainTableView.register(HourlyWeatherTableCell.self, forCellReuseIdentifier: String(describing: HourlyWeatherTableCell.self))
        mainTableView.register(MainInfoTableCell.self, forCellReuseIdentifier: String(describing: MainInfoTableCell.self))
        mainTableView.register(WeatherTableHeader.self,
               forHeaderFooterViewReuseIdentifier: "sectionHeader")
        
        let constraints = [
            mainTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mainTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func configureNavigationBar(){
        
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .black

        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal"),
                                                            style: .plain,
                                                            target: self,
                                                            action:  #selector(toSettings))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "map.fill"),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(toLocationSelection))
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        navigationController?.navigationBar.scrollEdgeAppearance  = appearance
        navigationController?.navigationBar.standardAppearance  = appearance

    }
    
    
    @objc private func toSettings(){
        model.showSettings()
    }
    
    @objc private func toLocationSelection(){
        model.showLocationSelection()
    }
    
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension MainScreenView: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return model.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionModel = model.sections[section]
        switch sectionModel{
        case .basic(let items):
            return items.count
        case .withHeader(_, let items):
            return items.count
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionModel = model.sections[section]
        switch sectionModel{
        case .withHeader(let header, _):
            let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "sectionHeader") as! WeatherTableHeader
            view.configure(with: header)
            return view
        default:
           return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let sectionModel = model.sections[section]
        switch sectionModel{
        case .withHeader:
            return 40
        default:
           return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionModel = model.sections[indexPath.section]
        switch sectionModel{
        case .basic(let items):
            return cellForItem(items[indexPath.row], indexPath: indexPath, tableView: tableView)
        case .withHeader(_, let items):
            return cellForItem(items[indexPath.row], indexPath: indexPath, tableView: tableView)
        }
    }
    
    private func cellForItem(_ item: MainScreenDataSourceItem, indexPath: IndexPath, tableView: UITableView) -> UITableViewCell {
        switch item {
        case .currentWeatherCard(let cellModel):
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MainInfoTableCell.self), for: indexPath) as! MainInfoTableCell
            cell.configure(with: cellModel)
            return cell
        case .hourlyWeather(let cellModel):
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HourlyWeatherTableCell.self), for: indexPath) as! HourlyWeatherTableCell
            cell.selectionStyle = .none
            cell.configure(with: cellModel)
            return cell
        case .dailyWeather(let cellModel):
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DailyWeatherTableCell.self), for: indexPath) as! DailyWeatherTableCell
            cell.configure(with: cellModel)
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sectionModel = model.sections[indexPath.section]
        switch sectionModel {
        case .withHeader(_, let items), .basic(let items):
            if case let .dailyWeather(model) = items[indexPath.row] {
                model.onSelect?()
            }
        }
//        let sectionModel = model.sections[section]
//        switch sectionModel{
//
//        if indexPath.item < cells.count {
//            let model = cells[indexPath.row]
//            model.onSelect?()
//        }
    }
}


