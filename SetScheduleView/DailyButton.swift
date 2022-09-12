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
        layer.cornerRadius = 20
        backgroundColor = UIColor.systemGray4
        isMultipleTouchEnabled = true
        setBackgroundImage(<#T##image: UIImage?##UIImage?#>, for: <#T##UIControl.State#>)
        
//        backgroundColor = UIColor(red: 85/255, green: 189/255, blue: 249/255, alpha: 1)
//        setTitleColor(UIColor.green, for: .selected)
        
    }
}
