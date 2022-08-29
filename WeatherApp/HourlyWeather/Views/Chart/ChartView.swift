//
//  ChartView.swift
//  WeatherApp
//
//  Created by Iuliia Volkova on 08.08.2022.
//

import Foundation
import UIKit


struct PointEntry {
    
    let temperature: Float
    let icon: UIImage
    let time: String
    
}

extension PointEntry {

    init(with hourlyWeather: HourlyWeather) {
        self.temperature = Float(Int((hourlyWeather.currentTemperature).rounded()))

        self.icon = {
            let code = hourlyWeather.description.iconCode
            let icon = WeatherIcon(code: code)
            return icon.iconImage.dayImage
        }()

        self.time = {
            let stringToFormat = hourlyWeather.time
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "ru_RU")
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            let date = dateFormatter.date(from: stringToFormat)
            dateFormatter.dateFormat = "HH"
            let time = dateFormatter.string(from: date!)
            return time
        }()
    }
}

extension LineChart: ConfigurableView {
    
    func configure(with model: PointEntry) {
        dataEntries?.append(model)
    }
}


class LineChart: UIView {
    
    // Отступы

    let lineGap: CGFloat = 80.0
    let topSpace: CGFloat = 20.0
    let bottomSpace: CGFloat = 40.0
    
    // Данные для построения графика

    var dataEntries: [PointEntry]?
    
    
//    var dataEntries: [PointEntry]? = [
//        PointEntry(temperature: -8, icon: "sun", time: "12.00"),
//        PointEntry(temperature: -5, icon: "sun", time: "15.00"),
//        PointEntry(temperature: -1, icon: "sun", time: "18.00"),
//        PointEntry(temperature: 0, icon: "sun", time: "21.00"),
//        PointEntry(temperature: 3, icon: "sun", time: "00.00"),
//        PointEntry(temperature: 5, icon: "sun", time: "03.00"),
//        PointEntry(temperature: 0, icon: "sun", time: "06.00"),
//        PointEntry(temperature: -8, icon: "sun", time: "09.00"),
//    ]
    
//    var dataEntries: [PointEntry]? = [
//        PointEntry(temperature: -70, icon: "sun", time: "12.00"),
//        PointEntry(temperature: -71, icon: "sun", time: "15.00"),
//        PointEntry(temperature: -72, icon: "sun", time: "18.00"),
//        PointEntry(temperature: -71, icon: "sun", time: "21.00"),
//        PointEntry(temperature: -68, icon: "sun", time: "00.00"),
//        PointEntry(temperature: -69, icon: "sun", time: "03.00"),
//        PointEntry(temperature: -67, icon: "sun", time: "06.00"),
//        PointEntry(temperature: -65, icon: "sun", time: "09.00"),
//    ]
    
//    var dataEntries: [PointEntry]? = [
//        PointEntry(temperature: -90, icon: "sun", time: "12.00"),
//        PointEntry(temperature: 70, icon: "sun", time: "15.00"),
//        PointEntry(temperature: 90, icon: "sun", time: "18.00"),
//        PointEntry(temperature: -20, icon: "sun", time: "21.00"),
//        PointEntry(temperature: 0, icon: "sun", time: "00.00"),
//        PointEntry(temperature: -50, icon: "sun", time: "03.00"),
//        PointEntry(temperature: 0, icon: "sun", time: "06.00"),
//        PointEntry(temperature: 90, icon: "sun", time: "09.00"),
//    ]
    
//    var dataEntries: [PointEntry]? = [
//        PointEntry(temperature: -20, icon: "sun", time: "12.00"),
//        PointEntry(temperature: 0, icon: "sun", time: "15.00"),
//        PointEntry(temperature: 0, icon: "sun", time: "18.00"),
//        PointEntry(temperature: -20, icon: "sun", time: "21.00"),
//        PointEntry(temperature: 0, icon: "sun", time: "00.00"),
//        PointEntry(temperature: 20, icon: "sun", time: "03.00"),
//        PointEntry(temperature: 0, icon: "sun", time: "06.00"),
//        PointEntry(temperature: 0, icon: "sun", time: "09.00"),
//    ]
    
//    var dataEntries: [PointEntry]? = [
//        PointEntry(temperature: -26, icon: "sun", time: "12.00"),
//        PointEntry(temperature: -25, icon: "sun", time: "15.00"),
//        PointEntry(temperature: -26, icon: "sun", time: "18.00"),
//        PointEntry(temperature: -27, icon: "sun", time: "21.00"),
//        PointEntry(temperature: -28, icon: "sun", time: "00.00"),
//        PointEntry(temperature: -27, icon: "sun", time: "03.00"),
//        PointEntry(temperature: -26, icon: "sun", time: "06.00"),
//        PointEntry(temperature: -25, icon: "sun", time: "09.00"),
//    ]
    
//    var dataEntries: [PointEntry]? = [
//        PointEntry(temperature: -19, icon: "sun", time: "12.00"),
//        PointEntry(temperature: 21, icon: "sun", time: "15.00"),
//        PointEntry(temperature: 26, icon: "sun", time: "18.00"),
//        PointEntry(temperature: 27, icon: "sun", time: "21.00"),
//        PointEntry(temperature: 26, icon: "sun", time: "00.00"),
//        PointEntry(temperature: 27, icon: "sun", time: "03.00"),
//        PointEntry(temperature: 29, icon: "sun", time: "06.00"),
//        PointEntry(temperature: 30, icon: "sun", time: "09.00"),
//    ]
    
