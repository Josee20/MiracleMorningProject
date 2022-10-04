//
//  ForthViewController.swift
//  MiracleMorningProject
//
//  Created by 이동기 on 2022/09/11.
//

import Foundation
import UIKit
import UserNotifications

enum EtcCell {
    static let contentsList = ["공지사항", "자주 묻는 질문"]
}

class ForthViewController: BaseViewController {
    
    let mainView = ForthView()
    let notificationCenter = UNUserNotificationCenter.current()
    let calendar = Calendar.current
    var setStartTimeDatePickerDate: Date?
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "설정"
        
        mainView.backgroundColor = .systemBackground
        
        notificationCenter.getPendingNotificationRequests { requests in
            if requests.isEmpty == true {
                DispatchQueue.main.async {
                    self.mainView.alarmToggle.setOn(false, animated: false)
                    self.mainView.setTimeButton.setTitle("시간설정", for: .normal)
                }
                
                print("등록된 노티피케이션이 없습니다.")
     
            } else {
                let storedTime = UserDefaults.standard.string(forKey: "settingTime")
                DispatchQueue.main.async {
                    self.mainView.alarmToggle.setOn(true, animated: false)
                    self.mainView.setTimeButton.setTitle(storedTime, for: .normal)
                }
                
                print("노티피케이션이 있습니다")
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        mainView.profileImageLabel.text = "\(UserDefaults.standard.string(forKey: "nickname") ?? "햇")님의 해바라기"
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = false
    }
    
        
    override func configure() {
        mainView.profileTableView.delegate = self
        mainView.profileTableView.dataSource = self
        mainView.profileTableView.register(ForthProfileTableViewCell.self, forCellReuseIdentifier: ForthProfileTableViewCell.reuseIdentifier)
        
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.register(ForthTableViewCell.self, forCellReuseIdentifier: ForthTableViewCell.reuseIdentifier)
        
        mainView.setTimeButton.addTarget(self, action: #selector(setTimeButtonClicked), for: .touchUpInside)
        mainView.alarmToggle.addTarget(self, action: #selector(alarmToggleClicked), for: .touchUpInside)
        
    }
    
    @objc func alarmToggleClicked() {
        if mainView.alarmToggle.isOn == true {
            guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
            
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        } else {
            
            notificationCenter.removeAllPendingNotificationRequests()
            mainView.setTimeButton.setTitle("시간설정", for: .normal)
        }
    }
    
    @objc func setTimeButtonClicked() {
        if mainView.alarmToggle.isOn == false {
            showAlertOnlyOk(title: "알람 권한을 먼저 허용해주세요")
        } else {
            let datePicker = UIDatePicker()
            
            datePicker.datePickerMode = .time
            datePicker.preferredDatePickerStyle = .wheels
            datePicker.locale = NSLocale.current
            
            let alert = UIAlertController(title: "\n\n\n\n\n\n\n\n\n\n\n", message: nil, preferredStyle: .actionSheet)
            
            alert.view.addSubview(datePicker)
            
            datePicker.snp.makeConstraints {
                $0.centerX.equalTo(alert.view)
                $0.top.equalTo(alert.view).offset(8)
            }
            
            let ok = UIAlertAction(title: "확인", style: .default) { (action) in
                
                let dateString = DateFormatChange.shared.dateOfHourAndPM.string(from: datePicker.date)
                self.setStartTimeDatePickerDate = datePicker.date
                
               if self.calendar.component(.hour, from: datePicker.date) > 3 && self.calendar.component(.hour, from: datePicker.date) < 9 {
                    self.mainView.setTimeButton.setTitle(dateString, for: .normal)
                    self.mainView.setTimeButton.setTitleColor(.systemBlue, for: .normal)
                   
                   print(datePicker.date)
                   
                   let componentsHour = self.calendar.component(.hour, from: datePicker.date)
                   let componentsMinute = self.calendar.component(.minute, from: datePicker.date)
                   
                   self.sendNotification(alarmHour: componentsHour, alarmMinute: componentsMinute)
                   
                   UserDefaults.standard.set(dateString, forKey: "settingTime")
                   
                } else {
                    self.showAlertOnlyOk(title: "오전 4시부터 오전9시까지만 시간설정이 가능합니다")
                }
            }
            
            let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            
            alert.addAction(ok)
            alert.addAction(cancel)
            
            present(alert, animated: true, completion: nil)
        }
    }
    
    func sendNotification(alarmHour: Int, alarmMinute: Int) {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            if settings.authorizationStatus == UNAuthorizationStatus.authorized {

                let notiContent = UNMutableNotificationContent()
                notiContent.title = "시간이 됐어요!"
                notiContent.subtitle = "일어나 스케쥴을 수행해주세요~~"
                notiContent.sound = .defaultCritical

                var date = DateComponents()
                date.hour = alarmHour
                date.minute = alarmMinute

                let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
                let request = UNNotificationRequest(identifier: "wakeup", content: notiContent, trigger: trigger)

                UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)

            } else {
                print("User not agree")
            }
        }
    }
    
    func getPendingNotificationRequests(completionHandler: ([UNNotificationRequest]) -> Void) { }
    
    
    @objc func toggleSwitchClicked() {
        print("toggleSwitchClick")
    }
}

extension ForthViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == mainView.profileTableView {
            return 2
        } else {
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == mainView.profileTableView {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ForthProfileTableViewCell.reuseIdentifier, for: indexPath) as? ForthProfileTableViewCell else { return UITableViewCell() }
            
            if indexPath.row == 1 {
                cell.cellTitle.text = "백업 및 복구"
            }
            
            cell.selectionStyle = .none
            
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ForthTableViewCell.reuseIdentifier, for: indexPath) as? ForthTableViewCell else { return UITableViewCell() }
            
            cell.cellTitle.text = EtcCell.contentsList[indexPath.row]
            
            cell.selectionStyle = .none
            
            return cell
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView == mainView.profileTableView {
            if indexPath.row == 0 {
                let vc = ProfileViewController()
                navigationController?.pushViewController(vc, animated: true)
            } else {
                showAlertOnlyOk(title: "준비중입니다")
            }
        } else {
            if indexPath.row == 0 {
                let vc = NoticeViewController()
                navigationController?.pushViewController(vc, animated: true)
            } else {
                let vc = QnAViewController()
                navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}

