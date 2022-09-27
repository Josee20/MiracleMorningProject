//
//  ChangeScheduleView.swift
//  MiracleMorningProject
//
//  Created by 이동기 on 2022/09/22.
//

import UIKit

class ChangeScheduleView: BaseView {
    
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
    
    let okButton: UIButton = {
        let view = UIButton()
        view.setTitle("수정", for: .normal)
        view.backgroundColor = .systemGray
        view.layer.cornerRadius = 25
        return view
    }()
    
    override func configureUI() {
        
        setScheduleTextField.delegate = self
        
        [setScheduleTextField, textFieldBorder, okButton, headerView, firstLineView, secondLineView, startTimeLabel, setStartTimeButton, endTimeLabel, setEndTimeButton].forEach { self.addSubview($0) }
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
        
        
        headerView.snp.makeConstraints {
            $0.topMargin.equalTo(textFieldBorder.snp.bottom).offset(28)
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
    }
}

extension ChangeScheduleView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        setScheduleTextField.resignFirstResponder()
        return true
    }
}
