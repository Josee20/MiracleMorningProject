//
//  SecondViewController.swift
//  MiracleMorningProject
//
//  Created by 이동기 on 2022/09/11.
//

import Foundation
import UIKit

import FSCalendar
import RealmSwift

class SecondViewController: BaseViewController {
    
    let repository = UserScheduleRepository()
    
    let mainView = SecondView()
    
    var eventArr = Set<Date>()
    var dayEventArr = [String]()
    var scheduleInfo = [scheduleInfoModel]()
    var scheduleCountDic = [String:Int]()
    
    let now = Date()
    
    var date = Date()
    let calendar = Calendar.current
    
    var height: CGFloat?
    
    var selectedDate: Date = Date()
    
    var successCount = 0
    
    var tasks: Results<UserSchedule>! {
        didSet {
            dayTasks = repository.filterDayTasks(date: selectedDate)
            dayTasksAndSuccess = repository.filterDayTasksAndSuccess(date: selectedDate)
            mainView.tableView.reloadData()
            mainView.collectionView.reloadData()
        }
    }
     
    var dayTasks: Results<UserSchedule>!
    var dayTasksAndSuccess: Results<UserSchedule>!
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.backgroundColor = .systemBackground
        
        self.navigationController?.isNavigationBarHidden = true

        print(repository.localRealm.configuration.fileURL!)
        
        // 처음 캘린더에 선택된 날짜의 데이터 나타내기
        mainView.tableViewHeaderLabel.text = DateFormatChange.shared.dateOfMonth.string(from: now)
        
        // 현재시간 기준으로 tasks 필터링
        dayTasks = repository.filterDayTasks(date: now)
        dayTasksAndSuccess = repository.filterDayTasksAndSuccess(date: now)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let components = calendar.dateComponents([.year, .month], from: date)
        let startOfMonth = calendar.date(from: components)!
        
        // 반드시 fetch를 해주고 setEvents를 실행시켜 해주어야함
        // 그래야 Realm에서 tasks.count를 맞춰 setEvents메소드를 쓸 수 있음
        fetchRealm()
        setEvents()

        mainView.tableView.reloadData()
        mainView.calendar.reloadData()
        mainView.collectionView.reloadData()
        
        // 컬렉션뷰 업데이트
        for i in 0..<repository.successScheduleInMonth(currentDate: startOfMonth).count {
            scheduleCountDic.updateValue(repository.successScheduleNumber(key: repository.successScheduleInMonth(currentDate: startOfMonth)[i].schedule).count, forKey: repository.successScheduleInMonth(currentDate: startOfMonth)[i].schedule)
        }
        
        
    }
    
    override func configure() {
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        mainView.collectionView.register(SecondCollectionViewCell.self, forCellWithReuseIdentifier: SecondCollectionViewCell.reuseIdentifier)
        
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.register(SecondTableViewCell.self, forCellReuseIdentifier: SecondTableViewCell.reuseIdentifier)
        
        mainView.calendar.delegate = self
        mainView.calendar.dataSource = self
        mainView.calendar.register(SecondFSCalendarCell.self, forCellReuseIdentifier: "CELL")
    }
    
    func fetchRealm() {
        tasks = repository.fetch()
    }
    
    // events배열에 스케쥴 날짜 추가
    func setEvents() {

        for i in 0..<tasks.count {
            let eventDate = tasks[i].scheduleDate
            eventArr.insert(eventDate)
        }
    }
}




