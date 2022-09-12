//
//  ForthViewController.swift
//  MiracleMorningProject
//
//  Created by 이동기 on 2022/09/11.
//

import Foundation

class ForthViewController: BaseViewController {
    
    let mainView = ForthView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.backgroundColor = .systemBackground
        
    }
}
