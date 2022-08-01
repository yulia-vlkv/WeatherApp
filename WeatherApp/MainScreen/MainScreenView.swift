//
//  MainScreenView.swift
//  WeatherApp
//
//  Created by Iuliia Volkova on 31.07.2022.
//

import UIKit

class MainScreenView: UIViewController {
    
    private let mainTableView = UITableView(frame: .zero, style: .grouped)
//    private let tableCellID = "tableCellID"

    override func viewDidLoad() {
        super.viewDidLoad()

        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureTableView()
    }
    
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
        mainTableView.register(MyCustomHeader.self,
               forHeaderFooterViewReuseIdentifier: "sectionHeader")
        
        let constraints = [
            mainTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mainTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
}

extension MainScreenView: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        default:
            return 25
        }
    }
    
    func tableView(_ tableView: UITableView,
                   viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 1:
            let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "sectionHeader") as! MyCustomHeader
            let attributes: [NSAttributedString.Key: Any] = [.underlineStyle: NSUnderlineStyle.single.rawValue]
            let attributedString = NSMutableAttributedString(
                string: "Подробнее на 24 часа",
                attributes: attributes
            )
            view.toDetailsButton.setAttributedTitle(attributedString, for: .normal)
            return view
        case 2:
            let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "sectionHeader") as! MyCustomHeader
            view.titleLabel.text = "Ежедневный прогноз"
            let attributes: [NSAttributedString.Key: Any] = [.underlineStyle: NSUnderlineStyle.single.rawValue]
            let attributedString = NSMutableAttributedString(
                string: "25 дней",
                attributes: attributes
            )
            view.toDetailsButton.setAttributedTitle(attributedString, for: .normal)
            return view
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MainInfoTableCell.self), for: indexPath) as! MainInfoTableCell
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HourlyWeatherTableCell.self), for: indexPath) as! HourlyWeatherTableCell
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DailyWeatherTableCell.self), for: indexPath) as! DailyWeatherTableCell
            return cell
        }
    }
    
}

