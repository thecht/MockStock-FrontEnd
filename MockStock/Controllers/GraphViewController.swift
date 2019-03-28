//
//  GraphViewController.swift
//  MockStock
//
//  Created by Luke Orr on 3/9/19.
//  Copyright © 2019 Theodore Hecht. All rights reserved.
//

import UIKit
import SwiftCharts


class GraphViewController: UIViewController{
    
    
    fileprivate var chart: Chart? // arc
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let labelSettings = ChartLabelSettings(font: ExamplesDefaults.labelFont)
        
        var readFormatter = DateFormatter()
        readFormatter.dateFormat = "yyyy.MM.dd"
        
        var displayFormatter = DateFormatter()
        displayFormatter.dateFormat = "yyyy.MM.dd"
        
        let date = {(str: String) -> Date in
            return readFormatter.date(from: str)!
        }
        
        let calendar = Calendar.current
        
        let dateWithComponents = {(year: Int, month: Int, day: Int) -> Date in
            var components = DateComponents()
            components.day = day
            components.month = month
            components.year = year
            return calendar.date(from: components)!
        }
        
        func filler(_ date: Date) -> ChartAxisValueDate {
            let filler = ChartAxisValueDate(date: date, formatter: displayFormatter)
            filler.hidden = true
            return filler
        }
        
        
        
        let chartPoints = [
            createChartPoint(dateStr: "2015.10.1", int: 150, readFormatter: readFormatter, displayFormatter: displayFormatter),
            createChartPoint(dateStr: "2015.10.2", int: 160, readFormatter: readFormatter, displayFormatter: displayFormatter),
            createChartPoint(dateStr: "2015.10.3", int: 150, readFormatter: readFormatter, displayFormatter: displayFormatter),
            createChartPoint(dateStr: "2015.10.4", int: 140, readFormatter: readFormatter, displayFormatter: displayFormatter),
            createChartPoint(dateStr: "2015.10.5", int: 170, readFormatter: readFormatter, displayFormatter: displayFormatter),
            createChartPoint(dateStr: "2015.10.6", int: 180, readFormatter: readFormatter, displayFormatter: displayFormatter),
            createChartPoint(dateStr: "2015.10.7", int: 160, readFormatter: readFormatter, displayFormatter: displayFormatter),
            createChartPoint(dateStr: "2015.10.8", int: 50, readFormatter: readFormatter, displayFormatter: displayFormatter),
            createChartPoint(dateStr: "2015.10.9", int: 1, readFormatter: readFormatter, displayFormatter: displayFormatter),
            createChartPoint(dateStr: "2015.10.10", int: 10, readFormatter: readFormatter, displayFormatter: displayFormatter),
            createChartPoint(dateStr: "2015.10.11", int: 100, readFormatter: readFormatter, displayFormatter: displayFormatter),
            createChartPoint(dateStr: "2015.10.12", int: 180, readFormatter: readFormatter, displayFormatter: displayFormatter)
        ]
        
        let xValues = chartPoints.map{$0.x}
        
        let yValues = ChartAxisValuesStaticGenerator.generateYAxisValuesWithChartPoints(chartPoints, minSegmentCount: 0, maxSegmentCount: 500, multiple: 25, axisValueGenerator: {ChartAxisValueDouble($0, labelSettings: labelSettings)}, addPaddingSegmentIfEdge: false)
        
        let xModel = ChartAxisModel(axisValues: xValues, axisTitleLabel: ChartAxisLabel(text: "Date", settings: labelSettings))
        let yModel = ChartAxisModel(axisValues: yValues, axisTitleLabel: ChartAxisLabel(text: "Price", settings: labelSettings.defaultVertical()))
        let chartFrame = CGRect(x: -30 , y: -40, width: 400, height: 340)
        //let chartFrame = ExamplesDefaults.chartFrame(view.bounds)
        let chartSettings = ExamplesDefaults.chartSettingsWithPanZoom
        
