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
    
    // 여기선 filterTasks에서 시간 처리를 해주기때문에 그냥 now로 써도 됨
    let now = Date()
    
    var selectedDate: Date = Date()
    
    var tasks: Results<UserSchedule>! {
        didSet {
            dayTasks = repository.filterDayTasks(date: selectedDate)
            mainView.tableView.reloadData()
            mainView.collectionView.reloadData()
            mainView.calendar.reloadData()
        }
    }
    
    var dayTasks: Results<UserSchedule>!
    
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.backgroundColor = .systemBackground

        print(repository.localRealm.configuration.fileURL!)
        
        
        // 처음 캘린더에 선택된 날짜의 데이터 나타내기
        mainView.tableViewHeaderLabel.text = DateFormatChange.shared.dateOfMonth.string(from: now)
        
        // 현재시간 기준으로 tasks 필터링
        dayTasks = repository.filterDayTasks(date: now)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 반드시 fetch를 해주고 setEvents를 실행시켜 해주어야함
        // 그래야 Realm에서 tasks.count를 맞춰 setEvents메소드를 쓸 수 있음
        fetchRealm()
        setEvents()

        mainView.tableView.reloadData()
        mainView.calendar.reloadData()
        mainView.collectionView.reloadData()
        
        // 컬렉션뷰 업데이트
        for i in 0..<repository.successSchedule().count {
            scheduleCountDic.updateValue(repository.successScheduleNumber(key: repository.successSchedule()[i].schedule).count, forKey: repository.successSchedule()[i].schedule)
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

extension SecondViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dayTasks.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SecondTableViewCell.reuseIdentifier, for: indexPath) as? SecondTableViewCell else {
            return UITableViewCell()
        }
        
        cell.scheduleTitle.text = dayTasks[indexPath.row].schedule
        cell.scheduleTime.text = "\(dayTasks[indexPath.row].startTime)~\(dayTasks[indexPath.row].endTime)"
        dayTasks[indexPath.row].scheduleSuccess == true ? cell.checkButton.setImage(UIImage(systemName: "checkmark.square") , for: .normal) : cell.checkButton.setImage(UIImage(systemName: "x.square"), for: .normal)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            repository.delete(item: dayTasks?[indexPath.row])
        }
        
        // 셀삭제하면 컬렉션뷰에 나타난 count 업데이트
        for i in 0..<repository.successSchedule().count {
            scheduleCountDic.updateValue(repository.successScheduleNumber(key: repository.successSchedule()[i].schedule).count, forKey: repository.successSchedule()[i].schedule)
        }
        
        print("======================\(scheduleCountDic)")
        self.fetchRealm()
    }
}

extension SecondViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return scheduleCountDic.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let space: CGFloat = 4
        let width = UIScreen.main.bounds.width - (space * 7)
        
        // 딕셔너리 value 크기에 따라 정렬
        let sortedScheduleCountDic = scheduleCountDic.sorted { (first, second) in
            return first.value > second.value
        }
    
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SecondCollectionViewCell.reuseIdentifier, for: indexPath) as? SecondCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.scheduleLabel.text = sortedScheduleCountDic[indexPath.item].key
        cell.numberOfScheduleLabel.text = "\(sortedScheduleCountDic[indexPath.item].value)"
        
        cell.layer.cornerRadius = width / 6 / 2
        cell.backgroundColor = .lightGray
        
        return cell
    }
}

extension SecondViewController: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    
    // ... 개수
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {

        let eventStringArr = eventArr.map { DateFormatChange.shared.dateOfYearMonthDay.string(from: $0) }
        let eventDateArr = eventStringArr.map { DateFormatChange.shared.dateOfYearMonthDay.date(from: $0) }
                
        if eventDateArr.contains(date) {
            mainView.calendar.appearance.eventDefaultColor = .systemGray3
            mainView.calendar.appearance.eventSelectionColor = .systemGray3
            return repository.filterDayTasks(date: date).count
        } else {
            return 0
        }
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        selectedDate = date
        scheduleInfo = []
        
        dayTasks = repository.filterDayTasks(date: date)
        self.fetchRealm()

        mainView.tableViewHeaderLabel.text = DateFormatChange.shared.dateOfMonth.string(from: date)
    }
    
}
