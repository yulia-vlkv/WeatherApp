//
//  SettingsOptionView.swift
//  WeatherApp
//
//  Created by Iuliia Volkova on 06.08.2022.
//

import Foundation
import UIKit

final class SettingsOptionView: UIView {
    
    // MARK: - Public properties
    
    private var valueChanged: ( (String) -> Void )?
    
    // MARK: - Private properties
    
    private let stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return label
    }()

    private lazy var segmented: UISegmentedControl = {
        let segmented = UISegmentedControl()
        segmented.selectedSegmentIndex = 1
        segmented.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        segmented.selectedSegmentTintColor = CustomColors.setColor(style: .deepBlue)
        segmented.contentMode = .right
        segmented.addTarget(self, action: #selector(segmentedValueChanged), for: .valueChanged)
        return segmented
    }()
    
    // MARK: - Initialize
    
    init() {
        super.init(frame: .zero)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Private methods
    
    private func configureView() {
        addSubview(stack)
        
        stack.addArrangedSubview(label)
        stack.addArrangedSubview(segmented)
        
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: leadingAnchor),
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    @objc private func segmentedValueChanged(sender: UISegmentedControl) {
        valueChanged?(sender.titleForSegment(at: sender.selectedSegmentIndex)!)
    }
}


extension SettingsOptionView: ConfigurableView {
    
    struct Model {
        
        let title: String
        let values: [String]
        let selectedValue: String
        let valueChanged: (String) -> Void
    }
    
    public func configure(with model: Model) {
        label.text = model.title
        
        segmented.removeAllSegments()
        for value in model.values.reversed() {
            segmented.insertSegment(withTitle: value, at: 0, animated: false)
            segmented.setWidth(50, forSegmentAt: 0)
        }
        segmented.selectedSegmentIndex = model.values.firstIndex(of: model.selectedValue) ?? 0
        
        valueChanged = model.valueChanged
    }
}
