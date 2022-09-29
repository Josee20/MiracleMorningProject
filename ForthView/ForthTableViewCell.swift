//
//  ForthTableViewCell.swift
//  MiracleMorningProject
//
//  Created by 이동기 on 2022/09/25.
//

import UIKit
import SwiftUI

protocol toggleDelegate: AnyObject {
    func alarmToggleClickedP(_ sender: UISwitch)
}


class ForthTableViewCell: BaseTableViewCell {
    
    var alarmToggleDelegate: toggleDelegate?
    
    let tableBackgroundView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.backgroundColor = .systemGray6
        return view
    }()
    
    let cellTitle: UILabel = {
        let view = UILabel()
        view.text = "개인정보"
        view.font = .boldSystemFont(ofSize: 15)
        return view
    }()
    
    let moreButtonImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "chevron.right")
        view.tintColor = .systemGray2
        return view
    }()
    
    public var alarmToggle: UISwitch = {
        let view = UISwitch()
        view.isEnabled = true
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.alarmToggle.addTarget(self, action: #selector(alarmToggleClicked), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureUI() {
        [tableBackgroundView, cellTitle, moreButtonImage].forEach { self.addSubview($0) }
    }
    
    override func setConstraints() {
       
        tableBackgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(4)
        }
        
        cellTitle.snp.makeConstraints {
            $0.leadingMargin.equalTo(8)
            $0.width.equalTo(200)
            $0.height.equalTo(40)
            $0.centerY.equalTo(self)
        }
        
        moreButtonImage.snp.makeConstraints {
            $0.width.equalTo(12)
            $0.height.equalTo(16)
            $0.centerY.equalTo(self)
            $0.trailingMargin.equalTo(-12)
        }
    }
    
    @objc func alarmToggleClicked() {
        alarmToggleDelegate?.alarmToggleClickedP(alarmToggle)
    }
}


