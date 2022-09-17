//
//  DateFormat.swift
//  MiracleMorningProject
//
//  Created by 이동기 on 2022/09/11.
//

import Foundation

class DateFormatChange {
    
    private init() { }
    
    static let shared = DateFormatChange()
    
    let fullDate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "M/dd(EEEEEE) a hh:mm"
        return formatter
    }()
    
    let dateOfHour: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "hh:mm"
        return formatter
    }()
    
    let dateOfHourAndPM: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "a hh:mm"
        return formatter
    }()
    
    let dateOfYearMonthDay: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
}
