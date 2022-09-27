//
//  ThirdViewController.swift
//  MiracleMorningProject
//
//  Created by 이동기 on 2022/09/11.
//

import UIKit

import Charts

class ThirdViewController: BaseViewController {
    
    let mainView = ThirdView()
    let repository = UserScheduleRepository()
    // MonthPicker
    var availableYear: [Int] = []
    let allMonth: [Int] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
    var selectedYear = 0
    var selectedMonth = 0
    var todayYear = "0"
    var todayMonth = "0"
    let now = Date()
    var currentMonthTotalSchedules = 0
    var currentMonthSuccessSchedules = 0
    
    // Chart
    var currentMonthSuccess = ["성공", "전체"]
    var currentMonthSuccessValues = [50, 50]
    
    var currentMonthSchedules = ["수학", "알고리즘", "영어"]
    var currentMonthSchedulesPercent = [20, 10, 30]
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        mainView.backgroundColor = .systemBackground
        
        makeAvailableDate()
        
        mainView.currentMonthSuccessChart.centerText = "50%"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        customizeChart(dataPoints: currentMonthSuccess, values: currentMonthSuccessValues.map { Double($0) })
        
        customizeChart2(dataPoints: currentMonthSchedules, values: currentMonthSchedulesPercent.map { Double($0) })
        
        mainView.currentMonthSuccessChart.animate(xAxisDuration: 1.0)
        mainView.currentMonthSchedulePercentageChart.animate(xAxisDuration: 1.0)
    }
    
    override func configure() {
        mainView.monthPickerButton.addTarget(self, action: #selector(datePickerButtonClicked), for: .touchUpInside)
    }
    
    // MonthPicker Date설정
    func makeAvailableDate() {
        todayYear = DateFormatChange.shared.dateOfOnlyYear.string(from: now)
        todayMonth = DateFormatChange.shared.dateOfOnlyMonth.string(from: now)
        
        // monthPicker year 설정
        for i in Int(todayYear)!...Int(todayYear)!+1 {
            availableYear.append(i)
        }
        
        selectedYear = Int(todayYear)!
        selectedMonth = Int(todayMonth)!
    }
    
    @objc func datePickerButtonClicked() {
        let monthPickerView = UIPickerView()
        
        monthPickerView.delegate = self
        monthPickerView.dataSource = self
        
        let alert = UIAlertController(title: "\n\n\n\n\n\n\n\n\n\n", message: nil, preferredStyle: .actionSheet)
        
        alert.view.addSubview(monthPickerView)
        
        monthPickerView.snp.makeConstraints {
            $0.centerX.equalTo(alert.view)
            $0.top.equalTo(alert.view).offset(8)
        }
        
        let ok = UIAlertAction(title: "확인", style: .default) { (action) in
            
            let startOfMonthStr = "\(self.selectedYear)-\(self.selectedMonth)"
            let monthPickerTitle = "\(self.selectedYear)년 \(self.selectedMonth)월"
            guard let startOfMonth = DateFormatChange.shared.dateOfYearMonth.date(from: startOfMonthStr) else {
                return
            }
            
            let scheduleCountInMonth = self.repository.scheduleInMonth(currentDate: startOfMonth)
            let successScheduleCountInMonth = self.repository.successScheduleInMonth(currentDate: startOfMonth)
            
            print("schedule: \(scheduleCountInMonth.count)")
            print("successSchedule: \(successScheduleCountInMonth.count)")
            
            self.mainView.monthPickerButton.setTitle(monthPickerTitle, for: .normal)
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alert.addAction(ok)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
    
    func customizeChart(dataPoints: [String], values: [Double]) {
        
        // 1. Set ChartDateEntry
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = PieChartDataEntry(value: values[i], label: dataPoints[i], data: dataPoints[i] as AnyObject)
            dataEntries.append(dataEntry)
        }
        
        //2. Set ChartDataSet
        let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: nil)
        pieChartDataSet.highlightEnabled = false
        pieChartDataSet.colors = colorsOfCharts(numberOfColors: dataPoints.count)
        
        // 3. Set ChartData
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        let format = NumberFormatter()
        format.numberStyle = .none
        let formatter = DefaultValueFormatter(formatter: format)
        pieChartData.setValueFormatter(formatter)
        
        mainView.currentMonthSuccessChart.data = pieChartData
    }
    
    private func colorsOfCharts(numberOfColors: Int) -> [UIColor] {
        var colors: [UIColor] = []
        
        for _ in 0..<numberOfColors {
            let red = Double(arc4random_uniform(256))
            let green = Double(arc4random_uniform(256))
            let blue = Double (arc4random_uniform(256))
            let color = UIColor(red: CGFloat(red/255),
                                green: CGFloat(green/255),
                                blue: CGFloat(blue/255),
                                alpha: 0.8)
            colors.append(color)
        }
        return colors
    }
    
    func customizeChart2(dataPoints: [String], values: [Double]) {
        
        // 1. Set ChartDateEntry
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = PieChartDataEntry(value: values[i], label: dataPoints[i], data: dataPoints[i] as AnyObject)
            dataEntries.append(dataEntry)
        }
        
        //2. Set ChartDataSet
        let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: nil)
        pieChartDataSet.highlightEnabled = false
        pieChartDataSet.colors = colorsOfCharts(numberOfColors: dataPoints.count)
        
        // 3. Set ChartData
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        let format = NumberFormatter()
        format.numberStyle = .none
        let formatter = DefaultValueFormatter(formatter: format)
        pieChartData.setValueFormatter(formatter)
        
        mainView.currentMonthSchedulePercentageChart.data = pieChartData
    }
}

extension ThirdViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return availableYear.count
        case 1:
            return allMonth.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return "\(availableYear[row])년"
        case 1:
            return "\(allMonth[row])월"
        default:
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            selectedYear = availableYear[row]
        case 1:
            selectedMonth = allMonth[row]
        default:
            break
        }
        
        print("selectedYear :\(selectedYear)")
        

    }
}