   // Слои
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.showsHorizontalScrollIndicator = false
        return view
    }()

    private let dataLayer: CALayer = CALayer()
    private let mainLayer: CALayer = CALayer()
    private let gridLayer: CALayer = CALayer()

    /// An array of CGPoint on dataLayer coordinate system that the main line will go through. These points will be calculated from dataEntries array
    private var temperatureDataPoint: [CGPoint]?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }

    // Описать расположение слоев
    private func setupView() {
        mainLayer.addSublayer(dataLayer)
        mainLayer.addSublayer(gridLayer)
        scrollView.layer.addSublayer(mainLayer)

        self.addSubview(scrollView)
    }
    
    override func layoutSubviews() {
        scrollView.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        if let dataEntries = dataEntries {
            scrollView.contentSize = CGSize(width: CGFloat(dataEntries.count) * lineGap, height: self.frame.size.height)
            mainLayer.frame = CGRect(x: 0, y: 0, width: CGFloat(dataEntries.count) * lineGap, height: self.frame.size.height)
            dataLayer.frame = CGRect(x: 0, y: topSpace, width: mainLayer.frame.width, height: mainLayer.frame.height - topSpace - bottomSpace)
            temperatureDataPoint = convertDataEntriesToPoints(entries: dataEntries)
            gridLayer.frame = CGRect(x: 0, y: topSpace, width: CGFloat(dataEntries.count) * lineGap, height: mainLayer.frame.height - topSpace - bottomSpace)
            clean()
            drawHorizontalLine()
            addDots()
            drawChart(for: temperatureDataPoint, color: .blue)
            drawLables()
            drawTempLables()
        }
    }
    
    // Посчитать разничу между максимальной и минимальной температурами, найти коэффицент для того, чтобы скейлить график
    
    private func getDifference(entries: [PointEntry]) -> Float {
        var temperature: [Float] = []
        for value in entries {
            let temp = value.temperature
            temperature.append(temp)
        }
        let numMax = temperature.reduce(temperature[0], { max($0, $1) })
        let numMin = temperature.reduce(temperature[0], { min ($0, $1) })
        let diff = numMax - numMin
        let difference = 70 / diff
        return difference
//        switch diff{
//        case 0...5:
//            let difference = 8.0
//            return Float(difference)
//        case 6...10:
//            let difference = 4.0
//            return Float(difference)
//        case 11...15:
//            let difference = 2.0
//            return Float(difference)
//        case 16...20:
//            let difference = 1.5
//            return Float(difference)
//        case 21...40:
//            let difference = 1
//            return Float(difference)
//        case 40...:
//            let difference = 0.5
//            return Float(difference)
//        default:
//            let difference = 1
//            return Float(difference)
//        }
    }
    
    // Найти медиану, чтобы определить на какой высоте рисовать график
    private func calculateMedian(entries: [PointEntry]) -> Float {
        var temperature: [Float] = []
        var difference = getDifference(entries: entries)
        for value in entries {
            let height = Float(value.temperature)
            temperature.append(height)
        }
        let sorted = temperature.sorted()
        if sorted.count % 2 == 0 {
            return Float((sorted[(sorted.count / 2)] + sorted[(sorted.count / 2) - 1])) / 2
        } else {
            return Float(sorted[(sorted.count - 1) / 2])
        }
    }
    
    // Найти высоту для каждой точки на графике
    private func getHeigths(entries: [PointEntry]) -> [CGFloat] {
        var result: [CGFloat] = []
        let difference = getDifference(entries: entries)
        let median = calculateMedian(entries: entries)
        var absMedian = abs(median)
        
        if absMedian < 10 {
            absMedian += 10
        }
        
        let inset = 30 / absMedian
        
        let medianToCompare = -median * difference * inset
    
        for value in entries {
            let value = value.temperature
            var height = -(value) * difference
            height = height * inset
            if medianToCompare < 0 {
                height = height + abs(medianToCompare)
            } else if medianToCompare > 80 {
                height = height - abs(medianToCompare)
            }
            print("height \(height)")
            result.append(CGFloat(height))
        }
        print("diff \(difference)")
        print("median \(median)")
        print("inset \(inset)")
        return result
    }

    // Найти координаты для всех точек на графике
    private func convertDataEntriesToPoints(entries: [PointEntry]) -> [CGPoint] {
        var result: [CGPoint] = []
        let heights = getHeigths(entries: entries)
        let difference = getDifference(entries: entries)
        
        for (index, value) in heights.enumerated() {
            var height = value
            let width = CGFloat(index)*lineGap + 40
            let point = CGPoint(x: width, y: height)
            result.append(point)
        }
        print(result)
        return result
    }

