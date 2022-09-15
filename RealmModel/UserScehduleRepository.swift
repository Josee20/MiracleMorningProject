//
//  UserScehduleRepository.swift
//  MiracleMorningProject
//
//  Created by 이동기 on 2022/09/15.
//

import Foundation

import RealmSwift

protocol UserScheduleRepositoryType {
    func fetch() -> Results<UserSchedule>
    func addSchedule(startTime: String, endTime: String, date: Date, schedule: String, success: Bool)
}

class UserScheduleRepository: UserScheduleRepositoryType {
    
    let localRealm = try! Realm()
    
    func fetch() -> Results<UserSchedule> {
        return localRealm.objects(UserSchedule.self)
    }
    
    func addSchedule(startTime: String, endTime: String, date: Date, schedule: String, success: Bool) {
        
        let task = UserSchedule(startTime: startTime, endTime: endTime, scheduleDate: date, schedule: schedule, scheduleSuccess: success)
        
        do {
            try localRealm.write {
                localRealm.add(task)
            }
        } catch {
            print("add schedule error")
        }
    }
    
}
