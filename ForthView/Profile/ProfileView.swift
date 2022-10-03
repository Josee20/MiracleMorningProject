//
//  ProfileView.swift
//  MiracleMorningProject
//
//  Created by 이동기 on 2022/10/03.
//

import UIKit

class ProfileView: BaseView {
    
    let nicknameTextFiled: UITextField = {
        let view = UITextField()
        view.placeholder = "닉네임을 설정해주세요"
        return view
    }()
    
    let border: UIView = {
        let view = UIView()
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.black.cgColor
        return view
    }()
    
    override func configureUI() {
        self.addSubview(nicknameTextFiled)
        self.addSubview(border)
    }
    
    override func setConstraints() {
        
        nicknameTextFiled.snp.makeConstraints {
            $0.topMargin.equalTo(40)
            $0.leadingMargin.equalTo(28)
            $0.trailingMargin.equalTo(-28)
            $0.height.equalTo(24)
        }
        
        border.snp.makeConstraints {
            $0.leadingMargin.equalTo(28)
            $0.trailingMargin.equalTo(-28)
            $0.height.equalTo(1)
            $0.topMargin.equalTo(nicknameTextFiled.snp.bottom).offset(12)
        }
        
    }
    
    
}