// Нарисовать график
    private func drawChart(for points: [CGPoint]?, color: UIColor) {
        if let dataPoints = points, dataPoints.count > 0 {
            guard let path = createPath(for: points) else { return }
            let lineLayer = CAShapeLayer()
            lineLayer.path = path.cgPath
            lineLayer.strokeColor = color.cgColor
            lineLayer.fillColor = UIColor.clear.cgColor
            dataLayer.addSublayer(lineLayer)
        }
    }

    // Рисует линии между точками
     private func createPath(for points: [CGPoint]?) -> UIBezierPath? {
         guard let dataPoints = points, dataPoints.count > 0 else {
             return nil
         }
         let path = UIBezierPath()
         path.move(to: dataPoints[0])

         for i in 1..<dataPoints.count {
             path.addLine(to: dataPoints[i])
         }
         return path
     }
    
    
    // Лейблы со временем
    private func drawLables() {
        if let dataEntries = dataEntries,
            dataEntries.count > 0 {
            for i in 0..<dataEntries.count {
                let textLayer = CATextLayer()
                textLayer.frame = CGRect(x: lineGap*CGFloat(i) - lineGap/2 + 40, y: mainLayer.frame.size.height - bottomSpace, width: lineGap, height: 20)
                textLayer.foregroundColor = UIColor.black.cgColor
                textLayer.backgroundColor = UIColor.clear.cgColor
                textLayer.alignmentMode = CATextLayerAlignmentMode.center
                textLayer.contentsScale = UIScreen.main.scale
                textLayer.font = CTFontCreateWithName(UIFont.systemFont(ofSize: 0).fontName as CFString, 0, nil)
                textLayer.fontSize = 14
                textLayer.string = dataEntries[i].time
//                print(textLayer.frame.debugDescription)
                mainLayer.addSublayer(textLayer)
            }
        }
    }
    
    // Леблы с температурой
    private func drawTempLables() {
        if let dataEntries = dataEntries,
            dataEntries.count > 0 {
            let heights = getHeigths(entries: dataEntries)
            for i in 0..<dataEntries.count {
                let textLayer = CATextLayer()
                textLayer.frame = CGRect(x: lineGap*CGFloat(i) - lineGap/2 + 40, y: heights[i] + 30, width: lineGap, height: 20)
                textLayer.foregroundColor = UIColor.black.cgColor
                textLayer.backgroundColor = UIColor.clear.cgColor
                textLayer.alignmentMode = CATextLayerAlignmentMode.center
                textLayer.contentsScale = UIScreen.main.scale
                textLayer.font = CTFontCreateWithName(UIFont.systemFont(ofSize: 0).fontName as CFString, 0, nil)
                textLayer.fontSize = 14
                textLayer.string = String(Int(dataEntries[i].temperature.rounded()))
                print(textLayer.frame.debugDescription)
                mainLayer.addSublayer(textLayer)
            }
        }
    }
    
    // Ось х, на которой отмечеается время
    private func drawHorizontalLine() {
        let width = 620

        let path = UIBezierPath()
        path.move(to: CGPoint(x: 30, y: 100))
        path.addLine(to: CGPoint(x: width, y: 100))

        let lineLayer = CAShapeLayer()
        lineLayer.path = path.cgPath
        lineLayer.fillColor = UIColor.clear.cgColor
        lineLayer.strokeColor = CustomColors.setColor(style: .deepBlue).cgColor
        lineLayer.lineWidth = 1.5

        gridLayer.addSublayer(lineLayer)
    }
    
    // Точки на оси х
    private func addDots() {
        if let dataEntries = dataEntries,
           dataEntries.count > 0 {
            for i in 0..<dataEntries.count {
                let radius = 6
                
                let dotPath = UIBezierPath(ovalIn: CGRect(x: Int(lineGap*CGFloat(i)) + 37, y: 97, width: radius, height: radius))
                
                let layer = CAShapeLayer()
                layer.path = dotPath.cgPath
                layer.strokeColor = UIColor.blue.cgColor
                
                gridLayer.addSublayer(layer)
            }
        }
    }

    // Очистить слои
    private func clean() {
        mainLayer.sublayers?.forEach({
            if $0 is CATextLayer {
                $0.removeFromSuperlayer()
            }
        })
        dataLayer.sublayers?.forEach({$0.removeFromSuperlayer()})
        gridLayer.sublayers?.forEach({$0.removeFromSuperlayer()})
    }
}
