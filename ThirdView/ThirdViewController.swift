//
//  ThirdViewController.swift
//  MiracleMorningProject
//
//  Created by 이동기 on 2022/09/11.
//

import UIKit

import Charts
import RealmSwift

//enum chartColor {
//    static let successColor = UIColor(red: 101/255, green: 166/255, blue: 114/255, alpha: 1)
//    static let failColor = UIColor(red: 227/255, green: 103/255, blue: 81/255, alpha: 1)
//    static let futureScheduleColor = UIColor(red: 209/255, green: 209/255, blue: 209/255, alpha: 1)
//}


class ThirdViewController: BaseViewController {
    
    let mainView = ThirdView()
    let repository = UserScheduleRepository()
    let calendar = Calendar.current
    
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
    var totalScheduleCountInMonth = 0
    var successScheduleCountFromToday = 0
    var failScheduleCountFromToday = 0
    
    // 스케쥴 진행률
    var currentMonthSuccess = ["성공", "실패", "미진행"]
    var currentMonthSuccessValues = [0, 0, 0]
    
    // 스케쥴 성공 시간
    var successScheduleDic = [String:Int]()
    var currentMonthSuccessScheduleArr: [String] = []
    var currentMonthSuccessScheduleValueArr: [Int] = []
    
    // Realm
    var successTasksInMonth: Results<UserSchedule>!
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        mainView.backgroundColor = .systemBackground
        
//        let components = calendar.dateComponents([.year, .month], from: now)
//        let startOfMonth = calendar.date(from: components)!
//
//        totalScheduleCountInMonth = repository.scheduleInMonth(currentDate: startOfMonth).count
//        successScheduleCountFromToday = repository.successScheduleInMonthFromToday(startOfMonth: startOfMonth).count
//        failScheduleCountFromToday = repository.failScheduleInMonthFromToday(startOfMonth: startOfMonth).count
//
//        mainView.monthPickerButton.setTitle("\(todayYear)년 \(todayMonth)월", for: .normal)
        
        makeAvailableDate()

        print("todayYear:\(todayYear)")
        print("todayMonth:\(todayMonth)")
        
        // 차트 가운데 퍼센트
//        mainView.currentMonthSuccessChart.centerText = "50%"
        
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

//        let components = calendar.dateComponents([.year, .month], from: now)
//        let startOfMonth = calendar.date(from: components)!
       
//        totalScheduleCountInMonth = repository.scheduleInMonth(currentDate: startOfMonth).count
//        successScheduleCountFromToday = repository.successScheduleInMonthFromToday(startOfMonth: startOfMonth).count
//        failScheduleCountFromToday = repository.failScheduleInMonthFromToday(startOfMonth: startOfMonth).count
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
                mainView.currentMonthSchedulePercentageChart.noDataText = "데이터가 없습니다."
                mainView.currentMonthSchedulePercentageChart.noDataFont = .systemFont(ofSize: 20)
                mainView.currentMonthSchedulePercentageChart.noDataTextColor = .black
        
        // 스케쥴 진행률 차트
        currentMonthSuccessValues[0] = successScheduleCountFromToday
        currentMonthSuccessValues[1] = failScheduleCountFromToday
        currentMonthSuccessValues[2] = totalScheduleCountInMonth - (successScheduleCountFromToday + failScheduleCountFromToday)

        customizeChart(dataPoints: currentMonthSuccess, values: currentMonthSuccessValues.map { Double($0) })
        customizeChart2(dataPoints: currentMonthSuccessScheduleArr, values: currentMonthSuccessScheduleValueArr.map { Double($0) })
        
        mainView.currentMonthSchedulePercentageChart.noDataText = "데이터가 없습니다."
        mainView.currentMonthSchedulePercentageChart.noDataFont = .systemFont(ofSize: 20)
        mainView.currentMonthSchedulePercentageChart.noDataTextColor = .black

