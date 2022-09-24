//
//  BaseFSCalendarCell.swift
//  MiracleMorningProject
//
//  Created by 이동기 on 2022/09/24.
//

import Foundation

import SnapKit
import FSCalendar

class BaseFSCalendarCell: FSCalendarCell {
     
    override init!(frame: CGRect) {
        super.init(frame: frame)
        
        
        configureUI()
        setConstraints()
    }
    
    required init!(coder aDecoder: NSCoder!) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() { }
    func setConstraints() { }
}
