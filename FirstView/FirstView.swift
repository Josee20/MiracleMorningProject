//
//  FirstView.swift
//  MiracleMorningProject
//
//  Created by 이동기 on 2022/09/11.
//

import Foundation
import UIKit

class FirstView: BaseView {
    
    let presentTimeLabel: UILabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 15)
        view.textColor = .systemGray
        return view
    }()
    
    let todayToDoLabel: UILabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 20)
        view.text = "오늘의 할 일"
        view.textColor = .black
        return view
    }()
    
    let tableView: UITableView = {
        let view = UITableView()
        view.rowHeight = 68
        return view
    }()
    
    let borderWithTabBar: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.systemGray4.cgColor
        return view
    }()
    
    let addScheduleButton: UIButton = {
        let view = UIButton()
        let buttonSizeConfiguration = UIImage.SymbolConfiguration(pointSize: 20, weight: .bold, scale: .large)
        view.setImage(UIImage(systemName: "plus",withConfiguration: buttonSizeConfiguration), for: .normal)
        
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 25
        view.layer.borderColor = UIColor.mainOrange.cgColor
        view.tintColor = .mainOrange
        return view
    }()
    
    override func configureUI() {

        [presentTimeLabel, borderWithTabBar, todayToDoLabel, tableView, addScheduleButton].forEach { self.addSubview($0) }
    }
    
    override func setConstraints() {
        
        presentTimeLabel.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.leadingMargin.equalTo(20)
            $0.height.equalTo(20)
            $0.width.equalTo(200)
        }
        
        todayToDoLabel.snp.makeConstraints {
            $0.topMargin.equalTo(presentTimeLabel.snp.bottom).offset(40)
            $0.leadingMargin.equalTo(20)
            $0.height.equalTo(24)
            $0.width.equalTo(100)
            
        }
        
        borderWithTabBar.snp.makeConstraints {
            $0.width.equalTo(UIScreen.main.bounds.width)
            $0.height.equalTo(1)
            $0.bottom.equalTo(self.safeAreaLayoutGuide).offset(-12)
        }
        
        tableView.snp.makeConstraints {
            $0.topMargin.equalTo(todayToDoLabel.snp.bottom).offset(36)
            $0.leadingMargin.equalTo(24)
            $0.trailingMargin.equalTo(-24)
            $0.bottom.equalTo(addScheduleButton.snp.top).offset(-40)
        }
        
        addScheduleButton.snp.makeConstraints {
            $0.width.height.equalTo(50)
            $0.trailingMargin.equalTo(-20)
            $0.bottom.equalTo(self.safeAreaLayoutGuide).offset(-48)
        }
    }
    
}
