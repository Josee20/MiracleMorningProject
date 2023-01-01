//
//  FirstViewController.swift
//  MiracleMorningProject
//
//  Created by 이동기 on 2022/09/11.
//

import Foundation
import UIKit
import UserNotifications

import RealmSwift
import Toast
import FirebaseAnalytics

class FirstViewController: BaseViewController {

    let mainView = FirstView()
    
    let repository = UserScheduleRepository()
    
    var timer: Timer?
    
    var scheduleInfo = [scheduleInfoModel]()
    
    let notificationCenter = UNUserNotificationCenter.current()
    
    let now = Date()
    
    let calendar = Calendar.current
    
    var dayTasks: Results<UserSchedule>!
    
    let buttonSizeConfiguration = UIImage.SymbolConfiguration.init(pointSize: 20, weight: .semibold, scale: .large)
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.backgroundColor = .systemBackground
        
        requestNotificationAuthorization()
        
        // 해당일 정보 scheduleInfoModel에 값 넣어주기
        for i in 0..<repository.filterDayTasks(date: now).count {
            scheduleInfo.append(scheduleInfoModel(schedule: repository.filterDayTasks(date: now)[i].schedule, startTime: repository.filterDayTasks(date: now)[i].startTime, endTime: repository.filterDayTasks(date: now)[i].endTime, success: repository.filterDayTasks(date: now)[i].scheduleSuccess))
        }
    }
    

    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(getCurrentTime), userInfo: nil, repeats: true)
        
        getCurrentTime()
        
        mainView.tableView.reloadData()
        
        dayTasks = repository.filterDayTasks(date: now).sorted(byKeyPath: "startTime", ascending: true)

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        timer?.invalidate()
    }
    
    override func configure() {
        
        mainView.tableView.register(FirstTableViewCell.self, forCellReuseIdentifier: FirstTableViewCell.reuseIdentifier)
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        
        mainView.addScheduleButton.addTarget(self, action: #selector(addScheduleButtonClicked), for: .touchUpInside)
    }
    
    @objc func addScheduleButtonClicked() {
        let vc = SetScheduleViewController()
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
    
    @objc func getCurrentTime() {
        mainView.presentTimeLabel.text = DateFormatChange.shared.fullDate.string(from: Date())
    }
    
    func requestNotificationAuthorization() {
        notificationCenter.requestAuthorization(options: [.alert, .sound]) { success, error in
            if let error = error {
                print(error)
            }
        }
    }
}


extension FirstViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return scheduleInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FirstTableViewCell.reuseIdentifier) as? FirstTableViewCell else {
            return UITableViewCell()
        }
        
        cell.selectionStyle = .none
        
        if dayTasks[indexPath.row].scheduleSuccess == true {
            cell.scheduleTitle.text = dayTasks[indexPath.row].schedule
            cell.scheduleTime.text = "\(dayTasks[indexPath.row].startTime)~\(dayTasks[indexPath.row].endTime)"

            cell.checkButton.setImage(UIImage(systemName: "checkmark.square",withConfiguration: buttonSizeConfiguration), for: .normal)
            
//            cell.isUserInteractionEnabled = false
            cell.tableBackgroundView.backgroundColor = .successColor
        } else {
            cell.scheduleTitle.text = dayTasks[indexPath.row].schedule
            cell.scheduleTime.text = "\(dayTasks[indexPath.row].startTime)~\(dayTasks[indexPath.row].endTime)"
            cell.checkButton.setImage(UIImage(systemName: "x.square",withConfiguration: buttonSizeConfiguration), for: .normal)
            cell.tableBackgroundView.backgroundColor = .failColor
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
  
        if now > calendar.startOfDay(for: now) + 32400 && now < calendar.startOfDay(for: now) + 86400 {
            showAlertOnlyOk(title: "오전 9시가 넘어 수행이 불가합니다")
        } else if now < calendar.startOfDay(for: now) + 14400 {
            showAlertOnlyOk(title: "오전 4시부터 수행 가능합니다")
        } else if dayTasks[indexPath.row].scheduleSuccess == true {
            showAlertOnlyOk(title: "이미 수행한 스케쥴입니다")
        } else {
            let dateOfStartTime = DateFormatChange.shared.dateOfHourAndPM.date(from: dayTasks[indexPath.row].startTime)!.timeIntervalSince1970
            let dateOfEndTime = DateFormatChange.shared.dateOfHourAndPM.date(from: dayTasks[indexPath.row].endTime)!.timeIntervalSince1970
            
            let vc = TimerViewController()
            let nav = UINavigationController(rootViewController: vc)
            
            vc.missionLabelTitle = dayTasks[indexPath.row].schedule
            vc.leftTime = dateOfEndTime - dateOfStartTime
            vc.fixedLeftTime = dateOfEndTime - dateOfStartTime
            
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: true)
        }
    }
}
