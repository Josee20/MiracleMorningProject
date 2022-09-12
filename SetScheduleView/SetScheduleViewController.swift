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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.backgroundColor = .systemBackground
        addCancelButton()
    }
    
    override func configure() {

//        setTextViewPlaceholder()
    }
    
//    func setTextViewPlaceholder() {
//        mainView.setScheduleTextView.delegate = self
//        mainView.setScheduleTextView.text = "예) 알고리즘"
//        mainView.setScheduleTextView.textColor = .lightGray
//        mainView.setScheduleTextView.textAlignment = .center
//    }
    
    
    
    
    
    
    
    
    
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

//extension SetScheduleViewController: UITextViewDelegate {
//    
//    func textViewDidBeginEditing(_ textView: UITextView) {
//        if textView.textColor == .lightGray {
//            textView.text = nil
//            textView.textColor = .black
//        }
//    }
//    
//    func textViewDidEndEditing(_ textView: UITextView) {
//        if textView.text.isEmpty {
//            textView.text = "예) 알고리즘"
//            textView.textColor = .lightGray
//        }
//    }
//}
