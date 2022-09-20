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
    func filterDayTasks(date: Date) -> Results<UserSchedule>
}

class UserScheduleRepository: UserScheduleRepositoryType {
    
    let localRealm = try! Realm()
    
    let calendar = Calendar.current

    
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
    
    func delete(item: UserSchedule?) {
        
        do {
            try localRealm.write {
                localRealm.delete(item!)
            }
        } catch {
            print("cell delete error")
        }
        
    }
    
    
    func filterDayTasks(date: Date) -> Results<UserSchedule> {
        
        return localRealm.objects(UserSchedule.self).where {
            $0.scheduleDate >= calendar.startOfDay(for: date) + 3600 * 9 && $0.scheduleDate < calendar.startOfDay(for: date) + 86400 + 3600 * 9
            
        }
    }
    
    
    func successSchedule() -> Results<UserSchedule> {
        return localRealm.objects(UserSchedule.self).filter("scheduleSuccess == true")
    }
    
    func successScheduleNumber(key: String) -> Results<UserSchedule> {
        return localRealm.objects(UserSchedule.self).filter("scheduleSuccess == true AND schedule == '\(key)'")
    }
}
