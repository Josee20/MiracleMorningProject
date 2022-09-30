//
//  Calendar + Extension.swift
//  MiracleMorningProject
//
//  Created by 이동기 on 2022/09/24.
//

import UIKit

import FSCalendar

enum EventDotColor {
    static let successZeroTime = [UIColor.systemGray3, UIColor.systemGray3, UIColor.systemGray3]
    static let successOneTime = [UIColor.systemGreen, UIColor.systemGray3, UIColor.systemGray3]
    static let successTwoTime = [UIColor.systemGreen, UIColor.systemGreen, UIColor.systemGray3]
    static let successThreeTime = [UIColor.systemGreen, UIColor.systemGreen, UIColor.systemGreen]
}

extension SecondViewController: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    
    // ... 개수
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {

        let eventStringArr = eventArr.map { DateFormatChange.shared.dateOfYearMonthDay.string(from: $0) }
        let eventDateArr = eventStringArr.map { DateFormatChange.shared.dateOfYearMonthDay.date(from: $0) }
                
        if eventDateArr.contains(date) {
            switch repository.filterDayTasks(date: date).count {
            case 0:
                return 0
            case 1:
                return 1
            case 2:
                return 2
            case 3:
                return 3
            default:
                return 3
            }
        } else {
            return 0
        }
    }
    
    // ... 색깔
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventDefaultColorsFor date: Date) -> [UIColor]? {
        
        dayTasksAndSuccess = repository.filterDayTasksAndSuccess(date: date)
        
        switch dayTasksAndSuccess.count {
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

        switch dayTasksAndSuccess.count {
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
    

    
//    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillSelectionColorFor date: Date) -> UIColor? {
//        <#code#>
//    }
    
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
        
        self.fetchRealm()

        mainView.tableViewHeaderLabel.text = DateFormatChange.shared.dateOfMonth.string(from: date)
        
        // 캘린더 스와이프시에 테이블뷰 나타내기
        mainView.tableView.isHidden = false
    }
    
    // 캘린더 스와이프
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {

        let currentPageDate = calendar.currentPage
        let month = Calendar.current.component(.month, from: currentPageDate)
        
        scheduleCountDic = [:]
        successCount = 0
        
        // 스와이프시 date값을 변경시켜야 다른 페이지를 갔다와도 해당 월의 스케쥴 성공여부가 컬렉션뷰에 잘 나옴
        date = currentPageDate
        
        for i in 0..<repository.successScheduleInMonth(currentDate: currentPageDate).count {
            scheduleCountDic.updateValue(repository.successScheduleNumber(key: repository.successScheduleInMonth(currentDate: currentPageDate)[i].schedule).count, forKey: repository.successScheduleInMonth(currentDate: currentPageDate)[i].schedule)
        }
        
        mainView.collectionViewHeaderLabel.text = "\(month)월 미션 현황"
                
        // 캘린더 스와이프시에 테이블뷰 숨기기
        mainView.tableView.isHidden = true

        mainView.collectionView.reloadData()
    }
}