        mainView.currentMonthSuccessChart.animate(xAxisDuration: 1.0)
        mainView.currentMonthSchedulePercentageChart.animate(xAxisDuration: 1.0)
        
//        mainView.monthPickerButton.setTitle("\(todayYear)년 \(todayMonth)월", for: .normal)
    }
    
    override func configure() {
        
        let components = calendar.dateComponents([.year, .month], from: now)
        let nowYear = calendar.dateComponents([.year], from: now)
        let nowMonth = calendar.dateComponents([.month], from: now)
        
        let startOfMonth = calendar.date(from: components)!
        let currentMonthSuccessScheduleCount = repository.successScheduleInMonth(currentDate: startOfMonth).count
        var sameScheduleIndex = 0

        for i in 0..<currentMonthSuccessScheduleCount {

            let scheduleKey = repository.successScheduleInMonth(currentDate: startOfMonth)[i].schedule
            let sameScheduleCount = repository.successScheduleNumber(key: scheduleKey).count

            // 각각의 스케쥴(키)마다 인덱스를 부여하고 같은스케쥴의 개수를 파악한다.
            // 그 다음 인덱스가 개수보다 많으면 다음 스케쥴로 넘어가기 때문에 인덱스를 다시 0으로 바꿔줘서 맞춰줌
            if sameScheduleIndex < sameScheduleCount {
                let startTimeStr = repository.successScheduleNumber(key: scheduleKey)[sameScheduleIndex].startTime
                let endTimeStr = repository.successScheduleNumber(key: scheduleKey)[sameScheduleIndex].endTime

                let startTime = DateFormatChange.shared.dateOfHourAndPM.date(from: startTimeStr)!.timeIntervalSince1970 / 3600
                let endTime = DateFormatChange.shared.dateOfHourAndPM.date(from: endTimeStr)!.timeIntervalSince1970 / 3600

                successScheduleDic.updateValue((successScheduleDic[scheduleKey] ?? 0)+Int(endTime - startTime),
                                               forKey: repository.successScheduleInMonth(currentDate: startOfMonth)[i].schedule)

                sameScheduleIndex += 1
            } else {
                sameScheduleIndex = 0

                let startTimeStr = repository.successScheduleNumber(key: scheduleKey)[sameScheduleIndex].startTime
                let endTimeStr = repository.successScheduleNumber(key: scheduleKey)[sameScheduleIndex].endTime

                let startTime = DateFormatChange.shared.dateOfHourAndPM.date(from: startTimeStr)!.timeIntervalSince1970 / 60
                let endTime = DateFormatChange.shared.dateOfHourAndPM.date(from: endTimeStr)!.timeIntervalSince1970 / 60

                successScheduleDic.updateValue((successScheduleDic[scheduleKey] ?? 0)+Int(endTime - startTime),
                                               forKey: repository.successScheduleInMonth(currentDate: startOfMonth)[i].schedule)
            }
        }
        
        for (key, value) in successScheduleDic {
            currentMonthSuccessScheduleArr.append(key)
            currentMonthSuccessScheduleValueArr.append(value)
        }
        
        totalScheduleCountInMonth = repository.scheduleInMonth(currentDate: startOfMonth).count
        successScheduleCountFromToday = repository.successScheduleInMonthFromToday(startOfMonth: startOfMonth).count
        failScheduleCountFromToday = repository.failScheduleInMonthFromToday(startOfMonth: startOfMonth).count
        
        mainView.monthPickerButton.setTitle("\(components.year!)년 \(components.month!)월", for: .normal)
        
        print(nowYear)
        print(nowMonth)
        
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
        
        let ok = UIAlertAction(title: "확인", style: .default) { [self] (action) in
            
            // 딕셔너리 비워주기(월 바꿀때마다)
            self.successScheduleDic.removeAll()
            self.currentMonthSuccessScheduleArr = []
            self.currentMonthSuccessScheduleValueArr = []
            
            let startOfMonthStr = "\(self.selectedYear)-\(self.selectedMonth)"
            let monthPickerTitle = "\(self.selectedYear)년 \(self.selectedMonth)월"
            
            guard let startOfMonth = DateFormatChange.shared.dateOfYearMonth.date(from: startOfMonthStr) else {
                return
            }
            
            let currentMonthSuccessScheduleCount = repository.successScheduleInMonth(currentDate: startOfMonth).count
            var sameScheduleIndex = 0
              
            self.totalScheduleCountInMonth = self.repository.scheduleInMonth(currentDate: startOfMonth).count
            self.successScheduleCountFromToday = self.repository.successScheduleInMonthFromToday(startOfMonth: startOfMonth).count
            self.failScheduleCountFromToday = self.repository.failScheduleInMonthFromToday(startOfMonth: startOfMonth).count
            
            self.currentMonthSuccessValues[0] = self.successScheduleCountFromToday
            self.currentMonthSuccessValues[1] = self.failScheduleCountFromToday
            self.currentMonthSuccessValues[2] = self.totalScheduleCountInMonth - (self.successScheduleCountFromToday + self.failScheduleCountFromToday)
            
            for i in 0..<currentMonthSuccessScheduleCount {

                let scheduleKey = repository.successScheduleInMonth(currentDate: startOfMonth)[i].schedule
                let sameScheduleCount = repository.successScheduleNumber(key: scheduleKey).count
                
                print("scheduleKey: \(scheduleKey)")
                
                // 각각의 스케쥴(키)마다 인덱스를 부여하고 같은스케쥴의 개수를 파악한다.
                // 그 다음 인덱스가 개수보다 많으면 다음 스케쥴로 넘어가기 때문에 인덱스를 다시 0으로 바꿔줘서 맞춰줌
                if sameScheduleIndex < sameScheduleCount {
                    let startTimeStr = repository.successScheduleNumber(key: scheduleKey)[sameScheduleIndex].startTime
                    let endTimeStr = repository.successScheduleNumber(key: scheduleKey)[sameScheduleIndex].endTime
                    
                    print("startTimeStr :\(startTimeStr)")
                    print("endTimeStr : \(endTimeStr)")
                    
                    let startTime = DateFormatChange.shared.dateOfHourAndPM.date(from: startTimeStr)!.timeIntervalSince1970
                    let endTime = DateFormatChange.shared.dateOfHourAndPM.date(from: endTimeStr)!.timeIntervalSince1970

                    successScheduleDic.updateValue((successScheduleDic[scheduleKey] ?? 0)+Int(endTime - startTime),
                                                   forKey: repository.successScheduleInMonth(currentDate: startOfMonth)[i].schedule)
                    
                    sameScheduleIndex += 1
                    
                } else {
                    sameScheduleIndex = 0
                    
                    let startTimeStr = repository.successScheduleNumber(key: scheduleKey)[sameScheduleIndex].startTime
                    let endTimeStr = repository.successScheduleNumber(key: scheduleKey)[sameScheduleIndex].endTime
                    
                    print("startTimeStr :\(startTimeStr)")
                    print("endTimeStr : \(endTimeStr)")
                    
                    let startTime = DateFormatChange.shared.dateOfHourAndPM.date(from: startTimeStr)!.timeIntervalSince1970
                    let endTime = DateFormatChange.shared.dateOfHourAndPM.date(from: endTimeStr)!.timeIntervalSince1970

                    
                    
                    successScheduleDic.updateValue((successScheduleDic[scheduleKey] ?? 0)+Int(endTime - startTime),
                                                   forKey: repository.successScheduleInMonth(currentDate: startOfMonth)[i].schedule)

                    
                }
            }
            
            for (key, value) in successScheduleDic {
                currentMonthSuccessScheduleArr.append(key)
                currentMonthSuccessScheduleValueArr.append(value)
            }
            
            self.customizeChart(dataPoints: self.currentMonthSuccess, values: self.currentMonthSuccessValues.map { Double($0) })
            self.customizeChart2(dataPoints: self.currentMonthSuccessScheduleArr, values: self.currentMonthSuccessScheduleValueArr.map { Double($0) })
            

            
            
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
        pieChartDataSet.colors = [.mainGreen, .mainRed, .mainGray]
        
        // 3. Set ChartData
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        let format = NumberFormatter()
        format.numberStyle = .none
        let formatter = DefaultValueFormatter(formatter: format)
        pieChartData.setValueFormatter(formatter)
        
        mainView.currentMonthSuccessChart.data = pieChartData
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
        pieChartDataSet.colors = colorsOfCharts(numberOfColors: dataPoints.count) // 여기입니다
        
        // 3. Set ChartData
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        let format = NumberFormatter()
        format.numberStyle = .none
        let formatter = DefaultValueFormatter(formatter: format)
        pieChartData.setValueFormatter(formatter)
        
        mainView.currentMonthSchedulePercentageChart.data = pieChartData
    }
    
    private func colorsOfCharts(numberOfColors: Int) -> [UIColor] {
        var colors: [UIColor] = []
        
        var firstAlpha = 0.2
        let space = 0.8 / Double(numberOfColors)
        
        for _ in 0..<numberOfColors {
//            let red = Double(arc4random_uniform(256))
//            let green = Double(arc4random_uniform(256))
//            let blue = Double (arc4random_uniform(256))
//            let color = UIColor(red: CGFloat(red/255),
//                                green: CGFloat(green/255),
//                                blue: CGFloat(blue/255),
//                                alpha: 0.8)
            
            let color = UIColor.mainNavy.withAlphaComponent(firstAlpha)
            
            firstAlpha += space
            
            colors.append(color)
               
        }
        return colors
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
        
//        if (Int(todayYear) == selectedYear && Int(todayMonth)! < selectedMonth) {
//            pickerView.selectRow(Int(todayMonth)!-1, inComponent: 1, animated: true)
//            selectedMonth = Int(todayMonth)!
//        }
    }
}


