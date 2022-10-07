//
//  ChangeScheduleViewController.swift
//  MiracleMorningProject
//
//  Created by 이동기 on 2022/09/22.
//

import Foundation
import UIKit

import RealmSwift

enum setTimeButtonColor {
    static let notChangedColor = UIColor.black
    static let changedColor = UIColor.systemBlue
}

final class ChangeScheduleViewController: BaseViewController {
    
    let repository = UserScheduleRepository()
    
    let mainView = ChangeScheduleView()
    
    let calendar = Calendar.current
    
    var objectID: ObjectId?
        
    // 1. 실행될 빈 클로저 선언
    var okButtonActionHandler: ( () -> Void )?
    
    var setStartTimeDatePickerDate: Date?
    var setEndTimeDatePickerDate: Date?
    var indexPath = 0

    var setScheduleTextFieldTitle = ""
    var startTimeButtonTitle = ""
    var endTimeButtonTitle = ""
    
    var dayTasks: Results<UserSchedule>!
    var receivedDate = Date()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mainView.backgroundColor = .systemBackground
        
        dayTasks = repository.filterDayTasks(date: receivedDate)
    }
    
    override func configure() {
        mainView.setStartTimeButton.addTarget(self, action: #selector(setStartTimeButtonClicked), for: .touchUpInside)
        mainView.setEndTimeButton.addTarget(self, action: #selector(setEndTimeButtonClicked), for: .touchUpInside)
        mainView.okButton.addTarget(self, action: #selector(okButtonClicked), for: .touchUpInside)
        
        mainView.setScheduleTextField.text = setScheduleTextFieldTitle
        mainView.setStartTimeButton.setTitle(startTimeButtonTitle, for: .normal)
        mainView.setEndTimeButton.setTitle(endTimeButtonTitle, for: .normal)
    }
    
    @objc func setStartTimeButtonClicked(sender: UIDatePicker) {
        
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
                self.mainView.setStartTimeButton.setTitle(dateString, for: .normal)
                self.mainView.setStartTimeButton.setTitleColor(.systemBlue, for: .normal)
            } else {
                self.showAlertOnlyOk(title: "오전 4시부터 오전9시까지만 시간설정이 가능합니다")
            }
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alert.addAction(ok)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
    
    // 종료시간 선택버튼 클릭
    @objc func setEndTimeButtonClicked() {
        
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
            self.setEndTimeDatePickerDate = datePicker.date
            
            if self.mainView.setStartTimeButton.titleLabel?.text == self.mainView.setEndTimeButton.titleLabel?.text {
                self.showAlertOnlyOk(title: "시작시간과 종료시간은\n같을 수 없습니다\n다른 시간을 선택해주세요")
            } else {
                if self.calendar.component(.hour, from: datePicker.date) > 3 && self.calendar.component(.hour, from: datePicker.date) < 9 {
                    self.mainView.setEndTimeButton.setTitle(dateString, for: .normal)
                    self.mainView.setEndTimeButton.setTitleColor(.systemBlue, for: .normal)
                } else {
                    self.showAlertOnlyOk(title: "오전 4시부터 오전9시까지만 시간설정이 가능합니다")
                }
            }
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alert.addAction(ok)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
    
    @objc func okButtonClicked() {
        
        guard let setStartTimeButtonDate = DateFormatChange.shared.dateOfHourAndPM.date(from: mainView.setStartTimeButton.titleLabel?.text ?? "") else { return }
        
        guard let setEndTimeButtonDate = DateFormatChange.shared.dateOfHourAndPM.date(from: mainView.setEndTimeButton.titleLabel?.text ?? "") else { return }
        
        if mainView.setScheduleTextField.text?.count == 0 {
            showAlertOnlyOk(title: "미션을 입력해주세요")
        } else if mainView.setStartTimeButton.titleLabel?.text == mainView.setEndTimeButton.titleLabel?.text {
            showAlertOnlyOk(title: "시작시간과 종료시간은\n같을 수 없습니다\n다른 시간을 선택해주세요")
        } else if setStartTimeButtonDate > setEndTimeButtonDate {
            self.showAlertOnlyOk(title: "시작시간은 종료시간보다 빨라야합니다\n종료시간을 다시 선택해주세요")
        } else {
            
            // 렘 수정
            repository.updateSchedule(objectID: objectID!, startTime: self.mainView.setStartTimeButton.titleLabel?.text ?? "", endTime: self.mainView.setEndTimeButton.titleLabel?.text ?? "", schedule: self.mainView.setScheduleTextField.text!)

            // 3. 클로저실행
            okButtonActionHandler?()

            dismiss(animated: true)
        }
    }
}
