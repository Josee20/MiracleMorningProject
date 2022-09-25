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
        
        cell.scheduleTitle.text = dayTasks[indexPath.row].schedule
        cell.scheduleTime.text = "\(dayTasks[indexPath.row].startTime)~\(dayTasks[indexPath.row].endTime)"
        dayTasks[indexPath.row].scheduleSuccess == true ? cell.checkButton.setImage(UIImage(systemName: "checkmark.square") , for: .normal) : cell.checkButton.setImage(UIImage(systemName: "x.square"), for: .normal)

        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            repository.delete(item: dayTasks?[indexPath.row])
        }
        
        let components = calendar.dateComponents([.year, .month], from: date)
        let startOfMonth = calendar.date(from: components)!
        
        for i in 0..<repository.successSchedule(currentDate: startOfMonth).count {
            scheduleCountDic.updateValue(repository.successScheduleNumber(key: repository.successSchedule(currentDate: startOfMonth)[i].schedule).count, forKey: repository.successSchedule(currentDate: startOfMonth)[i].schedule)
        }
        
        mainView.collectionView.reloadData()
        mainView.calendar.reloadData()
        self.fetchRealm()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
        let vc = ChangeScheduleViewController()
        
        vc.setScheduleTextFieldTitle = dayTasks[indexPath.row].schedule
        vc.startTimeButtonTitle = dayTasks[indexPath.row].startTime
        vc.endTimeButtonTitle = dayTasks[indexPath.row].endTime
        vc.objectID = dayTasks[indexPath.row].objectID
        vc.receivedDate = dayTasks[indexPath.row].scheduleDate
        
        // 2. 클로저 함수 정의
        vc.okButtonActionHandler = {
            self.mainView.tableView.reloadData()
        }
        
        self.mainView.collectionView.reloadData()
        
        let nav = UINavigationController(rootViewController: vc)
        present(nav, animated: true)
    }
}
