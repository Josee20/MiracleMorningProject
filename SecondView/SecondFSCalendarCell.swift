//
//  SecondFSCalendarCell.swift
//  MiracleMorningProject
//
//  Created by 이동기 on 2022/09/24.
//

import Foundation
import UIKit

class SecondFSCalendarCell: BaseFSCalendarCell {
    
    private let background: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    override func configureUI() {
        self.addSubview(background)
    }
    
    override func setConstraints() {
        
        background.snp.makeConstraints {
            $0.leadingMargin.topMargin.trailingMargin.bottomMargin.equalTo(0)
        }
    }
}
