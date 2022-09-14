//
//  SecondCollectionViewCell.swift
//  MiracleMorningProject
//
//  Created by 이동기 on 2022/09/14.
//

import UIKit

class SecondCollectionViewCell: BaseCollectionViewCell {
    
    let scheduleLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .center
        view.font = .systemFont(ofSize: 12)
        return view
    }()
    
    let numberOfScheduleLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .center
        view.font = .systemFont(ofSize: 7)
        return view
    }()
    
    override func configureUI() {
        self.addSubview(scheduleLabel)
        self.addSubview(numberOfScheduleLabel)
    }
    
    override func setConstraints() {
        
        scheduleLabel.snp.makeConstraints {
            $0.height.equalTo(12)
            $0.width.equalTo(self)
            $0.center.equalTo(self)
        }
        
        numberOfScheduleLabel.snp.makeConstraints {
            $0.top.equalTo(self)
            $0.trailing.equalTo(self)
            $0.width.equalTo(10)
            $0.height.equalTo(7)
        }
    }
}
