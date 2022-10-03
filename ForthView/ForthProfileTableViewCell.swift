//
//  ForthProfileTableViewCell.swift
//  MiracleMorningProject
//
//  Created by 이동기 on 2022/09/25.
//

import UIKit

class ForthProfileTableViewCell: BaseTableViewCell {
    
//    let tableBackgroundView: UIView = {
//        let view = UIView()
//        view.layer.cornerRadius = 20
//        view.backgroundColor = .systemGray6
//        return view
//    }()
    
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
    
    override func configureUI() {
        [cellTitle, moreButtonImage].forEach { self.addSubview($0) }
    }
    
    override func setConstraints() {
       
//        tableBackgroundView.snp.makeConstraints {
//            $0.edges.equalToSuperview().inset(4)
//        }
        
        cellTitle.snp.makeConstraints {
            $0.leadingMargin.equalTo(8)
            $0.width.equalTo(100)
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
    
}
