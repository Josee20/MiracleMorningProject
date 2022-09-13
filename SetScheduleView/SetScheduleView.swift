//
//  SetScheduleView.swift
//  MiracleMorningProject
//
//  Created by 이동기 on 2022/09/11.
//

import Foundation
import UIKit

class SetScheduleView: BaseView {
    
    let setScheduleTextField: UITextField = {
        let view = UITextField()
        view.font = .boldSystemFont(ofSize: 20)
        view.textAlignment = .center
        view.placeholder = "예) 독서"
        return view
    }()
    
    let textFieldBorder: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.systemGray.cgColor
        return view
    }()
    
    // MARK: 일 ~ 토
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
    
    // MARK: 스택뷰
    let stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.alignment = .fill
        view.spacing = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        view.distribution = .equalSpacing
        return view
    }()
    
    
    
    let okButton: UIButton = {
        let view = UIButton()
        view.setTitle("완료", for: .normal)
        view.backgroundColor = .systemGray
        return view
    }()
    
    override func configureUI() {
        

        [setScheduleTextField, textFieldBorder, okButton, stackView].forEach { self.addSubview($0) }
        
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
            $0.leadingMargin.equalTo(60)
            $0.trailingMargin.equalTo(-60)
            $0.height.equalTo(52)
        }
        
        sundayButton.snp.makeConstraints {
            $0.width.equalTo(40)
        }
        mondayButton.snp.makeConstraints {
            $0.height.width.equalTo(40)
        }
        tuesdayButton.snp.makeConstraints {
            $0.height.width.equalTo(40)
            
        }
        wedensdayButton.snp.makeConstraints {
            $0.height.width.equalTo(40)
            $0.center.equalTo(self.stackView)
        }
        thursdayButton.snp.makeConstraints {
            $0.height.width.equalTo(40)
        }
        fridayButton.snp.makeConstraints {
            $0.height.width.equalTo(40)
        }
        saturdayButton.snp.makeConstraints {
            $0.height.width.equalTo(40)
        }
        
        stackView.snp.makeConstraints {
            $0.leadingMargin.equalTo(20)
            $0.trailingMargin.equalTo(-20)
            $0.topMargin.equalTo(textFieldBorder.snp.bottom).offset(40)
            $0.height.equalTo(40)
        }   
    }
}
