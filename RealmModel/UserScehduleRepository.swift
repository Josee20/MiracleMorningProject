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
    func delete(item: UserSchedule?)
    func filterDayTasksAndSuccess(date: Date) -> Results<UserSchedule>
    func scheduleInMonth(currentDate: Date) -> Results<UserSchedule>
    func successScheduleInMonth(currentDate: Date) -> Results<UserSchedule>
    func failScheduleInMonth(currentDate: Date) -> Results<UserSchedule>
    func successScheduleInMonthFromToday(startOfMonth: Date) -> Results<UserSchedule>
    func failScheduleInMonthFromToday(startOfMonth: Date) -> Results<UserSchedule>
    func numberOfScheduleFromToday(startOfMonth: Date) -> Results<UserSchedule>
    func successScheduleNumber(key: String) -> Results<UserSchedule>
    func updateSchedule(objectID: ObjectId, startTime: String, endTime: String, schedule: String)
    func changeSchedule(objectID: ObjectId, startTime: String, endTime: String, schedule: String, scheduleDate: Date, scheduleSuccess: Bool)
    func updateSuccess(item: UserSchedule)
}

class UserScheduleRepository: UserScheduleRepositoryType {
    
    let localRealm = try! Realm()
    
    let calendar = Calendar.current
    let date = Date()
    let now = Date()
    
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
            $0.scheduleDate >= calendar.startOfDay(for: date) && $0.scheduleDate < calendar.startOfDay(for: date)  + 86400
        }
    }
    
    func filterDayTasksAndSuccess(date: Date) -> Results<UserSchedule> {
        return localRealm.objects(UserSchedule.self).where {
            $0.scheduleDate >= calendar.startOfDay(for: date) && $0.scheduleDate < calendar.startOfDay(for: date)  + 86400 && $0.scheduleSuccess == true
        }
    }
    
    func scheduleInMonth(currentDate: Date) -> Results<UserSchedule> {
        let nextMonth = calendar.date(byAdding: .month, value: +1, to: currentDate)

        return localRealm.objects(UserSchedule.self).where {
            $0.scheduleDate >= currentDate && $0.scheduleDate < nextMonth!
        }
    }
    
    func successScheduleInMonthFromToday(startOfMonth: Date) -> Results<UserSchedule> {
        let startOfTomorrow = calendar.startOfDay(for: now) + 86400
        
        return localRealm.objects(UserSchedule.self).where {
            $0.scheduleSuccess == true && $0.scheduleDate >= startOfMonth && $0.scheduleDate < startOfTomorrow
        }
    }
    
    func failScheduleInMonthFromToday(startOfMonth: Date) -> Results<UserSchedule> {
        let startOfTomorrow = calendar.startOfDay(for: now) + 86400
        
        return localRealm.objects(UserSchedule.self).where {
            $0.scheduleSuccess == false && $0.scheduleDate >= startOfMonth && $0.scheduleDate < startOfTomorrow
        }
    }
    
    func numberOfScheduleFromToday(startOfMonth: Date) -> Results<UserSchedule> {
        let startOfTomorrow = calendar.startOfDay(for: now) + 86400
        
        return localRealm.objects(UserSchedule.self).where {
            $0.scheduleDate >= startOfMonth && $0.scheduleDate < startOfTomorrow
        }
    }
    
    func successScheduleInMonth(currentDate: Date) -> Results<UserSchedule> {

        let nextMonth = calendar.date(byAdding: .month, value: +1, to: currentDate)

        return localRealm.objects(UserSchedule.self).where {
            $0.scheduleSuccess == true && $0.scheduleDate >= currentDate && $0.scheduleDate < nextMonth!
        }
    }
    
    func failScheduleInMonth(currentDate: Date) -> Results<UserSchedule> {

        let nextMonth = calendar.date(byAdding: .month, value: +1, to: currentDate)

        return localRealm.objects(UserSchedule.self).where {
            $0.scheduleSuccess == false && $0.scheduleDate >= currentDate && $0.scheduleDate < nextMonth!
        }
    }
    
    
    func successScheduleNumber(key: String) -> Results<UserSchedule> {
        return localRealm.objects(UserSchedule.self).filter("scheduleSuccess == true AND schedule == '\(key)'")
    }
    
    func updateSchedule(objectID: ObjectId, startTime: String, endTime: String, schedule: String) {
        
        do {
            try localRealm.write {
                localRealm.create(UserSchedule.self, value: ["objectID": objectID, "startTime": startTime, "endTime":endTime, "schedule":schedule], update: .modified)
            }
        } catch {
            print("update error")
        }
    }
    
    func changeSchedule(objectID: ObjectId, startTime: String, endTime: String, schedule: String, scheduleDate: Date, scheduleSuccess: Bool) {
        
        do {
            try localRealm.write {
                localRealm.create(UserSchedule.self, value: ["objectID": objectID, "startTime": startTime, "endTime":endTime, "schedule":schedule, "scheduleDate":scheduleDate, "scheduleSuccess":scheduleSuccess ], update: .modified)
            }
        } catch {
            print("update error")
        }
    }
    
    func updateSuccess(item: UserSchedule) {
        do {
            try localRealm.write {
                item.scheduleSuccess = true
            }
        } catch {
            print("success update error")
        }
        
    }
    
}
