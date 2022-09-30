//
//  TableView + Delegate.swift
//  MiracleMorningProject
//
//  Created by 이동기 on 2022/09/25.
//

import UIKit

extension SecondViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dayTasks.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SecondTableViewCell.reuseIdentifier, for: indexPath) as? SecondTableViewCell else {
            return UITableViewCell()
        }
        
        cell.selectionStyle = .none
        cell.scheduleTitle.text = dayTasks[indexPath.row].schedule
        cell.scheduleTime.text = "\(dayTasks[indexPath.row].startTime)~\(dayTasks[indexPath.row].endTime)"
        dayTasks[indexPath.row].scheduleSuccess == true ? cell.checkButton.setImage(UIImage(systemName: "checkmark.square", withConfiguration: buttonSizeConfiguration) , for: .normal) : cell.checkButton.setImage(UIImage(systemName: "x.square", withConfiguration: buttonSizeConfiguration), for: .normal)

        return cell
    }
    
    // 스와이프 삭제
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
//        let components = calendar.dateComponents([.year, .month], from: date)
//        let startOfMonth = calendar.date(from: components)!
         
        if dayTasks[indexPath.row].scheduleSuccess == true {
            showAlertOnlyOk(title: "완료한 스케쥴은 삭제할 수 없습니다")
        } else {
            if dayTasks[indexPath.row].scheduleDate < calendar.startOfDay(for: now) + 86400 {
                showAlertOnlyOk(title: "지나간 일정이나 오늘 일정은 삭제할 수 없습니다.")
            } else {
                if editingStyle == .delete {
                    repository.delete(item: dayTasks?[indexPath.row])
                }
                
                mainView.calendar.reloadData()
                self.fetchRealm()
            }
        }
    }
    
    // 셀 선택
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
        let vc = ChangeScheduleViewController()
        
        vc.setScheduleTextFieldTitle = dayTasks[indexPath.row].schedule
        vc.startTimeButtonTitle = dayTasks[indexPath.row].startTime
        vc.endTimeButtonTitle = dayTasks[indexPath.row].endTime
        vc.objectID = dayTasks[indexPath.row].objectID
        vc.receivedDate = dayTasks[indexPath.row].scheduleDate
        
        // 지나간 날짜 + 현재 시간 기준 오전9시가 넘으면 수정 불가
        // 1. scheduleDate와 오늘 날짜가 같음
        // 2. 오전 9시 ~ 24시까지 사이엔 수정 불가
        
        if dayTasks[indexPath.row].scheduleSuccess == true {
            showAlertOnlyOk(title: "완료한 스케쥴은 수정할 수 없습니다")
        } else {
            if dayTasks[indexPath.row].scheduleDate < calendar.startOfDay(for: now) ||
                DateFormatChange.shared.dateOfYearMonthDay.string(from: dayTasks[indexPath.row].scheduleDate) == DateFormatChange.shared.dateOfYearMonthDay.string(from: now) &&
                (now > calendar.startOfDay(for: now) + 32400 && now < calendar.startOfDay(for: now) + 86400 ) {
                
                showAlertOnlyOk(title: "지나간 일정은 수정할 수 없습니다")
            } else {
                
                // 2. 클로저 함수 정의
                vc.okButtonActionHandler = {
                    self.mainView.tableView.reloadData()
                }
                
                let nav = UINavigationController(rootViewController: vc)
                present(nav, animated: true)
            }
        }
    }
}
