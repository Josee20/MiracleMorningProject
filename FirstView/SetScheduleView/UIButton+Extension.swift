//
//  UIButton+Extension.swift
//  MiracleMorningProject
//
//  Created by 이동기 on 2022/09/13.
//

import Foundation
import UIKit

extension UIButton {
    
    // 버튼 백그라운드 컬러 
    func setBackgroundColor(_ color: UIColor, for state: UIControl.State) {
        UIGraphicsBeginImageContext(CGSize(width: 1.0, height: 1.0))
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        context.setFillColor(color.cgColor)
        context.fill(CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0))
        
        let backgroundImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        self.setBackgroundImage(backgroundImage, for: state)
    }
}
