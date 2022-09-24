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
    
    var timer: Timer?
    var progress: Double = 0.0
    
    let timerView = TimerView()
    
    var missionLabelTitle = ""
    var leftTime: Double = 0.0
    var fixedLeftTime: Double = 0.0
    
    private let missionLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .center
        view.text = "운동"
        view.font = .boldSystemFont(ofSize: 30)
        return view
    }()
    
    private let pauseAndPlayButton: UIButton = {
        let view = UIButton()
        view.setTitle("중단", for: .normal)
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
    
    private let timeLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .center
        view.font = .boldSystemFont(ofSize: 40)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground
        
        self.addTimerView(on: self.timeLabel)
        
        self.missionLabel.text = missionLabelTitle
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        timer?.invalidate()
    }
    
    override func configure() {
        
        
        self.view.addSubview(stackView)
        self.view.addSubview(missionLabel)
        self.view.addSubview(timeLabel)
        
        [pauseAndPlayButton, okButton].forEach { stackView.addArrangedSubview($0) }
        
        pauseAndPlayButton.addTarget(self, action: #selector(pauseAndPlayButtonClicked), for: .touchUpInside)
        okButton.addTarget(self, action: #selector(okButtonClicked), for: .touchUpInside)
        
        // MARK: 타이머
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { (t) in
            
            self.leftTime -= 0.01
            
            print(self.leftTime)
            
            let hour = Int(self.leftTime) / 3600
            let minute = Int(self.leftTime) % 3600 / 60
            let second = Int(self.leftTime) % 3600 % 60
            
            
            if self.leftTime > 0 {
                if hour >= 1 {
                    self.timeLabel.text = String(format: "%02d:%02d:%02d", hour, minute, second)
                } else {
                    self.timeLabel.text = String(format: "%02d:%02d", minute, second)
                }
                
                // 9/10 ... 8/10 ... 7/10 ... 1/10... 0
                self.progress = Double(self.leftTime) / Double(self.fixedLeftTime)
                
                // 1(회색) 에서 self.progress
                self.timerView.start(duration: 0.0001 , value: 1.0 - self.progress)
            } else {
                // 완료시 노티주기
                self.callNotification(time: 1, title: "미션 완료!!!", body: "다음 미션도 완수해주세요~~\n다 마치셨다면 당신은 멋쟁이!!!")
                
                self.timeLabel.text = "끝!"
                self.okButton.layer.borderColor = UIColor.systemOrange.cgColor
                self.okButton.backgroundColor = .systemOrange
                self.okButton.isUserInteractionEnabled = true
                self.pauseAndPlayButton.isUserInteractionEnabled = false
                self.timer?.invalidate()
            }
        })
        
        addCancelButton()
    }
    
    @objc func cancelButtonClicked() {
        showAlertMessage(title: "정말 포기하시겠어요?")
    }
    
    @objc func okButtonClicked() {
        dismiss(animated: true)
    }
    
    @objc func pauseAndPlayButtonClicked() {
        
        if pauseAndPlayButton.titleLabel?.text == "중단" {
            pauseAndPlayButton.setTitle("시작", for: .normal)
            timer?.invalidate()

        } else {
            pauseAndPlayButton.setTitle("중단", for: .normal)

            timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { (t) in
                
                self.leftTime -= 0.01
                
                let minute = Int(self.leftTime) / 60
                let second = Int(self.leftTime) % 60
                
                if self.leftTime > 0 {
                    self.timeLabel.text = String(format: "%02d:%02d", minute, second)
                    self.progress = Double(self.leftTime) / Double(self.fixedLeftTime)
                    self.timerView.start(duration: 0.0001 , value: 1.0 - self.progress)

                } else {
                    // 완료시 노티주기
                    self.callNotification(time: 1, title: "미션 완료!!!", body: "다음 미션도 완수해주세요~~\n다 마치셨다면 당신은 멋쟁이!!!")
                    self.timeLabel.text = "끝!"
                    self.okButton.layer.borderColor = UIColor.systemOrange.cgColor
                    self.okButton.backgroundColor = .systemOrange
                    self.okButton.isUserInteractionEnabled = true
                    self.pauseAndPlayButton.isUserInteractionEnabled = false
                    self.timer?.invalidate()
                }
            })
        }
    }
    
    private func addCancelButton() {
        let cancelButton = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(cancelButtonClicked))
        
        cancelButton.tintColor = .black
        
        let space = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: self, action: nil)
        
        self.navigationItem.setRightBarButtonItems([space, cancelButton], animated: false)
    }
    
    private func addTimerView(on subview: UIView) {
        subview.addSubview(timerView)
        timerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            timerView.leftAnchor.constraint(equalTo: subview.leftAnchor),
            timerView.rightAnchor.constraint(equalTo: subview.rightAnchor),
            timerView.bottomAnchor.constraint(equalTo: subview.bottomAnchor),
            timerView.topAnchor.constraint(equalTo: subview.topAnchor),
        ])
    }
    
    private func callNotification(time: Double, title: String, body: String) {
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
    
    override func setConstraints() {
        
        missionLabel.snp.makeConstraints {
            $0.topMargin.equalTo(60)
            $0.leadingMargin.equalTo(40)
            $0.trailingMargin.equalTo(-40)
        }
        
        timeLabel.snp.makeConstraints {
            $0.center.equalTo(self.view)
            $0.width.equalTo(300)
            $0.height.equalTo(300)
        }

        stackView.snp.makeConstraints {
            $0.bottomMargin.equalTo(-40)
            $0.leadingMargin.equalTo(40)
            $0.trailingMargin.equalTo(-40)
            $0.height.equalTo(60)
        }
        
        pauseAndPlayButton.snp.makeConstraints {
            $0.leading.equalTo(stackView.snp.leading)
            $0.trailingMargin.equalTo(okButton.snp.leading).offset(-8)
        }
        
        okButton.snp.makeConstraints {
            $0.height.equalTo(60)
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
