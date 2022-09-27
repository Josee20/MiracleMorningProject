//
//  SetScheduleView.swift
//  MiracleMorningProject
//
//  Created by 이동기 on 2022/09/11.
//

//import Foundation
import UIKit

class SetScheduleView: BaseView {
    
    let setScheduleTextField: UITextField = {
        let view = UITextField()
        view.font = .boldSystemFont(ofSize: 20)
        view.textAlignment = .center
        view.placeholder = "예) 독서"
        view.keyboardType = .default
        view.returnKeyType = .done
        return view
    }()
    
    let textFieldBorder: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.systemGray.cgColor
        return view
    }()
    
    // MARK: - 일월화수목금토
    let sundayButton: DailyButton = {
        let view = DailyButton()
        view.setTitle("일", for: .normal)
        view.setupButton()
        return view
    }()
    
    let mondayButton: DailyButton = {
        let view = DailyButton()
        view.setTitle("월", for: .normal)
        view.setupButton()
        return view
    }()
    
    let tuesdayButton: DailyButton = {
        let view = DailyButton()
        view.setTitle("화", for: .normal)
        view.setupButton()
        return view
    }()
    
    let wedensdayButton: DailyButton = {
        let view = DailyButton()
        view.setTitle("수", for: .normal)
        view.setupButton()
        return view
    }()
    
    let thursdayButton: DailyButton = {
        let view = DailyButton()
        view.setTitle("목", for: .normal)
        view.setupButton()
        return view
    }()
    
    let fridayButton: DailyButton = {
        let view = DailyButton()
        view.setTitle("금", for: .normal)
        view.setupButton()
        return view
    }()
    
    let saturdayButton: DailyButton = {
        let view = DailyButton()
        view.setTitle("토", for: .normal)
        view.setupButton()
        return view
    }()
    
    // MARK: - 스택뷰
    let stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.alignment = .fill
        view.spacing = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        view.distribution = .equalSpacing
        return view
    }()
    
    let headerView: UILabel = {
        let view = UILabel()
        view.text = "알림설정"
        view.font = .boldSystemFont(ofSize: 18)
        view.textColor = .systemGray3
        return view
    }()
    
    let firstLineView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.backgroundColor = .systemGray6
        return view
    }()
    
    let secondLineView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.backgroundColor = .systemGray6
        return view
    }()
    
    let thirdLineView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.backgroundColor = .systemGray6
        return view
    }()
    
    let startTimeLabel: UILabel = {
        let view = UILabel()
        view.text = "시작시간"
        view.textAlignment = .center
        return view
    }()
    
    let setStartTimeButton: UIButton = {
        let view = UIButton()
        view.setTitle("시간선택", for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 15)
        view.setTitleColor(.black, for: .normal)
        return view
    }()
    
    let setEndTimeButton: UIButton = {
        let view = UIButton()
        view.setTitle("시간선택", for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 15)
        view.setTitleColor(.black, for: .normal)
        return view
    }()
    
    let endTimeLabel: UILabel = {
        let view = UILabel()
        view.text = "종료시간"
        view.textAlignment = .center
        return view
    }()
    
    let getAlarmLabel: UILabel = {
        let view = UILabel()
        view.text = "알림받기"
        return view
    }()
    
    let alarmToggle: UISwitch = {
        let view = UISwitch()
        view.isEnabled = true
        return view
    }()
    
    let okButton: UIButton = {
        let view = UIButton()
        view.setTitle("완료", for: .normal)
        view.backgroundColor = .systemGray
        view.layer.cornerRadius = 25
        return view
    }()
    
    override func configureUI() {

        setScheduleTextField.delegate = self
        
        [setScheduleTextField, textFieldBorder, okButton, stackView, headerView, firstLineView, secondLineView, thirdLineView, startTimeLabel, setStartTimeButton, endTimeLabel, setEndTimeButton, getAlarmLabel, alarmToggle].forEach { self.addSubview($0) }
        
        [sundayButton, mondayButton, tuesdayButton, wedensdayButton, thursdayButton, fridayButton, saturdayButton].forEach { self.stackView.addArrangedSubview($0) }
        
    }
    
    override func setConstraints() {
        
        setScheduleTextField.snp.makeConstraints {
            $0.centerX.equalTo(self)
            $0.topMargin.equalTo(28)
            $0.height.equalTo(40)
            $0.trailingMargin.lessThanOrEqualTo(-20)
        }
        
        textFieldBorder.snp.makeConstraints {
            $0.topMargin.equalTo(setScheduleTextField.snp.bottom).offset(12)
            $0.height.equalTo(1)
            $0.leading.equalTo(setScheduleTextField.snp.leading)
            $0.trailing.equalTo(setScheduleTextField.snp.trailing)
        }
        
        okButton.snp.makeConstraints {
            $0.bottom.equalTo(self.safeAreaLayoutGuide).offset(-40)
            $0.leadingMargin.equalTo(20)
            $0.trailingMargin.equalTo(-20)
            $0.height.equalTo(52)
        }
        
        sundayButton.snp.makeConstraints {
            $0.width.height.equalTo(48)
        }
        mondayButton.snp.makeConstraints {
            $0.height.width.equalTo(48)
        }
        tuesdayButton.snp.makeConstraints {
            $0.height.width.equalTo(48)
        }
        wedensdayButton.snp.makeConstraints {
            $0.height.width.equalTo(48)
            $0.center.equalTo(self.stackView)
        }
        thursdayButton.snp.makeConstraints {
            $0.height.width.equalTo(48)
        }
        fridayButton.snp.makeConstraints {
            $0.height.width.equalTo(48)
        }
        saturdayButton.snp.makeConstraints {
            $0.height.width.equalTo(48)
        }
        
        stackView.snp.makeConstraints {
            $0.leadingMargin.equalTo(12)
            $0.trailingMargin.equalTo(-12)
            $0.topMargin.equalTo(textFieldBorder.snp.bottom).offset(48)
            $0.height.equalTo(48)
        }
        
        headerView.snp.makeConstraints {
            $0.topMargin.equalTo(stackView.snp.bottom).offset(28)
            $0.leadingMargin.equalTo(28)
            $0.width.equalTo(100)
            $0.height.equalTo(40)
        }
        
        firstLineView.snp.makeConstraints {
            $0.leadingMargin.equalTo(20)
            $0.trailingMargin.equalTo(-20)
            $0.height.equalTo(52)
            $0.topMargin.equalTo(headerView.snp.bottom).offset(16)
        }
        
        startTimeLabel.snp.makeConstraints {
            $0.leadingMargin.equalTo(firstLineView.snp.leading).offset(12)
            $0.centerY.equalTo(firstLineView)
            $0.width.equalTo(100)
            $0.height.equalTo(40)
        }
        
        setStartTimeButton.snp.makeConstraints {
            $0.centerY.equalTo(firstLineView)
            $0.trailingMargin.equalTo(firstLineView.snp.trailing).offset(-12)
            $0.width.equalTo(100)
            $0.height.equalTo(30)
        }
        
        secondLineView.snp.makeConstraints {
            $0.leadingMargin.equalTo(20)
            $0.trailingMargin.equalTo(-20)
            $0.height.equalTo(52)
            $0.topMargin.equalTo(firstLineView.snp.bottom).offset(16)
        }
        
        endTimeLabel.snp.makeConstraints {
            $0.leadingMargin.equalTo(secondLineView.snp.leading).offset(12)
            $0.centerY.equalTo(secondLineView)
            $0.width.equalTo(100)
            $0.height.equalTo(40)
        }
        
        setEndTimeButton.snp.makeConstraints {
            $0.centerY.equalTo(secondLineView)
            $0.trailingMargin.equalTo(secondLineView.snp.trailing).offset(-12)
            $0.width.equalTo(100)
            $0.height.equalTo(30)
        }
        
        thirdLineView.snp.makeConstraints {
            $0.leadingMargin.equalTo(20)
            $0.trailingMargin.equalTo(-20)
            $0.height.equalTo(52)
            $0.topMargin.equalTo(secondLineView.snp.bottom).offset(16)
        }
        
        getAlarmLabel.snp.makeConstraints {
            $0.leadingMargin.equalTo(thirdLineView.snp.leading).offset(32)
            $0.centerY.equalTo(thirdLineView)
            $0.width.equalTo(100)
            $0.height.equalTo(40)
        }
        
        alarmToggle.snp.makeConstraints {
            $0.centerY.equalTo(thirdLineView)
            $0.centerX.equalTo(setEndTimeButton)
            $0.width.equalTo(50)
            $0.height.equalTo(30)
        }
    }
}

extension SetScheduleView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        setScheduleTextField.resignFirstResponder()
        return true
    }
}
