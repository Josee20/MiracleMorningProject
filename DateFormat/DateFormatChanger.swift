//
//  DateFormatChanger.swift
//  MiracleMorningProject
//
//  Created by 이동기 on 2022/09/22.
//

import Foundation

class DateFormatChange {
    
    private init() { }
    
    static let shared = DateFormatChange()
    
    let fullDate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        formatter.locale = Locale.current
        formatter.dateFormat = "M/dd(EEEEEE) a hh:mm"
        return formatter
    }()
    
    let endOfDayTime: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = "yyyy-MM-dd hh:mm:ss +0000"
        return formatter
    }()
    
    let dateOfHour: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = "hh:mm"
        return formatter
    }()
    
    let dateOfHourAndPM: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = "a hh:mm"
        return formatter
    }()
    
    let dateOfYearMonthDay: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    let dateOfYearMonth: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = "yyyy-MM"
        return formatter
    }()
    
    let dateOfMonth: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = "M월 dd일"
        return formatter
    }()
    
    let dateOfOnlyYear: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = "yyyy"
        return formatter
    }()
    
    let dateOfOnlyMonth: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = "MM"
        return formatter
    }()
}
