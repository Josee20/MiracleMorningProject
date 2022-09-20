//
//  RealmModel.swift
//  MiracleMorningProject
//
//  Created by 이동기 on 2022/09/15.
//

import Foundation

import RealmSwift

class UserSchedule: Object {
    @Persisted var startTime: String
    @Persisted var endTime: String
    @Persisted var scheduleDate = Date()
    @Persisted var schedule: String
    @Persisted var scheduleSuccess: Bool
    
    @Persisted(primaryKey: true) var objectID: ObjectId
    
    convenience init(startTime: String, endTime: String, scheduleDate: Date, schedule: String, scheduleSuccess: Bool) {
        self.init()
        self.startTime = startTime
        self.endTime = endTime
        self.scheduleDate = scheduleDate
        self.schedule = schedule
        self.scheduleSuccess = scheduleSuccess
    }
}
