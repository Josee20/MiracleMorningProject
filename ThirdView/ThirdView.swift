//
//  ThirdView.swift
//  MiracleMorningProject
//
//  Created by 이동기 on 2022/09/11.
//

import Foundation
import UIKit

class ThirdView: BaseView {
    
    let borderWithTabBar: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.systemGray3.cgColor
        return view
    }()
    
    override func configureUI() {
        self.addSubview(borderWithTabBar)
    }
    
    override func setConstraints() {
        
        borderWithTabBar.snp.makeConstraints {
            $0.width.equalTo(UIScreen.main.bounds.width)
            $0.height.equalTo(1)
            $0.bottom.equalTo(self.safeAreaLayoutGuide).offset(-12)
        }
    }
    
}
