//
//  DailyButton.swift
//  MiracleMorningProject
//
//  Created by 이동기 on 2022/09/12.
//

import Foundation
import UIKit

class DailyButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
    func setupButton() {
        isSelected = true
        setTitleColor(UIColor.white, for: .normal)
        clipsToBounds = true
        layer.cornerRadius = 22
        backgroundColor = UIColor.lightGray
        titleLabel?.font = .boldSystemFont(ofSize: 14)
    }
}
