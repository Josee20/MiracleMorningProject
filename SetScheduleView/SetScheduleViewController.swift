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
        
        // MARK: 버튼마다 dayButtonClicked 함수 넣어주기
        let dayButtonArr = [mainView.sundayButton, mainView.mondayButton, mainView.tuesdayButton, mainView.wedensdayButton, mainView.thursdayButton, mainView.fridayButton, mainView.saturdayButton]
        
        for i in 0..<dayButtonArr.count {
            dayButtonArr[i].addTarget(self, action: #selector(dayButtonClicked), for: .touchUpInside)
        }
    }
    
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
    
    // MARK: 클릭하면 백그라운드 색 변경
    @objc func dayButtonClicked(sender: UIButton) {
        let dayButtonArr = [mainView.sundayButton, mainView.mondayButton, mainView.tuesdayButton, mainView.wedensdayButton, mainView.thursdayButton, mainView.fridayButton, mainView.saturdayButton]
        
        if dayButtonArr[sender.tag].backgroundColor == UIColor.lightGray {
            dayButtonArr[sender.tag].backgroundColor = .orange
        } else if dayButtonArr[sender.tag].backgroundColor == UIColor.orange {
            dayButtonArr[sender.tag].backgroundColor = .lightGray
        }
    }
    
    func addCancelButton() {
        let cancelButton = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(cancelButtonClicked))
        
        cancelButton.tintColor = .black
        
        let space = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: self, action: nil)
        
        self.navigationItem.setRightBarButtonItems([space, cancelButton], animated: false)
    }
    
    @objc func cancelButtonClicked() {
        self.dismiss(animated: true)
    }
    
}
