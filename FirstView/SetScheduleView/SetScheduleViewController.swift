//
//  SetScheduleViewController.swift
//  MiracleMorningProject
//
//  Created by 이동기 on 2022/09/11.
//

import Foundation
import UIKit

class SetScheduleViewController: BaseViewController {
    
    let mainView = SetScheduleView()
    
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
        
        addCancelButton()
    }
    
    
    override func configure() {
        
        mainView.setStartTimeButton.addTarget(self, action: #selector(setStartTimeButtonClicked), for: .touchUpInside)
        mainView.setEndTimeButton.addTarget(self, action: #selector(setEndTimeButtonClicked), for: .touchUpInside)
        mainView.okButton.addTarget(self, action: #selector(okButtonClicked), for: .touchUpInside)
        
        // MARK: 버튼마다 dayButtonClicked 함수 넣어주기
        let dayButtonArr = [mainView.sundayButton, mainView.mondayButton, mainView.tuesdayButton, mainView.wedensdayButton, mainView.thursdayButton, mainView.fridayButton, mainView.saturdayButton]
        
        for i in 0..<dayButtonArr.count {
            dayButtonArr[i].addTarget(self, action: #selector(dayButtonClicked), for: .touchUpInside)
        }
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
            dayButtonArr[sender.tag].backgroundColor = .orange
        } else if dayButtonArr[sender.tag].backgroundColor == UIColor.orange {
            dayButtonArr[sender.tag].backgroundColor = .lightGray
        }
    }
    
    // 시작시간 선택버튼 클릭
    @objc func setStartTimeButtonClicked(sender: UIDatePicker) {
        
        let datePicker = UIDatePicker()
        
        datePicker.datePickerMode = .time
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.locale = NSLocale(localeIdentifier: "ko-KR") as Locale
        
        let alert = UIAlertController(title: "\n\n\n\n\n\n\n\n\n\n\n", message: nil, preferredStyle: .actionSheet)
        
        alert.view.addSubview(datePicker)
        
        datePicker.snp.makeConstraints {
            $0.centerX.equalTo(alert.view)
            $0.top.equalTo(alert.view).offset(8)
        }
        
        let ok = UIAlertAction(title: "확인", style: .default) { (action) in
            let dateString = DateFormatChange.shared.dateOfHourAndPM.string(from: datePicker.date)
            self.mainView.setStartTimeButton.setTitle(dateString, for: .normal)
            self.mainView.setStartTimeButton.setTitleColor(.systemBlue, for: .normal)
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
        datePicker.locale = NSLocale(localeIdentifier: "ko-KR") as Locale
        
        let alert = UIAlertController(title: "\n\n\n\n\n\n\n\n\n\n\n", message: nil, preferredStyle: .actionSheet)
        
        alert.view.addSubview(datePicker)
        
        datePicker.snp.makeConstraints {
            $0.centerX.equalTo(alert.view)
            $0.top.equalTo(alert.view).offset(8)
        }
        
        let ok = UIAlertAction(title: "확인", style: .default) { (action) in
            let dateString = DateFormatChange.shared.dateOfHourAndPM.string(from: datePicker.date)
            self.mainView.setEndTimeButton.setTitle(dateString, for: .normal)
            self.mainView.setEndTimeButton.setTitleColor(.systemBlue, for: .normal)
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alert.addAction(ok)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
    
    @objc func okButtonClicked() {
        
//        let dayButtonArr = [mainView.sundayButton, mainView.mondayButton, mainView.tuesdayButton, mainView.wedensdayButton, mainView.thursdayButton, mainView.fridayButton, mainView.saturdayButton]
        
        if mainView.setScheduleTextField.text?.count == 0 {
            showAlertOnlyOk(title: "미션을 입력해주세요")
        } else if mainView.sundayButton.backgroundColor == UIColor.lightGray &&
                    mainView.mondayButton.backgroundColor == UIColor.lightGray &&
                    mainView.tuesdayButton.backgroundColor == UIColor.lightGray &&
                    mainView.wedensdayButton.backgroundColor == UIColor.lightGray &&
                    mainView.thursdayButton.backgroundColor == UIColor.lightGray &&
                    mainView.fridayButton.backgroundColor == UIColor.lightGray &&
                    mainView.saturdayButton.backgroundColor == UIColor.lightGray {
    
            showAlertOnlyOk(title: "요일을 하나 이상 선택해주세요")
        } else if mainView.setStartTimeButton.titleLabel?.text == "시간선택" || mainView.setEndTimeButton.titleLabel?.text == "시간선택" {
            showAlertOnlyOk(title: "시간을 둘 다 선택해주세요")
        } else {
            dismiss(animated: true)
        }
    }
}