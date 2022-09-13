//
//  SetScheduleViewController.swift
//  MiracleMorningProject
//
//  Created by 이동기 on 2022/09/11.
//

import Foundation
import UIKit

class SetScheduleViewController: BaseViewController {
    
    let mainView = SetScheduleView()
    
    override func loadView() {
        self.view = mainView

        // 버튼에 tag 부여
        let dayButtonArr = [mainView.sundayButton, mainView.mondayButton, mainView.tuesdayButton, mainView.wedensdayButton, mainView.thursdayButton, mainView.fridayButton, mainView.saturdayButton]
        
        for i in 0...6 {
            dayButtonArr[i].tag = i
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.backgroundColor = .systemBackground
        addCancelButton()
    }
    
    
    override func configure() {
        
        // MARK: 버튼마다 dayButtonClicked 함수 넣어주기
        let dayButtonArr = [mainView.sundayButton, mainView.mondayButton, mainView.tuesdayButton, mainView.wedensdayButton, mainView.thursdayButton, mainView.fridayButton, mainView.saturdayButton]
        
        for i in 0..<dayButtonArr.count {
            dayButtonArr[i].addTarget(self, action: #selector(dayButtonClicked), for: .touchUpInside)
        }
    }
    
    // MARK: 클릭하면 백그라운드 색 변경
    @objc func dayButtonClicked(sender: UIButton) {
        let dayButtonArr = [mainView.sundayButton, mainView.mondayButton, mainView.tuesdayButton, mainView.wedensdayButton, mainView.thursdayButton, mainView.fridayButton, mainView.saturdayButton]
        
        if dayButtonArr[sender.tag].backgroundColor == UIColor.lightGray {
            dayButtonArr[sender.tag].backgroundColor = .orange
        } else if dayButtonArr[sender.tag].backgroundColor == UIColor.orange {
            dayButtonArr[sender.tag].backgroundColor = .lightGray
        }
    }
    
    func addCancelButton() {
        let cancelButton = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(cancelButtonClicked))
        
        cancelButton.tintColor = .black
        
        let space = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: self, action: nil)
        
        self.navigationItem.setRightBarButtonItems([space, cancelButton], animated: false)
    }
    
    @objc func cancelButtonClicked() {
        self.dismiss(animated: true)
    }
    
}