        let coordsSpace = ChartCoordsSpaceLeftBottomSingleAxis(chartSettings: chartSettings, chartFrame: chartFrame, xModel: xModel, yModel: yModel)
        let (xAxisLayer, yAxisLayer, innerFrame) = (coordsSpace.xAxisLayer, coordsSpace.yAxisLayer, coordsSpace.chartInnerFrame)
        
        let lineModel = ChartLineModel(chartPoints: chartPoints, lineColor: UIColor.red, animDuration: 1, animDelay: 0)
        let chartPointsLineLayer = ChartPointsLineLayer(xAxis: xAxisLayer.axis, yAxis: yAxisLayer.axis, lineModels: [lineModel], useView: false)
        
        let thumbSettings = ChartPointsLineTrackerLayerThumbSettings(thumbSize: Env.iPad ? 20 : 10, thumbBorderWidth: Env.iPad ? 4 : 2)
        let trackerLayerSettings = ChartPointsLineTrackerLayerSettings(thumbSettings: thumbSettings)
        
        var currentPositionLabels: [UILabel] = []
        
        let chartPointsTrackerLayer = ChartPointsLineTrackerLayer<ChartPoint, Any>(xAxis: xAxisLayer.axis, yAxis: yAxisLayer.axis, lines: [chartPoints], lineColor: UIColor.black, animDuration: 1, animDelay: 2, settings: trackerLayerSettings) {chartPointsWithScreenLoc in
            
            currentPositionLabels.forEach{$0.removeFromSuperview()}
            
            for (index, chartPointWithScreenLoc) in chartPointsWithScreenLoc.enumerated() {
                
                let label = UILabel()
                label.text = chartPointWithScreenLoc.chartPoint.description
                label.sizeToFit()
                label.center = CGPoint(x: chartPointWithScreenLoc.screenLoc.x + label.frame.width / 2, y: chartPointWithScreenLoc.screenLoc.y + chartFrame.minY - label.frame.height / 2)
                
                label.backgroundColor = index == 0 ? UIColor.red : UIColor.blue
                label.textColor = UIColor.white
                
                currentPositionLabels.append(label)
                self.view.addSubview(label)
            }
        }
        
        let settings = ChartGuideLinesDottedLayerSettings(linesColor: UIColor.black, linesWidth: ExamplesDefaults.guidelinesWidth)
        let guidelinesLayer = ChartGuideLinesDottedLayer(xAxisLayer: xAxisLayer, yAxisLayer: yAxisLayer, settings: settings)
        
        let chart = Chart(
            frame: chartFrame,
            innerFrame: innerFrame,
            settings: chartSettings,
            layers: [
                xAxisLayer,
                yAxisLayer,
                guidelinesLayer,
                chartPointsLineLayer,
                chartPointsTrackerLayer
            ]
        )
        
        view.addSubview(chart.view)
        self.chart = chart
    }
    func createChartPoint(dateStr: String, int: Double, readFormatter: DateFormatter, displayFormatter: DateFormatter) -> ChartPoint {
        return ChartPoint(x: createDateAxisValue(dateStr, readFormatter: readFormatter, displayFormatter: displayFormatter), y: ChartAxisValuePrice(int))
    }
    
    func createDateAxisValue(_ dateStr: String, readFormatter: DateFormatter, displayFormatter: DateFormatter) -> ChartAxisValue {
        let date = readFormatter.date(from: dateStr)!
        let labelSettings = ChartLabelSettings(font: ExamplesDefaults.labelFont, rotation: 45, rotationKeep: .top)
        return ChartAxisValueDate(date: date, formatter: displayFormatter, labelSettings: labelSettings)
    }
    
    class ChartAxisValuePrice: ChartAxisValueDouble {
        override var description: String {
            return "\(formatter.string(from: NSNumber(value: scalar))!)"
        }
    }
}

