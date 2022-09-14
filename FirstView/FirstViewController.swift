//
//  FirstViewController.swift
//  MiracleMorningProject
//
//  Created by 이동기 on 2022/09/11.
//

import Foundation
import UIKit
import UserNotifications

class FirstViewController: BaseViewController {
    
    let mainView = FirstView()
    
    var timer: Timer?
    
    let notificationCenter = UNUserNotificationCenter.current()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.backgroundColor = .systemBackground
        
        requestNotificationAuthorization()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getCurrentTime()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        timer?.invalidate()
    }
    
    override func configure() {
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(getCurrentTime), userInfo: nil, repeats: true)
        
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
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FirstTableViewCell.reuseIdentifier) as? FirstTableViewCell else {
            return UITableViewCell()
        }
        
        cell.backgroundColor = .orange
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let headerView = UIView()
        headerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 40)

        let titleLabel = UILabel()
        titleLabel.text = "할 일"
        titleLabel.textColor = .black
        titleLabel.font = .boldSystemFont(ofSize: 20)
        titleLabel.frame = CGRect(x: 0, y: 0, width: headerView.frame.width, height: headerView.frame.height)
        headerView.addSubview(titleLabel)

        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = TimerViewController()
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
}
