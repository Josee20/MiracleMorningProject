//
//  ThirdViewController.swift
//  MiracleMorningProject
//
//  Created by 이동기 on 2022/09/11.
//

import UIKit

import Charts
import RealmSwift

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
    var currentMonthSuccess: [String] = []
    var currentMonthSuccessValues: [Int] = []
    
    // 스케쥴 성공 시간
    var successScheduleDic = [String:Int]()
    var currentMonthSuccessScheduleArr: [String] = []
    var currentMonthSuccessScheduleValueArr: [Int] = []
    
//    var currentMonthSuccessScheduleArr = Set<String>()
//    var currentMonthSuccessScheduleValueArr: Set<Int>()
    
    // Realm
    var successTasksInMonth: Results<UserSchedule>!
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        mainView.backgroundColor = .systemBackground

        makeAvailableDate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let components = calendar.dateComponents([.year, .month], from: now)
        let startOfMonth = calendar.date(from: components)!
        let currentMonthSuccessScheduleCount = repository.successScheduleInMonth(currentDate: startOfMonth).count
        var sameScheduleIndex = 0

        self.currentMonthSuccess = []
        self.currentMonthSuccessValues = []
        
        // 값이 계속 쌓이는 것을 막기위해 딕셔너리 비워줌
        successScheduleDic.removeAll()
        
        // viewWillAppear 할 때마다 배열을 비워줘야 값이 계속 안 쌓임
        currentMonthSuccessScheduleArr = []
        currentMonthSuccessScheduleValueArr = []
        
        for i in 0..<currentMonthSuccessScheduleCount {

            let scheduleKey = repository.successScheduleInMonth(currentDate: startOfMonth)[i].schedule
            let sameScheduleCount = repository.successScheduleNumber(key: scheduleKey).count

            // 각각의 스케쥴(키)마다 인덱스를 부여하고 같은스케쥴의 개수를 파악한다.
            // 그 다음 인덱스가 개수보다 많으면 다음 스케쥴로 넘어가기 때문에 인덱스를 다시 0으로 바꿔줘서 맞춰줌
            if sameScheduleIndex < sameScheduleCount {
                let startTimeStr = repository.successScheduleNumber(key: scheduleKey)[sameScheduleIndex].startTime
                let endTimeStr = repository.successScheduleNumber(key: scheduleKey)[sameScheduleIndex].endTime

                let startTime = DateFormatChange.shared.dateOfHourAndPM.date(from: startTimeStr)!.timeIntervalSince1970
                let endTime = DateFormatChange.shared.dateOfHourAndPM.date(from: endTimeStr)!.timeIntervalSince1970

                successScheduleDic.updateValue((successScheduleDic[scheduleKey] ?? 0)+Int(endTime - startTime),
                                               forKey: repository.successScheduleInMonth(currentDate: startOfMonth)[i].schedule)

                sameScheduleIndex += 1
            } else {
                sameScheduleIndex = 0

                let startTimeStr = repository.successScheduleNumber(key: scheduleKey)[sameScheduleIndex].startTime
                let endTimeStr = repository.successScheduleNumber(key: scheduleKey)[sameScheduleIndex].endTime

                let startTime = DateFormatChange.shared.dateOfHourAndPM.date(from: startTimeStr)!.timeIntervalSince1970
                let endTime = DateFormatChange.shared.dateOfHourAndPM.date(from: endTimeStr)!.timeIntervalSince1970

                successScheduleDic.updateValue((successScheduleDic[scheduleKey] ?? 0)+Int(endTime - startTime),
                                               forKey: repository.successScheduleInMonth(currentDate: startOfMonth)[i].schedule)
            }
        }

        let sortedSuccessScheduleDic = successScheduleDic.sorted { (first, second) in
            return first.value < second.value
        }

        for (key, value) in sortedSuccessScheduleDic {
            if currentMonthSuccessScheduleArr.count < 8 {
                currentMonthSuccessScheduleArr.append(key)
                currentMonthSuccessScheduleValueArr.append(value)
            }

            continue
        }

        totalScheduleCountInMonth = repository.scheduleInMonth(currentDate: startOfMonth).count
        successScheduleCountFromToday = repository.successScheduleInMonthFromToday(startOfMonth: startOfMonth).count
        failScheduleCountFromToday = repository.failScheduleInMonthFromToday(startOfMonth: startOfMonth).count
        
        self.currentMonthSuccess.append(contentsOf: ["성공", "실패", "미진행"])
        self.currentMonthSuccessValues.append(contentsOf: [self.successScheduleCountFromToday, self.failScheduleCountFromToday, self.totalScheduleCountInMonth - (self.successScheduleCountFromToday + self.failScheduleCountFromToday)])

        mainView.monthPickerButton.setTitle("\(components.year!)년 \(components.month!)월 ", for: .normal)
        
        print(#function)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        customizeChart(dataPoints: currentMonthSuccess, values: currentMonthSuccessValues.map { Double($0) })
        customizeChart2(dataPoints: currentMonthSuccessScheduleArr, values: currentMonthSuccessScheduleValueArr.map { Double($0) })

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
        
        let ok = UIAlertAction(title: "확인", style: .default) { [self] (action) in
            
            // 딕셔너리 비워주기(월 바꿀때마다)
            
            var totalSchedulesInMonth = 0
            var successSchedulesInMonth = 0
            var failSchedulesInMonth = 0
            
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
              
            totalSchedulesInMonth = self.repository.scheduleInMonth(currentDate: startOfMonth).count
            successSchedulesInMonth = self.repository.successScheduleInMonth(currentDate: startOfMonth).count
            failSchedulesInMonth = self.repository.failScheduleInMonth(currentDate: startOfMonth).count
            
            guard totalSchedulesInMonth != 0 else {
                showAlertOnlyOk(title: "선택하신 월의 데이터가 없습니다")
                return
            }
            
//            self.currentMonthSuccess.append(contentsOf: ["성공", "실패", "미진행"])
            
            
            for i in 0..<currentMonthSuccessScheduleCount {
                
                let scheduleKey = repository.successScheduleInMonth(currentDate: startOfMonth)[i].schedule
                let sameScheduleCount = repository.successScheduleNumber(key: scheduleKey).count

                // 각각의 스케쥴(키)마다 인덱스를 부여하고 같은스케쥴의 개수를 파악한다.
                // 그 다음 인덱스가 개수보다 많으면 다음 스케쥴로 넘어가기 때문에 인덱스를 다시 0으로 바꿔줘서 맞춰줌
                if sameScheduleIndex < sameScheduleCount {
                    let startTimeStr = repository.successScheduleNumber(key: scheduleKey)[sameScheduleIndex].startTime
                    let endTimeStr = repository.successScheduleNumber(key: scheduleKey)[sameScheduleIndex].endTime

                    let startTime = DateFormatChange.shared.dateOfHourAndPM.date(from: startTimeStr)!.timeIntervalSince1970
                    let endTime = DateFormatChange.shared.dateOfHourAndPM.date(from: endTimeStr)!.timeIntervalSince1970

                    successScheduleDic.updateValue((successScheduleDic[scheduleKey] ?? 0)+Int(endTime - startTime),
                                                   forKey: repository.successScheduleInMonth(currentDate: startOfMonth)[i].schedule)

                    sameScheduleIndex += 1

                } else {
                    sameScheduleIndex = 0

                    let startTimeStr = repository.successScheduleNumber(key: scheduleKey)[sameScheduleIndex].startTime
                    let endTimeStr = repository.successScheduleNumber(key: scheduleKey)[sameScheduleIndex].endTime

                    let startTime = DateFormatChange.shared.dateOfHourAndPM.date(from: startTimeStr)!.timeIntervalSince1970
                    let endTime = DateFormatChange.shared.dateOfHourAndPM.date(from: endTimeStr)!.timeIntervalSince1970

                    successScheduleDic.updateValue((successScheduleDic[scheduleKey] ?? 0)+Int(endTime - startTime),
                                                   forKey: repository.successScheduleInMonth(currentDate: startOfMonth)[i].schedule)
                }
            }
            
            let sortedSuccessScheduleDic = successScheduleDic.sorted { (first, second) in
                return first.value < second.value
            }
            
            for (key, value) in sortedSuccessScheduleDic {
                if currentMonthSuccessScheduleArr.count < 8 {
                    currentMonthSuccessScheduleArr.append(key)
                    currentMonthSuccessScheduleValueArr.append(value)
                }
                
                continue
            }
            
            self.currentMonthSuccessValues[0] = successSchedulesInMonth
            self.currentMonthSuccessValues[1] = failSchedulesInMonth
            self.currentMonthSuccessValues[2] = totalSchedulesInMonth - (successSchedulesInMonth + failSchedulesInMonth)

            self.customizeChart(dataPoints: self.currentMonthSuccess, values: self.currentMonthSuccessValues.map { Double($0) })
            self.customizeChart2(dataPoints: self.currentMonthSuccessScheduleArr, values: self.currentMonthSuccessScheduleValueArr.map { Double($0) })
            self.mainView.monthPickerButton.setTitle(monthPickerTitle + " ", for: .normal)
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alert.addAction(ok)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
    
    func customizeChart(dataPoints: [String], values: [Double]) {
        
        // 1. Set ChartDateEntry
        var dataEntries: [ChartDataEntry] = []
        var legendEntries: [LegendEntry] = []
        let legendColors: [UIColor] = [.successColor, .failColor, .notDoColor]
        
        for i in 0..<dataPoints.count {
            
            if values[0] == 0 && values[1] == 0 && values[2] == 0 {
                return
            } else {
                let dataEntry = PieChartDataEntry(value: values[i], label: nil, data: dataPoints[i] as AnyObject)
                dataEntries.append(dataEntry)
                
                // legendEntry 배열에 담아주기
                let legendEntry = LegendEntry.init(label: "\(dataPoints[i]): \(Int(values[i]))회", form: .default, formSize: CGFloat.nan, formLineWidth: CGFloat.nan, formLineDashPhase: CGFloat.nan, formLineDashLengths: nil, formColor: legendColors[i])
                legendEntries.append(legendEntry)
            }
        }
        
        // legendEntires 배열 커스텀으로 등록
        mainView.currentMonthSuccessChart.legend.setCustom(entries: legendEntries)
    
        
        //2. Set ChartDataSet
        let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: nil)
        pieChartDataSet.highlightEnabled = false
        pieChartDataSet.colors = legendColors
        pieChartDataSet.sliceSpace = 2.0
        pieChartDataSet.valueTextColor = .black
        pieChartDataSet.valueLinePart1Length = 0.4
        pieChartDataSet.valueLinePart2Length = 0.8
        
        // 3. Set ChartData
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        let format = NumberFormatter()
        format.numberStyle = .percent
        format.maximumFractionDigits = 1
        format.multiplier = 1
        format.percentSymbol = "%"
        let formatter = DefaultValueFormatter(formatter: format)
        pieChartData.setValueFormatter(formatter)
        
        mainView.currentMonthSuccessChart.data = pieChartData
        
    }
    
    func customizeChart2(dataPoints: [String], values: [Double]) {
        
        // 1. Set ChartDateEntry
        var dataEntries: [ChartDataEntry] = []
        var legendEntries: [LegendEntry] = []
        let legendColors: [UIColor] = [.vividGreen, .dustyGreen, .vividBlue, .vividPurple, .vividYellow, .dustyYellow, .vividPink, .dustyPink]
        
        if dataPoints.isEmpty {
            return
        }
        
        for i in 0..<dataPoints.count {
            let dataEntry = PieChartDataEntry(value: values[i], label: nil, data: dataPoints[i] as AnyObject)
            dataEntries.append(dataEntry)
            
            let legendEntry = LegendEntry.init(label: "\(dataPoints[dataPoints.count-i-1]): \(Int(values[dataPoints.count-i-1])/60)분", form: .default, formSize: CGFloat.nan, formLineWidth: CGFloat.nan, formLineDashPhase: CGFloat.nan, formLineDashLengths: nil, formColor: legendColors[dataPoints.count-i-1])
            legendEntries.append(legendEntry)
        }
        
        mainView.currentMonthSchedulePercentageChart.legend.setCustom(entries: legendEntries)
        
        //2. Set ChartDataSet
        let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: nil)
        pieChartDataSet.highlightEnabled = false
        pieChartDataSet.colors = legendColors
        pieChartDataSet.sliceSpace = 2.0
        pieChartDataSet.yValuePosition = .outsideSlice
        pieChartDataSet.valueLinePart1Length = 0.4
        pieChartDataSet.valueTextColor = .black

        // 3. Set ChartData
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        let format = NumberFormatter()
        format.numberStyle = .percent
        format.maximumFractionDigits = 1
        format.multiplier = 1
        format.percentSymbol = "%"
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
        
//        if (Int(todayYear) == selectedYear && Int(todayMonth)! < selectedMonth) {
//            pickerView.selectRow(Int(todayMonth)!-1, inComponent: 1, animated: true)
//            selectedMonth = Int(todayMonth)!
//        }
    }
}


