//
//  ForthView.swift
//  MiracleMorningProject
//
//  Created by 이동기 on 2022/09/11.
//

import UIKit

enum numberOfCell {
    static let profile = 2.0
    static let setting = 3.0
}

class ForthView: BaseView {
    
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = .systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let contentsView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        return view
    }()

// MARK: - 프로필
    let profileTitle: UILabel = {
        let view = UILabel()
        view.text = "프로필"
        view.font = .boldSystemFont(ofSize: 20)
        view.textColor = .systemGray
        return view
    }()
    
    let profileImageBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        return view
    }()
    
    let profileImageLabel: UILabel = {
        let view = UILabel()
        view.text = "아기햇님"
        view.font = .boldSystemFont(ofSize: 14)
        view.textAlignment = .center
        return view
    }()
    
    let profileImageMoreInfoButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "questionmark.circle"), for: .normal)
        view.tintColor = .systemGray3
        return view
    }()
    
    let profileImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "sun.max")
        view.contentMode = .scaleToFill
        return view
    }()
    
    let profileTableView: UITableView = {
        let view = UITableView()
        view.rowHeight = 60
        view.isScrollEnabled = false
        return view
    }()
    
// MARK: - 설정
    private let settingTitle: UILabel = {
        let view = UILabel()
        view.text = "설정"
        view.font = .boldSystemFont(ofSize: 20)
        view.textColor = .systemGray
        return view
    }()
    
    private let settingView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 20
        return view
    }()
    
    private let settingAlarmLabel: UILabel = {
        let view = UILabel()
        view.text = "알림설정"
        view.font = .boldSystemFont(ofSize: 15)
        return view
    }()
    
    public let alarmToggle: UISwitch = {
        let view = UISwitch()
        return view
    }()
    
    private let borderWithEtc: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.systemGray4.cgColor
        return view
    }()
    
    
// MARK: - 기타
    
    private let etcTitle: UILabel = {
        let view = UILabel()
        view.text = "기타"
        view.font = .boldSystemFont(ofSize: 20)
        view.textColor = .systemGray
        return view
    }()
    
    let tableView: UITableView = {
        let view = UITableView()
        view.rowHeight = 60
        view.isScrollEnabled = false
        return view
    }()
    
    let borderWithTabBar: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.systemGray3.cgColor
        return view
    }()
    
    
    override func configureUI() {
        [profileTitle, profileImageBackgroundView, profileImage,profileImageLabel, profileImageMoreInfoButton, profileTableView, settingTitle, settingView, settingAlarmLabel, alarmToggle, borderWithEtc, etcTitle, tableView, borderWithTabBar].forEach { contentsView.addSubview($0) }
        
        scrollView.addSubview(contentsView)
        self.addSubview(scrollView)
    }
    
    override func setConstraints() {
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.bottom.equalTo(safeAreaLayoutGuide).offset(-8)
            $0.leading.trailing.equalToSuperview()
        }
        
// MARK: - 프로필 레이아웃
        
        profileTitle.snp.makeConstraints {
            $0.topMargin.equalTo(20)
            $0.leadingMargin.equalTo(12)
            $0.width.equalTo(100)
            $0.height.equalTo(48)
        }
        
        profileImageBackgroundView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.topMargin.equalTo(profileTitle.snp.bottom).offset(12)
            $0.width.equalToSuperview()
            $0.height.equalTo(UIScreen.main.bounds.height / 5)
        }
        
        profileImage.snp.makeConstraints {
            $0.width.height.equalTo(UIScreen.main.bounds.width / 7)
            $0.centerX.centerY.equalTo(self.profileImageBackgroundView)
        }
        
        profileImageLabel.snp.makeConstraints {
            $0.topMargin.equalTo(profileImage.snp.bottom).offset(12)
            $0.height.equalTo(20)
            $0.centerX.equalTo(self.profileImageBackgroundView)
        }
        
        profileImageMoreInfoButton.snp.makeConstraints {
            $0.width.height.equalTo(20)
            $0.leadingMargin.equalTo(profileImageLabel.snp.trailing).offset(8)
            $0.centerY.equalTo(self.profileImageLabel)
        }
        
        profileTableView.snp.makeConstraints {
            $0.leadingMargin.equalTo(20)
            $0.trailingMargin.equalTo(-20)
            $0.topMargin.equalTo(profileImageBackgroundView.snp.bottom).offset(20)
            $0.height.equalTo(profileTableView.rowHeight * numberOfCell.profile)
        }
        
// MARK: - 설정레이아웃
        
        settingTitle.snp.makeConstraints {
            $0.topMargin.equalTo(profileTableView.snp.bottom).offset(28)
            $0.leadingMargin.equalTo(12)
            $0.width.equalTo(100)
            $0.height.equalTo(48)
        }
        
        settingView.snp.makeConstraints {
            $0.topMargin.equalTo(settingTitle.snp.bottom).offset(12)
            $0.height.equalTo(52)
            $0.leadingMargin.equalTo(12)
            $0.trailingMargin.equalTo(-12)
            $0.bottomMargin.equalTo(-12)
        }
        
        settingAlarmLabel.snp.makeConstraints {
            $0.centerY.equalTo(self.settingView)
            $0.height.equalTo(20)
            $0.leading.equalTo(settingView.snp.leading).inset(8)
        }
        
        alarmToggle.snp.makeConstraints {
            $0.centerY.equalTo(self.settingView)
            $0.width.equalTo(40)
            $0.height.equalTo(28)
            $0.trailing.equalTo(settingView.snp.trailing).inset(16)
        }
        
        borderWithEtc.snp.makeConstraints {
            $0.leadingMargin.equalTo(30)
            $0.trailingMargin.equalTo(-8)
            $0.height.equalTo(0.5)
            $0.topMargin.equalTo(settingView.snp.bottom).offset(12)
        }
        
        
        
// MARK: - 기타 레이아웃
        
        etcTitle.snp.makeConstraints {
            $0.topMargin.equalTo(borderWithEtc.snp.bottom).offset(28)
            $0.leadingMargin.equalTo(12)
            $0.width.equalTo(100)
            $0.height.equalTo(48)
        }
        
        tableView.snp.makeConstraints {
            $0.topMargin.equalTo(etcTitle.snp.bottom).offset(12)
            $0.leadingMargin.equalTo(20)
            $0.trailingMargin.equalTo(-20)
            $0.bottom.equalTo(borderWithTabBar.snp.top)

        }
        
        borderWithTabBar.snp.makeConstraints {
            $0.width.equalTo(UIScreen.main.bounds.width)
            $0.height.equalTo(1)
            $0.bottom.equalTo(self.safeAreaLayoutGuide).offset(-12)
        }
        
        contentsView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.snp.width)
            $0.height.equalTo(1000)
        }
    }
}
