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

//enum ColorSet {
//    firstColor = R: 253 G: 242 B: 235
//    secondColor = R: 242 G: 188 B: 153
//    thirdColor = R: 240 G: 145 B: 89
//    forthColor = R: 238 G: 123 B: 63
//}

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
    
    

    var tasks: Results<UserSchedule>! {
        didSet {
            dayTasks = repository.filterDayTasks(date: selectedDate)
            mainView.tableView.reloadData()
            mainView.collectionView.reloadData()
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
        for i in 0..<repository.successSchedule(currentDate: startOfMonth).count {
            scheduleCountDic.updateValue(repository.successScheduleNumber(key: repository.successSchedule(currentDate: startOfMonth)[i].schedule).count, forKey: repository.successSchedule(currentDate: startOfMonth)[i].schedule)
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
        
        let components = calendar.dateComponents([.year, .month], from: date)
        let startOfMonth = calendar.date(from: components)!
        
        for i in 0..<repository.successSchedule(currentDate: startOfMonth).count {
            scheduleCountDic.updateValue(repository.successScheduleNumber(key: repository.successSchedule(currentDate: startOfMonth)[i].schedule).count, forKey: repository.successSchedule(currentDate: startOfMonth)[i].schedule)
        }
        
        mainView.collectionView.reloadData()
        mainView.calendar.reloadData()
        self.fetchRealm()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
        let vc = ChangeScheduleViewController()
        
        vc.setScheduleTextFieldTitle = dayTasks[indexPath.row].schedule
        vc.startTimeButtonTitle = dayTasks[indexPath.row].startTime
        vc.endTimeButtonTitle = dayTasks[indexPath.row].endTime
        vc.objectID = dayTasks[indexPath.row].objectID
        vc.receivedDate = dayTasks[indexPath.row].scheduleDate
        
        // 2. 클로저 함수 정의
        vc.okButtonActionHandler = {
            self.mainView.tableView.reloadData()
        }
        
        self.mainView.collectionView.reloadData()
        
        let nav = UINavigationController(rootViewController: vc)
        present(nav, animated: true)
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
            return repository.filterDayTasks(date: date).count
        } else {
            return 0
        }
    }
    
    // ... 색깔
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventDefaultColorsFor date: Date) -> [UIColor]? {
        
        dayTasks
        
        if date < now {
            return [UIColor.black, UIColor.purple, UIColor.systemGray]
        } else {
            return [UIColor.systemOrange, UIColor.systemRed, UIColor.systemCyan]
        }
    }
    
    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {

        let cell = calendar.dequeueReusableCell(withIdentifier: "CELL", for: date, at: position)

        return cell
    }
    
    // 선택시 날짜 테두리 색상
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, borderSelectionColorFor date: Date) -> UIColor? {
        return UIColor.black
    }
    
    // 오늘날짜 -> "오늘"
    func calendar(_ calendar: FSCalendar, titleFor date: Date) -> String? {
        switch DateFormatChange.shared.dateOfYearMonthDay.string(from: date) {
        case DateFormatChange.shared.dateOfYearMonthDay.string(from: now):
            return "오늘"
        default:
            return nil
        }
    }
    
    
    // 캘린더 날짜 선택
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        selectedDate = date
        scheduleInfo = []
        
        dayTasks = repository.filterDayTasks(date: date)
        self.fetchRealm()

        mainView.tableViewHeaderLabel.text = DateFormatChange.shared.dateOfMonth.string(from: date)
        
        if date < Calendar.current.startOfDay(for: now) - 86400 + 3600 * 9 {
            mainView.tableView.isUserInteractionEnabled = false
        } else {
            mainView.tableView.isUserInteractionEnabled = true
        }
        
        // 캘린더 스와이프시에 테이블뷰 나타내기
        mainView.tableView.isHidden = false
    }
    
    // 캘린더 스와이프
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {

        let currentPageDate = calendar.currentPage
        let month = Calendar.current.component(.month, from: currentPageDate)
        
        scheduleCountDic = [:]
        
        // 스와이프시 date값을 변경시켜야 다른 페이지를 갔다와도 해당 월의 스케쥴 성공여부가 컬렉션뷰에 잘 나옴
        date = currentPageDate
        
        for i in 0..<repository.successSchedule(currentDate: currentPageDate).count {
            scheduleCountDic.updateValue(repository.successScheduleNumber(key: repository.successSchedule(currentDate: currentPageDate)[i].schedule).count, forKey: repository.successSchedule(currentDate: currentPageDate)[i].schedule)
        }
        
        mainView.collectionViewHeaderLabel.text = "\(month)월 미션 현황"
                
        // 캘린더 스와이프시에 테이블뷰 숨기기
        mainView.tableView.isHidden = true

        mainView.collectionView.reloadData()
    }
}
