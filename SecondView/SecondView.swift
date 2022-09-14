//
//  SecondView.swift
//  MiracleMorningProject
//
//  Created by 이동기 on 2022/09/11.
//

import UIKit

import FSCalendar

class SecondView: BaseView {
    
    public let calendar: FSCalendar = {
        let view = FSCalendar()
        return view
    }()
    
    private let collectionViewHeaderLabel: UILabel = {
        let view = UILabel()
        view.text = "9월 미션 현황"
        view.font = .boldSystemFont(ofSize: 18)
        return view
    }()
    
    public let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let space: CGFloat = 4
        let width = UIScreen.main.bounds.width - (space * 7)
        let height = width

        layout.itemSize = CGSize(width: width / 6, height: width / 6)
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: space, left: space, bottom: space, right: space)
        layout.minimumLineSpacing = space
        layout.minimumInteritemSpacing = space
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        return view
    }()
    
    private let borderWithCollectioinView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.systemGray5.cgColor
        return view
    }()
    
    private let tableViewHeaderLabel: UILabel = {
        let view = UILabel()
        view.text = "9월 14일"
        view.font = .boldSystemFont(ofSize: 18)
        return view
    }()
    
    public let tableView: UITableView = {
        let view = UITableView()
        view.rowHeight = 48
        return view
    }()
    
    
    private let borderWithTabBar: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.systemGray3.cgColor
        return view
    }()
    
    override func configureUI() {
        [calendar, collectionViewHeaderLabel, collectionView, borderWithCollectioinView, tableView, tableViewHeaderLabel, borderWithTabBar].forEach { self.addSubview($0) }
        
    }
    
    override func setConstraints() {
        
        calendar.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.leading.equalTo(self.safeAreaLayoutGuide)
            $0.trailing.equalTo(self.safeAreaLayoutGuide)
            $0.height.equalTo(UIScreen.main.bounds.height * 0.36)
        }
        
        collectionViewHeaderLabel.snp.makeConstraints {
            $0.topMargin.equalTo(calendar.snp.bottom).offset(24)
            $0.leadingMargin.equalTo(19)
            $0.width.equalTo(100)
            $0.height.equalTo(20)
        }
        
        collectionView.snp.makeConstraints {
            $0.topMargin.equalTo(collectionViewHeaderLabel.snp.bottom).offset(20)
            $0.leadingMargin.equalTo(40)
            $0.trailingMargin.equalTo(-12)
            $0.height.equalTo(UIScreen.main.bounds.height / 10)
        }
        
        borderWithCollectioinView.snp.makeConstraints {
            $0.leadingMargin.equalTo(20)
            $0.trailingMargin.equalTo(0)
            $0.height.equalTo(1)
            $0.topMargin.equalTo(collectionView.snp.bottom).offset(8)
        }
        
        tableViewHeaderLabel.snp.makeConstraints {
            $0.leadingMargin.equalTo(20)
            $0.topMargin.equalTo(borderWithCollectioinView.snp.bottom).offset(28)
            $0.width.equalTo(100)
            $0.height.equalTo(20)
        }
        
        tableView.snp.makeConstraints {
            $0.leadingMargin.equalTo(20)
            $0.trailingMargin.equalTo(0)
            $0.topMargin.equalTo(tableViewHeaderLabel.snp.bottom).offset(20)
            $0.bottomMargin.equalTo(borderWithTabBar.snp.top).offset(-20)
        }
        
        borderWithTabBar.snp.makeConstraints {
            $0.width.equalTo(UIScreen.main.bounds.width)
            $0.height.equalTo(1)
            $0.bottom.equalTo(self.safeAreaLayoutGuide).offset(-12)
        }
          
    }
}
