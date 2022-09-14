//
//  SecondTableViewCell.swift
//  MiracleMorningProject
//
//  Created by 이동기 on 2022/09/14.
//

import UIKit

class SecondTableViewCell: BaseTableViewCell {

    let scheduleTitle: UILabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 15)
        view.text = "운동하기"
        return view
    }()
    
    let scheduleTime: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 12)
        view.text = "10:00 ~ 12:00"
        return view
    }()
    
    let checkButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = .systemGray6
        return view
    }()
    
    override func configureUI() {
        [scheduleTitle, scheduleTime, checkButton].forEach { self.addSubview($0) }
    }
    
    override func setConstraints() {
        
        scheduleTitle.snp.makeConstraints {
            $0.centerY.equalTo(self)
            $0.leadingMargin.equalTo(32)
            $0.width.equalTo(100)
        }
        
        scheduleTime.snp.makeConstraints {
            $0.centerX.equalTo(UIScreen.main.bounds.width * 0.54)
            $0.centerY.equalTo(self)
            $0.width.equalTo(100)
        }
        
        checkButton.snp.makeConstraints {
            $0.width.height.equalTo(30)
            $0.trailingMargin.equalTo(-20)
            $0.centerY.equalTo(self)
        }
    }
    
}