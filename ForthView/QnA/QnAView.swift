//
//  QnAView.swift
//  MiracleMorningProject
//
//  Created by 이동기 on 2022/10/03.
//

import UIKit

class QnAView: BaseView {
    
    let QnATextView: UITextView = {
        let view = UITextView()
        view.text = """
        Q. 당일날 스케쥴을 추가 할 순 없나요?
        A. 네. 앱의 특성상 다음 날부터 스케쥴이 추가됩니다.
            
        Q. 스케쥴을 잘못 추가했어요 수정이나 삭제는 어떻게하나요?
        A. 달력이있는 페이지(두 번째 탭바)의 목록을 누르거나 스와이프하면 수정 및 삭제가 가능합니다.
        
        Q. 일괄삭제, 일괄수정 기능은 없나요?
        A. 추후 업데이트 예정입니다. 현재 개별적으로 수정 삭제가 가능합니다.
        
        Q. 지나간 스케쥴은 수정이나 삭제가 불가하나요?
        A. 네 앱의 특성상 불가합니다.
        """
        view.textColor = .black
        view.isEditable = false
        return view
    }()
    
    override func configureUI() {
        self.addSubview(QnATextView)
    }
    
    override func setConstraints() {
        
        QnATextView.snp.makeConstraints {
            $0.top.bottom.equalTo(self.safeAreaLayoutGuide)
            $0.leadingMargin.equalTo(12)
            $0.trailingMargin.equalTo(-12)
        }
    }
    
}
