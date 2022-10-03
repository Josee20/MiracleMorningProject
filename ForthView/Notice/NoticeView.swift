//
//  NoticeView.swift
//  MiracleMorningProject
//
//  Created by 이동기 on 2022/10/03.
//

import UIKit

class NoticeView: BaseView {
    
    let noticeTextView: UITextView = {
        let view = UITextView()
        view.text = "버전 1.0.0"
        view.textColor = .black
        return view
    }()
    
    override func configureUI() {
        self.addSubview(noticeTextView)
    }
    
    override func setConstraints() {
        
        noticeTextView.snp.makeConstraints {
            $0.top.bottom.equalTo(self.safeAreaLayoutGuide)
            $0.leadingMargin.equalTo(12)
            $0.trailingMargin.equalTo(-12)
        }
    }
    
}
