//
//  WeatherChartTableCell.swift
//  WeatherApp
//
//  Created by Iuliia Volkova on 07.08.2022.
//

import UIKit


extension WeatherChartTableCell: ConfigurableView {
    
    func configure(with model: WeatherChartTableCellModel) {
        self.lineChartView.configure(with: model.points)
    }
}


class WeatherChartTableCell: UITableViewCell {
    
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = CustomColors.setColor(style: .lightBlue)
        view.toAutoLayout()
        return view
    }()
    
    private let backgroundLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = CustomColors.setColor(style: .lightBlue)
        label.toAutoLayout()
        return label
    }()
    
    private let lineChartView: LineChart = {
        let lineChart = LineChart()
        lineChart.toAutoLayout()
        return lineChart
    }()

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        configureLayout()
    }
    
    private func configureLayout(){
        self.separatorInset = UIEdgeInsets(top: 0, left: contentView.frame.width, bottom: 0, right: contentView.frame.width)
        contentView.addSubview(scrollView)
        scrollView.addSubview(backgroundLabel)
        backgroundLabel.addSubview(lineChartView)
        
        let scrollContantGuide = scrollView.contentLayoutGuide
        let scrollFrameGuide = scrollView.frameLayoutGuide
        
        let constraints = [
            scrollView.topAnchor.constraint(equalTo: contentView.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            scrollView.heightAnchor.constraint(equalToConstant: 170),
            
            backgroundLabel.topAnchor.constraint(equalTo: scrollContantGuide.topAnchor),
            backgroundLabel.leadingAnchor.constraint(equalTo: scrollContantGuide.leadingAnchor),
            backgroundLabel.trailingAnchor.constraint(equalTo: scrollContantGuide.trailingAnchor),
            backgroundLabel.bottomAnchor.constraint(equalTo: scrollContantGuide.bottomAnchor),
            backgroundLabel.topAnchor.constraint(equalTo: scrollFrameGuide.topAnchor),
            backgroundLabel.bottomAnchor.constraint(equalTo: scrollFrameGuide.bottomAnchor),
            backgroundLabel.widthAnchor.constraint(equalToConstant: 80 * 24 ),
            
            lineChartView.topAnchor.constraint(equalTo: backgroundLabel.topAnchor),
            lineChartView.leadingAnchor.constraint(equalTo: backgroundLabel.leadingAnchor),
            lineChartView.trailingAnchor.constraint(equalTo: backgroundLabel.trailingAnchor),
            lineChartView.bottomAnchor.constraint(equalTo: backgroundLabel.bottomAnchor),

        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    // MARK: - Insets
    
    private var inset: CGFloat { return 16 }
    
}
