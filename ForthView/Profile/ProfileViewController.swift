//
//  ProfileViewController.swift
//  MiracleMorningProject
//
//  Created by 이동기 on 2022/10/03.
//

import UIKit

import Toast

class ProfileViewController: BaseViewController {
    
    let mainView = ProfileView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.backgroundColor = .systemBackground
        
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveButtonClicked))
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = false
    }
    
    @objc func saveButtonClicked() {
        
        if mainView.nicknameTextFiled.text!.count > 15 {
            self.view.makeToast("15자 이하의 닉네임만 가능합니다", duration: 3.0, position: .center)
            mainView.nicknameTextFiled.text = ""
        } else {
            UserDefaults.standard.set("\(mainView.nicknameTextFiled.text!)", forKey: "nickname")
            self.navigationController?.popViewController(animated: true)
        }
        
    }
}
