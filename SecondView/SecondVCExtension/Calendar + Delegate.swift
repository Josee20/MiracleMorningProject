//
//  Calendar + Extension.swift
//  MiracleMorningProject
//
//  Created by 이동기 on 2022/09/24.
//

import UIKit

import FSCalendar

//enum ColorSet {
//    firstColor = R: 253 G: 242 B: 235
//    secondColor = R: 242 G: 188 B: 153
//    thirdColor = R: 240 G: 145 B: 89
//    forthColor = R: 238 G: 123 B: 63
//}

enum EventDotColor {
    static let successZeroTime = [UIColor.systemGray3, UIColor.systemGray3, UIColor.systemGray3]
    static let successOneTime = [UIColor.systemOrange, UIColor.systemGray3, UIColor.systemGray3]
    static let successTwoTime = [UIColor.systemOrange, UIColor.systemOrange, UIColor.systemGray3]
    static let successThreeTime = [UIColor.systemOrange, UIColor.systemOrange, UIColor.systemOrange]
}

extension SecondViewController: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    
    // ... 개수
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {

        let eventStringArr = eventArr.map { DateFormatChange.shared.dateOfYearMonthDay.string(from: $0) }
        let eventDateArr = eventStringArr.map { DateFormatChange.shared.dateOfYearMonthDay.date(from: $0) }
                
        if eventDateArr.contains(date) {
    
            
            return repository.filterDayTasks(date: date).count
        } else {
            return 0
        }
    }
    
    // ... 색깔
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventDefaultColorsFor date: Date) -> [UIColor]? {
        
        var successCount = 0
        
        dayTasks = repository.filterDayTasks(date: date)
        
        for i in 0..<dayTasks.count {
            if dayTasks[i].scheduleSuccess == true {
                successCount += 1
            }
        }
        
        switch successCount {
        case 0:
            return EventDotColor.successZeroTime
        case 1:
            return EventDotColor.successOneTime
        case 2:
            return EventDotColor.successTwoTime
        case 3:
            return EventDotColor.successThreeTime
        default:
            return EventDotColor.successThreeTime
        }
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventSelectionColorsFor date: Date) -> [UIColor]? {
        
        var successCount = 0
        
        dayTasks = repository.filterDayTasks(date: date)
        
        for i in 0..<dayTasks.count {
            if dayTasks[i].scheduleSuccess == true {
                successCount += 1
            }
        }
        
        switch successCount {
        case 0:
            return EventDotColor.successZeroTime
        case 1:
            return EventDotColor.successOneTime
        case 2:
            return EventDotColor.successTwoTime
        case 3:
            return EventDotColor.successThreeTime
        default:
            return EventDotColor.successThreeTime
        }
    }
    
    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {

        let cell = calendar.dequeueReusableCell(withIdentifier: "CELL", for: date, at: position)

        return cell
    }
    
    // 선택시 날짜 테두리 색상
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, borderSelectionColorFor date: Date) -> UIColor? {
        return UIColor.black
    }
    
    // 오늘날짜 -> "오늘"
    func calendar(_ calendar: FSCalendar, titleFor date: Date) -> String? {
        switch DateFormatChange.shared.dateOfYearMonthDay.string(from: date) {
        case DateFormatChange.shared.dateOfYearMonthDay.string(from: now):
            return "오늘"
        default:
            return nil
        }
    }
    
    
    // 캘린더 날짜 선택
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        selectedDate = date
        scheduleInfo = []
        
        dayTasks = repository.filterDayTasks(date: date)
        self.fetchRealm()

        mainView.tableViewHeaderLabel.text = DateFormatChange.shared.dateOfMonth.string(from: date)
        
        if date < Calendar.current.startOfDay(for: now) - 86400 + 3600 * 9 {
            mainView.tableView.isUserInteractionEnabled = false
        } else {
            mainView.tableView.isUserInteractionEnabled = true
        }
        
        // 캘린더 스와이프시에 테이블뷰 나타내기
        mainView.tableView.isHidden = false
    }
    
    // 캘린더 스와이프
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {

        let currentPageDate = calendar.currentPage
        let month = Calendar.current.component(.month, from: currentPageDate)
        
        scheduleCountDic = [:]
        
        // 스와이프시 date값을 변경시켜야 다른 페이지를 갔다와도 해당 월의 스케쥴 성공여부가 컬렉션뷰에 잘 나옴
        date = currentPageDate
        
        for i in 0..<repository.successSchedule(currentDate: currentPageDate).count {
            scheduleCountDic.updateValue(repository.successScheduleNumber(key: repository.successSchedule(currentDate: currentPageDate)[i].schedule).count, forKey: repository.successSchedule(currentDate: currentPageDate)[i].schedule)
        }
        
        mainView.collectionViewHeaderLabel.text = "\(month)월 미션 현황"
                
        // 캘린더 스와이프시에 테이블뷰 숨기기
        mainView.tableView.isHidden = true

        mainView.collectionView.reloadData()
    }
}

