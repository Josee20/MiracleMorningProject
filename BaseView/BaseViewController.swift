//
//  MainViewController.swift
//  MiracleMorningProject
//
//  Created by 이동기 on 2022/09/11.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        setConstraints()

    }
    
    func configure() { }
    
    func setConstraints() { }
    
    func showAlertMessage(title: String, button: String = "네") {
        
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: button, style: .default) { _ in
            self.dismiss(animated: true)
        }

        let cancel = UIAlertAction(title: "아니요", style: .cancel)
        alert.addAction(ok)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
}