//
//  ChartViewController.swift
//  AOAD
//
//  Created by Hassine on 21/09/2019.
//  Copyright © 2019 aoad. All rights reserved.
//

import UIKit
import AnyChartiOS
import SwiftyJSON

class ChartViewController: UIViewController {
    
    var selected_table:String = ""
    var selected_chart:String = ""
    var selected_item:[String] = []
    var selected_item2:[String] = []
    var selected_countries:[String] = []
    var selected_year_from:String = ""
    var selected_year_to:String = ""
    var choice:String = ""
    var selected_title:[String] = []
    var chart_list:[Chart] = []
    var width:Int = 0
    
    @IBOutlet weak var container: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        
        self.title = choice
        
        width = Int(container.frame.width)
        
        getStatisticData()
    }
    
    func drawPieChart(years: [String], values: [Double], title: String)  -> anychart.core.Chart{
        let chart = AnyChart.pie()
        var data: Array<DataEntry> = []
        for index in 0..<years.count {
            data.append(ValueDataEntry(x: years[index], value: values[index]))
        }
        chart.data(data: data)
        chart.title(settings: "Staistic on".localized(using: "Localizable")+" "+title)
        chart.legend().title().enabled(enabled: true)
        chart.legend().title()
            .text(text: "")
            .padding(value1: 0, value2: 0, value3: 0, value4: 0)
        chart.legend()
            .position(position: "center-bottom")
            .itemsLayout(layout: anychart.enums.LegendLayout.HORIZONTAL)
            .align(align: anychart.enums.Align.CENTER)
        chart.fill()
        return chart
    }
    
    func drawAreaChart(years: [String], values: [Double], values1: [Double], values2: [Double], values3: [Double], title: String)  -> anychart.core.Chart {
        let chart = AnyChart.area()
        
        chart.animation(settings: true)
        
        let crosshair = chart.crosshair()
        crosshair.enabled(enabled: true)
        crosshair.yStroke(color: "null", thickness: 0, dashpattern: "null", lineJoin: "null", lineCap: "null")
        crosshair.xStroke(color: "#fff", thickness: 1, dashpattern: "null", lineJoin: "null", lineCap: "null")
        crosshair.zIndex(zIndex: 39)
        crosshair.yLabel(index: 0).enabled(enabled: true)
        
        chart.yScale().stackMode(value: anychart.enums.ScaleStackMode.VALUE)
        
        chart.title(settings: "Staistic on".localized(using: "Localizable")+" "+title)
        var data: Array<DataEntry> = []
        
        
        for index in 0..<years.count {
            switch (selected_countries.count){
            case 1:
                data.append(ValueDataEntry(x: years[index], value: values[index]))
                break
            case 2:
                data.append(CustomDataEntry(x: years[index], value: values[index], value2: values1[index]))
                break
            case 3:
                data.append(CustomDataEntry(x: years[index], value: values[index], value2: values1[index], value3: values2[index]))
                break
            case 4:
                data.append(CustomDataEntry(x: years[index], value: values[index], value2: values1[index], value3: values2[index], value4: values3[index]))
                break
            default:
                break
            }
        }
    
        let set = anychart.data.Set().instantiate()
        set.data(data: data)
        let seriesData = set.mapAs(mapping: "{x:'x', value: 'value'}")
        let series = chart.area(data: seriesData)
        series.name(name: selected_countries[0])
        series.stroke(settings: "3 #fff")
        series.hovered().stroke(settings: "3 #fff")
        series.hovered().markers().enabled(enabled: true)
        series.hovered().markers().type(type: anychart.enums.MarkerType.CIRCLE)
            .size(size: 4)
            .stroke(color: "1.5 #fff")
        series.markers().zIndex(zIndex: 100)
        
        if selected_countries.count > 1 {
            for index in 1..<selected_countries.capacity-1 {
                let seriesData = set.mapAs(mapping: "{x:'x', value: 'value"+String(index)+"'}")
                let series = chart.area(data: seriesData)
                series.name(name: selected_countries[index])
                series.stroke(settings: "3 #fff")
                series.hovered().stroke(settings: "3 #fff")
                series.hovered().markers().enabled(enabled: true)
                series.hovered().markers().type(type: anychart.enums.MarkerType.CIRCLE)
                    .size(size: 4)
                    .stroke(color: "1.5 #fff")
                series.markers().zIndex(zIndex: 100)
            }
        }
       
        
        chart.legend().enabled(enabled: true)
        chart.legend().fontSize(size: 13)
        chart.legend().padding(padding: [0, 0, 20, 0])
        
        chart.xAxis(index: 0).title(settings: false)
        chart.yAxis(index: 0).title(settings: "")
        
        chart.interactivity().hoverMode(mode: anychart.enums.HoverMode.BY_X)
        chart.tooltip().valuePrefix(value: "$")
            .valuePostfix(value: " bln.")
            .displayMode(value: anychart.enums.TooltipDisplayMode.UNION)
    return chart
        
    }
    
    
    func drawLineChart(years: [String], values: [Double], values1: [Double], values2: [Double], values3: [Double], title: String) -> anychart.core.Chart {
        let chart = AnyChart.line()
        
        chart.animation(settings: true)
        
        chart.padding(padding: [10, 20, 5, 20])
        
        chart.crosshair().enabled(enabled: true)
        chart.crosshair().yLabel(settings: true)
        
        chart.tooltip().positionMode(mode: anychart.enums.TooltipPositionMode.POINT)
        
        chart.title(settings: "Staistic on".localized(using: "Localizable")+" "+title)
        var data: Array<DataEntry> = []

        chart.yAxis(index: 0).title(settings: "")
        chart.xAxis(index: 0).labels().padding(padding: 5)
        
        for index in 0..<years.count {
            switch (selected_countries.count){
            case 1:
                data.append(ValueDataEntry(x: years[index], value: values[index]))
                break
            case 2:
                data.append(CustomDataEntry(x: years[index], value: values[index], value2: values1[index]))
                break
            case 3:
                data.append(CustomDataEntry(x: years[index], value: values[index], value2: values1[index], value3: values2[index]))
                break
            case 4:
                data.append(CustomDataEntry(x: years[index], value: values[index], value2: values1[index], value3: values2[index], value4: values3[index]))
                break
            default:
                break
            }
        }
        
        let set = anychart.data.Set().instantiate()
        set.data(data: data)
        
        let series1Mapping = set.mapAs(mapping: "{x: 'x', value: 'value'}")
        let series1 = chart.line(data: series1Mapping)
        series1.name(name: selected_countries[0])
        series1.hovered().markers().enabled(enabled: true)
        series1.hovered().markers()
            .type(type: anychart.enums.MarkerType.CIRCLE)
            .size(size: 4)
        series1.tooltip()
            .position(position: "right")
            .anchor(anchor: anychart.enums.Anchor.LEFT_CENTER)
            .offsetX(offset: 5)
            .offsetY(offset: 5)
        
        
        if selected_countries.count > 1 {
            for index in 1..<selected_countries.count {
                 let seriesMapping = set.mapAs(mapping: "{x:'x', value: 'value"+String(index+1)+"'}")
                let series = chart.line(data: seriesMapping)
                series.name(name: selected_countries[index])
                series.hovered().markers().enabled(enabled: true)
                series.hovered().markers()
                    .type(type: anychart.enums.MarkerType.CIRCLE)
                    .size(size: 4)
                series.tooltip()
                    .position(position: "right")
                    .anchor(anchor: anychart.enums.Anchor.LEFT_CENTER)
                    .offsetX(offset: 5)
                    .offsetY(offset: 5)
            }
        }
        chart.legend().enabled(enabled: true)
        chart.legend().fontSize(size: 13)
        chart.legend().padding(padding: [0, 0, 10, 0])
        
        return chart
    }
    
    
    func drawMikkoChart(years: [String], values: [Double], values1: [Double], values2: [Double], values3: [Double], title: String)  -> anychart.core.Chart {
        let chart = AnyChart.mekko()
        var data: Array<DataEntry> = []

        for index in 0..<years.count {
            switch (selected_countries.count){
            case 1:
                data.append(ValueDataEntry(x: years[index], value: values[index]))
                break
            case 2:
                data.append(CustomDataEntry(x: years[index], value: values[index], value2: values1[index]))
                break
            case 3:
                data.append(CustomDataEntry(x: years[index], value: values[index], value2: values1[index], value3: values2[index]))
                break
            case 4:
                data.append(CustomDataEntry(x: years[index], value: values[index], value2: values1[index], value3: values2[index], value4: values3[index]))
                break
            default:
                break
            }
        }
        let set = anychart.data.Set().instantiate()
        set.data(data: data)
        let seriesMapping = set.mapAs(mapping: "{x:'x', value: 'value'}")
        chart.mekko(data: seriesMapping).name(name: selected_countries[0])


        if selected_countries.count > 1 {
            for index in 1..<selected_countries.count {
                let seriesMapping = set.mapAs(mapping: "{x:'x', value: 'value"+String(index+1)+"'}")
                chart.mekko(data: seriesMapping).name(name:selected_countries[index])

            }
        }

        chart.xAxis(index: 0).orientation(orientation: anychart.enums.Orientation.TOP)

        chart.labels().format(token: "${%Value}k")

        chart.tooltip().format(format: "{%seriesName}: ${%Value}k")
    
        return chart
    }
    
    class CustomDataEntry: ValueDataEntry {
        init(x: String, value: Double, value2: Double) {
            super.init(x: x, value: value)
            setValue(key: "value2", value: value2)
        }
        init(x: String, value: Double, value2: Double, value3: Double) {
            super.init(x: x, value: value)
            setValue(key: "value2", value: value2)
            setValue(key: "value3", value: value3)
        }
        init(x: String, value: Double, value2: Double, value3: Double, value4: Double) {
            super.init(x: x, value: value)
            setValue(key: "value2", value: value2)
            setValue(key: "value3", value: value3)
            setValue(key: "value4", value: value4)
        }
    }
    
    func getStatisticData() {
        var cmp:Int = 0
        if self.selected_item2.count > 0 {
            for item in self.selected_item2 {
                var years = [String]()
                var values = [Double]()
                for country in self.selected_countries {
                    let params = [
                        "options": self.selected_item,
                        "table": self.selected_table,
                        "year_from": self.selected_year_from,
                        "year_to": self.selected_year_to,
                        "country": country
                        ] as [String : Any]
                    
                    NetworkManager.getStatisticData(param: params as NSDictionary) { (error, data)  in
                        let json = JSON(data)
                        let array = json["item"]
                        
                        for index in 0..<array.count {
                            let dic:[String : Any] = array[index].dictionary!
                            years.append(String(describing:dic["annee"]!))
                            values.append(Double(String(describing:dic[item]!)) as! Double)
                        }
                    }
                }
            }
        }else {
            for item in self.selected_item {
                var years = [String]()
                var values = [Double]()
                var values2 = [Double]()
                var values3 = [Double]()
                var values4 = [Double]()

                for i in 0..<self.selected_countries.count {
                    let params = [
                        "options": self.selected_item,
                        "table": self.selected_table,
                        "year_from": self.selected_year_from,
                        "year_to": self.selected_year_to,
                        "country": self.selected_countries[i]
                        ] as [String : Any]
                    
                    NetworkManager.getStatisticData(param: params as NSDictionary) { (error, data)  in
                        let json = JSON(data)
                        let array = json["item"]
                        for index in 0..<array.count {
                            let dic:[String : Any] = array[index].dictionary!
                            switch (i) {
                            case 0:
                                years.append(String(describing:dic["annee"]!))
                                values.append(Double(String(describing:dic[item]!)) as! Double)
                                break
                            case 1:
                                values2.append(Double(String(describing:dic[item]!)) as! Double)
                                break
                            case 2:
                                values3.append(Double(String(describing:dic[item]!)) as! Double)
                                break
                            case 3:
                                values4.append(Double(String(describing:dic[item]!)) as! Double)
                                break
                            default:
                                break
                            }
                        }

                        if i == self.selected_countries.count-1 {
                            let anyChartView = AnyChartView()
                            switch (self.selected_chart){
                            case "pie":
                                anyChartView.setChart(chart: self.drawPieChart(years: years, values: values, title: self.selected_title[self.selected_item.firstIndex(of: item)!]))
                                break
                            case "area":
                                anyChartView.setChart(chart: self.drawAreaChart(years: years, values: values, values1: values2, values2: values3, values3: values4, title: self.selected_title[self.selected_item.firstIndex(of: item)!]))
                                break
                            case "line":
                                 anyChartView.setChart(chart: self.drawLineChart(years: years, values: values, values1: values2, values2: values3, values3: values4, title: self.selected_title[self.selected_item.firstIndex(of: item)!]))
//                            case "mikko":
//                                anyChartView.setChart(chart: self.drawMikkoChart(years: years, values: values, values1: values2, values2: values3, values3: values4, title: self.selected_title[self.selected_item.firstIndex(of: item)!]))
                            default:
                                break
                            }
                            anyChartView.frame = CGRect(x: 0, y: cmp*500, width: self.width-20, height: 500)
                            anyChartView.isUserInteractionEnabled = false
                            self.container.addSubview(anyChartView)
                            self.container.contentSize.height = CGFloat(self.selected_item.count*500)
                            cmp += 1
                        }
                    }
                }
            }
            
        }
        
    }
}
