//
//  SecondViewController.swift
//  MiracleMorningProject
//
//  Created by 이동기 on 2022/09/11.
//

import Foundation
import UIKit

class SecondViewController: BaseViewController {
    
    let mainView = SecondView()
    
    override func loadView() {
        self.view = mainView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.backgroundColor = .systemBackground
        
    }
}
