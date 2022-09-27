//
//  SecondCollectionViewCell.swift
//  MiracleMorningProject
//
//  Created by 이동기 on 2022/09/14.
//

import UIKit

class SecondCollectionViewCell: BaseCollectionViewCell {
    
    public var scheduleLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .center
        view.text = "운동"
        view.font = .systemFont(ofSize: 12)
        view.numberOfLines = 3
        return view
    }()
    
    public var numberOfScheduleLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .center
        view.text = "10"
        view.font = .systemFont(ofSize: 10)
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
            $0.top.equalTo(self).inset(5)
            $0.trailing.equalTo(self).inset(4)
            $0.width.equalTo(15)
            $0.height.equalTo(8)
        }
    }
}
