//
//  BaseCollectionViewCell.swift
//  MiracleMorningProject
//
//  Created by 이동기 on 2022/09/14.
//

import UIKit

import SnapKit

class BaseCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }

    func configureUI() { }
    
    func setConstraints() { }
    
}
