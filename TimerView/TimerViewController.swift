//
//  TimerViewController.swift
//  MiracleMorningProject
//
//  Created by 이동기 on 2022/09/12.
//

import Foundation
import UIKit
import UserNotifications

import SnapKit

class TimerViewController: BaseViewController {
    
    let notificationCenter = UNUserNotificationCenter.current()
    
    private let cancelButton: UIButton = {
        let view = UIButton()
        view.setTitle("취소", for: .normal)
        view.layer.cornerRadius = 30
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.systemOrange.cgColor
        view.backgroundColor = .systemBackground
        view.setTitleColor(UIColor.systemOrange, for: .normal)
        return view
    }()
    
    private let okButton: UIButton = {
        let view = UIButton()
        view.setTitle("완료", for: .normal)
        view.layer.cornerRadius = 30
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.systemGray4.cgColor
        view.backgroundColor = .systemGray4
        view.isUserInteractionEnabled = false
        return view
    }()
    
    private let stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.alignment = .fill
        view.spacing = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        view.distribution = .fillEqually
        return view
    }()
    
    let timeLabel = UILabel()
    
    var leftTime: Int = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground
        self.addTimerView(on: self.timeLabel)
        
        self.callNotification(time: 1, title: "미션 완료!!!", body: "다음 미션도 완수해주세요~~\n다 마치셨다면 당신은 멋쟁이!!!")
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { success, error in
            print(error)
        }
        
        // MARK: 타임레이블 설정
        self.timeLabel.textAlignment = .center
        self.timeLabel.font = .boldSystemFont(ofSize: 40)
        self.view.addSubview(self.timeLabel)
        self.timeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.timeLabel.heightAnchor.constraint(equalToConstant: 300),
            self.timeLabel.widthAnchor.constraint(equalToConstant: 300),
            self.timeLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.timeLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
        ])
        
        // MARK: 타이머
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (t) in
            
            self.leftTime -= 1
            
            let minute = self.leftTime / 60
            let second = self.leftTime % 60
            
            if self.leftTime > 0 {
                self.timeLabel.text = String(format: "%02d:%02d", minute, second)
            } else {
                self.timeLabel.text = "끝!"
                self.okButton.layer.borderColor = UIColor.systemOrange.cgColor
                self.okButton.backgroundColor = .systemOrange
                self.okButton.isUserInteractionEnabled = true
            }
        })
    }
    
    override func configure() {
        self.view.addSubview(stackView)
        
        [cancelButton, okButton].forEach { stackView.addArrangedSubview($0) }
        
        cancelButton.addTarget(self, action: #selector(cancelButtonClicked), for: .touchUpInside)
        
        okButton.addTarget(self, action: #selector(okButtonClicked), for: .touchUpInside)
    }
    
    @objc func cancelButtonClicked() {
        showAlertMessage(title: "정말 포기하시겠어요?")
    }
    
    @objc func okButtonClicked() {
        dismiss(animated: true)
    }
    
    override func setConstraints() {
        
        stackView.snp.makeConstraints {
            $0.bottomMargin.equalTo(-40)
            $0.leadingMargin.equalTo(40)
            $0.trailingMargin.equalTo(-40)
            $0.height.equalTo(60)
        }
        
        cancelButton.snp.makeConstraints {
            $0.leading.equalTo(stackView.snp.leading)
            $0.trailingMargin.equalTo(okButton.snp.leading).offset(-8)
        }
        
        okButton.snp.makeConstraints {
            $0.height.equalTo(60)
        }
    }
    
    private func addTimerView(on subview: UIView) {
        let timerView = TimerView()
        subview.addSubview(timerView)
        timerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            timerView.leftAnchor.constraint(equalTo: subview.leftAnchor),
            timerView.rightAnchor.constraint(equalTo: subview.rightAnchor),
            timerView.bottomAnchor.constraint(equalTo: subview.bottomAnchor),
            timerView.topAnchor.constraint(equalTo: subview.topAnchor),
        ])
        timerView.start(duration: Double(leftTime))
    }
    
    func callNotification(time: Double, title: String, body: String) {
        notificationCenter.removeAllPendingNotificationRequests()
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .defaultCritical
        content.badge = 2
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: time, repeats: false)
        
        let request = UNNotificationRequest(identifier: "notification", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            guard let error = error else { return }
            print(error)
        }
    }
}

final class RoundLabel: UILabel {

    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.clipsToBounds = true
        self.layer.cornerRadius = self.bounds.height / 2.0
    }
}
