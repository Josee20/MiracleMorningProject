//
//  SetScheduleTableViewCell.swift
//  MiracleMorningProject
//
//  Created by 이동기 on 2022/09/11.
//

import Foundation
import UIKit

class SetScheduleTableViewCell: BaseTableViewCell {
    
    let startTimeLabel: UILabel = {
        let view = UILabel()
        view.text = "시작시간"
        view.textAlignment = .center
        return view
    }()
    
    let selectTimeButton: UIButton = {
        let view = UIButton()
        view.setTitle("시간선택", for: .normal)
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
        return view
    }()
    
    override func configureUI() {
        [startTimeLabel, alarmToggle, selectTimeButton].forEach { self.addSubview($0) }
    }
    
    override func setConstraints() {
        
        startTimeLabel.snp.makeConstraints {
            $0.leadingMargin.equalTo(20)
            $0.centerY.equalTo(self)
            $0.width.equalTo(100)
            $0.height.equalTo(20)
        }
        
        selectTimeButton.snp.makeConstraints {
            $0.trailingMargin.equalTo(-20)
            $0.centerY.equalTo(self)
            $0.width.equalTo(100)
            $0.height.equalTo(20)
        }
        
        alarmToggle.snp.makeConstraints {
            $0.trailingMargin.equalTo(-12)
            $0.centerY.equalTo(self)
            $0.width.equalTo(80)
            $0.height.equalTo(30)
        }
    }
}
