//
//  ForthViewController.swift
//  MiracleMorningProject
//
//  Created by 이동기 on 2022/09/11.
//

import Foundation
import UIKit

enum EtcCell {
    static let contentsList = ["공지사항", "개인정보 보호 및 약관"]
}

class ForthViewController: BaseViewController {

    let mainView = ForthView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        
        mainView.backgroundColor = .systemBackground
        
    }
    
    override func configure() {
        mainView.profileTableView.delegate = self
        mainView.profileTableView.dataSource = self
        mainView.profileTableView.register(ForthProfileTableViewCell.self, forCellReuseIdentifier: ForthProfileTableViewCell.reuseIdentifier)
        
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.register(ForthTableViewCell.self, forCellReuseIdentifier: ForthTableViewCell.reuseIdentifier)
        
    }
    
    @objc func toggleSwitchClicked() {
        print("toggleSwitchClick")
    }
}

extension ForthViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == mainView.profileTableView {
            return 2
        } else {
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == mainView.profileTableView {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ForthProfileTableViewCell.reuseIdentifier, for: indexPath) as? ForthProfileTableViewCell else { return UITableViewCell() }
            
            if indexPath.row == 1 {
                cell.cellTitle.text = "백업 및 복구"
            }
            
            cell.selectionStyle = .none
            
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ForthTableViewCell.reuseIdentifier, for: indexPath) as? ForthTableViewCell else { return UITableViewCell() }
    
            cell.cellTitle.text = EtcCell.contentsList[indexPath.row]
            
            cell.selectionStyle = .none
            
            return cell
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

extension ForthViewController: toggleDelegate {
    func alarmToggleClickedP(_ sender: UISwitch) {
        
        mainView.tableView.reloadData()
    }
}

