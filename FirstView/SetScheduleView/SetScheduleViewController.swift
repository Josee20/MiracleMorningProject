//
//  SetScheduleViewController.swift
//  MiracleMorningProject
//
//  Created by 이동기 on 2022/09/11.
//

import UIKit
import Toast

class SetScheduleViewController: BaseViewController {
    
    let mainView = SetScheduleView()
    
    let repository = UserScheduleRepository()
    
    var now = Date() + 86400
    
    let calendar = Calendar.current

    let weekDayArr = ["일", "월", "화", "수", "목", "금", "토"]
    
    var setStartTimeDatePickerDate: Date?
    var setEndTimeDatePickerDate: Date?
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.backgroundColor = .systemBackground
        
        // 버튼에 tag 부여
        let dayButtonArr = [mainView.sundayButton, mainView.mondayButton, mainView.tuesdayButton, mainView.wedensdayButton, mainView.thursdayButton, mainView.fridayButton, mainView.saturdayButton]
        
        for i in 0...6 {
            dayButtonArr[i].tag = i
        }
        
        // X 버튼 추가 메소드
        addCancelButton()
    }

    override func configure() {
        
        mainView.setStartTimeButton.addTarget(self, action: #selector(setStartTimeButtonClicked), for: .touchUpInside)
        mainView.setEndTimeButton.addTarget(self, action: #selector(setEndTimeButtonClicked), for: .touchUpInside)
        mainView.okButton.addTarget(self, action: #selector(okButtonClicked), for: .touchUpInside)
        
        // MARK: 버튼마다 dayButtonClicked 함수 넣어주기
        let dayButtonArr = [mainView.sundayButton, mainView.mondayButton, mainView.tuesdayButton, mainView.wedensdayButton, mainView.thursdayButton, mainView.fridayButton, mainView.saturdayButton]
        
        dayButtonArr.forEach {
            $0.addTarget(self, action: #selector(dayButtonClicked), for: .touchUpInside)
        }
//        for i in 0..<dayButtonArr.count {
//            dayButtonArr[i].addTarget(self, action: #selector(dayButtonClicked), for: .touchUpInside)
//        }
    }
    
    // X버튼
    func addCancelButton() {
        let cancelButton = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(cancelButtonClicked))
        
        cancelButton.tintColor = .black
        
        let space = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: self, action: nil)
        
        self.navigationItem.setRightBarButtonItems([space, cancelButton], animated: false)
    }
    
    @objc func cancelButtonClicked() {
        self.dismiss(animated: true)
    }
    
    // 요일 버튼 클릭
    @objc func dayButtonClicked(sender: UIButton) {
        let dayButtonArr = [mainView.sundayButton, mainView.mondayButton, mainView.tuesdayButton, mainView.wedensdayButton, mainView.thursdayButton, mainView.fridayButton, mainView.saturdayButton]
        
        if dayButtonArr[sender.tag].backgroundColor == UIColor.lightGray {
            dayButtonArr[sender.tag].backgroundColor = .mainGreen
        } else if dayButtonArr[sender.tag].backgroundColor == UIColor.mainGreen {
            dayButtonArr[sender.tag].backgroundColor = .lightGray
        }
    }
    
    // 시작시간 선택버튼 클릭
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
            
            if self.mainView.setStartTimeButton.titleLabel?.text == "시간선택" {
                self.showAlertOnlyOk(title: "시작시간을 먼저 선택해주세요")
            } else if self.mainView.setStartTimeButton.titleLabel?.text == dateString {
                self.showAlertOnlyOk(title: "시작시간과 종료시간은\n같을 수 없습니다\n다른 시간을 선택해주세요")
            } else if self.setStartTimeDatePickerDate! > self.setEndTimeDatePickerDate! {
                self.showAlertOnlyOk(title: "시작시간은 종료시간보다 빨라야합니다\n종료시간을 다시 선택해주세요")
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

        let currentMonth = self.calendar.component(.month, from: now)
        
        if mainView.setScheduleTextField.text?.count == 0 {
            mainView.makeToast("미션을 입력해주세요 :)")
        } else if mainView.sundayButton.backgroundColor == UIColor.lightGray &&
                    mainView.mondayButton.backgroundColor == UIColor.lightGray &&
                    mainView.tuesdayButton.backgroundColor == UIColor.lightGray &&
                    mainView.wedensdayButton.backgroundColor == UIColor.lightGray &&
                    mainView.thursdayButton.backgroundColor == UIColor.lightGray &&
                    mainView.fridayButton.backgroundColor == UIColor.lightGray &&
                    mainView.saturdayButton.backgroundColor == UIColor.lightGray {
            mainView.makeToast("요일을 하나 이상 선택해주세요 :)")
            
        } else if mainView.setStartTimeButton.titleLabel?.text == "시간선택" || mainView.setEndTimeButton.titleLabel?.text == "시간선택" {
            mainView.makeToast("시간을 둘 다 선택해주세요 :)")
        } else if self.setStartTimeDatePickerDate! > self.setEndTimeDatePickerDate! {
            mainView.makeToast("시작시간은 종료시간보다 빨라야합니다\n종료시간을 다시 선택해주세요")
        } else {
            while true {
                let month = calendar.component(.month, from: now)
                let day = calendar.component(.weekday, from: now) - 1
                
                if currentMonth < month || (currentMonth == 12 && month == 1) {
                    break
                } else if weekDayArr[day] == mainView.sundayButton.titleLabel?.text && mainView.sundayButton.backgroundColor == .lightGray ||
                    weekDayArr[day] == mainView.mondayButton.titleLabel?.text && mainView.mondayButton.backgroundColor == .lightGray ||
                    weekDayArr[day] == mainView.tuesdayButton.titleLabel?.text && mainView.tuesdayButton.backgroundColor == .lightGray ||
                    weekDayArr[day] == mainView.wedensdayButton.titleLabel?.text && mainView.wedensdayButton.backgroundColor == .lightGray ||
                    weekDayArr[day] == mainView.thursdayButton.titleLabel?.text && mainView.thursdayButton.backgroundColor == .lightGray ||
                    weekDayArr[day] == mainView.fridayButton.titleLabel?.text && mainView.fridayButton.backgroundColor == .lightGray ||
                    weekDayArr[day] == mainView.saturdayButton.titleLabel?.text && mainView.saturdayButton.backgroundColor == .lightGray {
                    now += 86400
                    continue
                } else {
                    repository.addSchedule(startTime: mainView.setStartTimeButton.titleLabel?.text ?? "",
                                           endTime: mainView.setEndTimeButton.titleLabel?.text ?? "",
                                           date: calendar.startOfDay(for: now),
                                           schedule: mainView.setScheduleTextField.text!,
                                           success: false)
                    now += 86400
                }
            }
            
            dismiss(animated: true)
        }
    }
}
