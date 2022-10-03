//
//  NoticeViewController.swift
//  MiracleMorningProject
//
//  Created by 이동기 on 2022/10/03.
//

import UIKit

class NoticeViewController: BaseViewController {
    
    let mainView = NoticeView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.backgroundColor = .systemBackground
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = .black
    }
}
