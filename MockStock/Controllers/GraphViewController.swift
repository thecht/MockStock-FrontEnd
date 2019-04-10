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
    
    var datePoints = MSMarketGraphData.sharedInstance.dates
    var pricePoints = MSMarketGraphData.sharedInstance.prices
    var xAxisPoints = [ChartPoint]()
    var realChartPoints = [ChartPoint]()
    var mid = [ChartAxisValue]()
    
    //Creates two array, one for date points and the other for price points based off the information recieved from the detailed view controller
    func setupChartData(graphDates: [MSGraphItemDate], graphPrice: [MSGraphItemPrice]){
        datePoints.removeAll()
        pricePoints.removeAll()
        realChartPoints.removeAll()
        datePoints = graphDates
        pricePoints = graphPrice
    }
    
    
    
    fileprivate var chart: Chart? // arc
    override func viewDidLoad() {
        super.viewDidLoad()
        let labelSettings = ChartLabelSettings(font: ExamplesDefaults.labelFont)
        var readFormatter = DateFormatter()
        readFormatter.dateFormat = "yyyy-MM-dd"
        
        var displayFormatter = DateFormatter()
        var touchFormatter = DateFormatter()
        touchFormatter.dateFormat = "yyyy-MM-dd"
        //Creates an array of chart points based off data recieved from detailed view controller
        for(e1, e2) in zip(datePoints, pricePoints){
            let e3 = createChartPoint(dateStr: e1.date, int: e2.closingPrice, readFormatter: readFormatter, displayFormatter: touchFormatter)
            realChartPoints.append(e3)
        }
        setupAxis()
        let date = {(str: String) -> Date in
            return readFormatter.date(from: str)!
        }
        
        let calendar = Calendar.current
        //Sets up date formating
        let dateWithComponents = {(year: Int, month: Int, day: Int) -> Date in
            var components = DateComponents()
            components.day = day
            components.month = month
            components.year = year
            return calendar.date(from: components)!
        }
        
        func filler(_ date: Date) -> ChartAxisValueDate {
            let filler = ChartAxisValueDate(date: date, formatter: touchFormatter)
            filler.hidden = true
            return filler
        }
        
        let xValues = xAxisPoints.map{$0.x}
        let yValues = ChartAxisValuesStaticGenerator.generateYAxisValuesWithChartPoints(realChartPoints, minSegmentCount: 0, maxSegmentCount: 500, multiple: 10, axisValueGenerator: {ChartAxisValueDouble($0, labelSettings: labelSettings)}, addPaddingSegmentIfEdge: false)
        
        let xModel = ChartAxisModel(axisValues: xValues, axisTitleLabel: ChartAxisLabel(text: "Date", settings: labelSettings))
        let yModel = ChartAxisModel(axisValues: yValues, axisTitleLabel: ChartAxisLabel(text: "Price", settings: labelSettings.defaultVertical()))
        let chartFrame = CGRect(x: -30 , y: -40, width: 400, height: 340)
        let chartSettings = ExamplesDefaults.chartSettingsWithPanZoom
        
        let coordsSpace = ChartCoordsSpaceLeftBottomSingleAxis(chartSettings: chartSettings, chartFrame: chartFrame, xModel: xModel, yModel: yModel)
        let (xAxisLayer, yAxisLayer, innerFrame) = (coordsSpace.xAxisLayer, coordsSpace.yAxisLayer, coordsSpace.chartInnerFrame)
        
        let lineModel = ChartLineModel(chartPoints: realChartPoints, lineColor: UIColor.red, animDuration: 1, animDelay: 0)
        let chartPointsLineLayer = ChartPointsLineLayer(xAxis: xAxisLayer.axis, yAxis: yAxisLayer.axis, lineModels: [lineModel], useView: false)
        
        let thumbSettings = ChartPointsLineTrackerLayerThumbSettings(thumbSize: Env.iPad ? 20 : 10, thumbBorderWidth: Env.iPad ? 4 : 2)
        let trackerLayerSettings = ChartPointsLineTrackerLayerSettings(thumbSettings: thumbSettings)
        
        var currentPositionLabels: [UILabel] = []
        
        //Sets up and creates tracker view for when the user clicks on a point on the graph
        let chartPointsTrackerLayer = ChartPointsLineTrackerLayer<ChartPoint, Any>(xAxis: xAxisLayer.axis, yAxis: yAxisLayer.axis, lines: [realChartPoints], lineColor: UIColor.black, animDuration: 1, animDelay: 2, settings: trackerLayerSettings) {chartPointsWithScreenLoc in
            
            currentPositionLabels.forEach{$0.removeFromSuperview()}
            
            for (index, chartPointWithScreenLoc) in chartPointsWithScreenLoc.enumerated() {
                
                let label = UILabel()
                label.text = chartPointWithScreenLoc.chartPoint.description
                label.sizeToFit()
                label.center = CGPoint(x: chartPointWithScreenLoc.screenLoc.x-10, y: chartPointWithScreenLoc.screenLoc.y + chartFrame.minY - label.frame.height / 2)
                
                label.backgroundColor = index == 0 ? UIColor.red : UIColor.blue
                label.textColor = UIColor.white
                
                currentPositionLabels.append(label)
                self.view.addSubview(label)
            }
        }
        
        let settings = ChartGuideLinesDottedLayerSettings(linesColor: UIColor.black, linesWidth: ExamplesDefaults.guidelinesWidth)
        let guidelinesLayer = ChartGuideLinesDottedLayer(xAxisLayer: xAxisLayer, yAxisLayer: yAxisLayer, settings: settings)
        
        //Sets up the chart
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
    //Creates a chart point
    func createChartPoint(dateStr: String, int: Double, readFormatter: DateFormatter, displayFormatter: DateFormatter) -> ChartPoint {
        return ChartPoint(x: createDateAxisValue(dateStr, readFormatter: readFormatter, displayFormatter: displayFormatter), y: ChartAxisValuePrice(int))
    }
    //Creates axis values based off chartpoint data recieved
    func createDateAxisValue(_ dateStr: String, readFormatter: DateFormatter, displayFormatter: DateFormatter) -> ChartAxisValue {
        let date = readFormatter.date(from: dateStr)!
        let labelSettings = ChartLabelSettings(font: ExamplesDefaults.labelFont, fontColor: .black, rotation: 0, rotationKeep: .top, shiftXOnRotation: false, textAlignment: .left)
        return ChartAxisValueDate(date: date, formatter: displayFormatter, labelSettings: labelSettings)
    }
    //Formats the price axis
    class ChartAxisValuePrice: ChartAxisValueDouble {
        override var description: String {
            return "\(formatter.string(from: NSNumber(value: scalar))!)"
        }
    }
    //Function that calculates that axis points for display
    func setupAxis() {
        xAxisPoints.removeAll()
        let xValues = realChartPoints
        var findMid = realChartPoints.map{$0.x}
        let quarterPoint = xValues.count / 3
        var index = quarterPoint
        xAxisPoints.append(xValues[0])
        xAxisPoints.append(xValues[index])
        index += quarterPoint
        mid = [findMid[index]]
        xAxisPoints.append(xValues[index])
        let last = xValues.count - 1
        xAxisPoints.append(xValues[last])
        }
        
}



