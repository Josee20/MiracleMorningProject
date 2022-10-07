

# 개발 공수


## 📅 이터레이션 1 (9/8 ~ 9/11)
| 9/8(목) | 9/9(금) | 9/10(토) | 9/11(일) | 
| --- | --- | --- | --- | 
|휴식| 휴식  | 휴식    |    1P 탭바(1시간)  | 
|  |  |  | 1P UI(2시간) |
|  |  |  | 헤더뷰(1시간) |
|  |  |  | 좌측상단시간(2시간) |

## 📅 이터레이션 2 (9/12 ~ 9/14)
| 9/12(월) | 9/13(화) | 9/14(수) |  
| --- | --- | --- | 
| 3P UI + Circular Progress(5시간)   | 3P 노티피케이션(2시간)    |  4P UI(4시간)   |  
|2P 버튼 선택(2시간) | 2P 얼럿 + 데이트피커(3시간)| 데이터 스키마(2시간)|
|2P 미션 텍스트필드(1시간) |2P 예외처리(1시간)||


## 📅 이터레이션 3 (9/15 ~ 9/18)
| 9/15(목) | 9/16(금) | 9/17(토) | 9/18(일) | 
| --- | --- | --- | --- | 
| 캘린더 하단 list(3시간)    | 통계수치(3시간)    |  개인정보기능(2시간)   |  휴식   | 
| 5P UI(3시간)   |  6P + 세부항목 UI(3시간)   | 백업기능(4시간)    |  |

## 📅 이터레이션 4 (9/19 ~ 9/21)
| 9/19(월) | 9/20(화) | 9/21(수) |  
| --- | --- | --- | 
|  방해금지모드(3시간)   | 연속성공일에 맞춰 캐릭터변경(3시간)    | 1P, 3P 확인(3시간)    |  
| 캐릭터 UI(3시간)| 1P, 2P 확인(3시간) | 4P 확인(3시간) |

## 📅 이터레이션 5 (9/22 ~ 9/25)
| 9/22(목) | 9/23(금) | 9/24(토) | 9/25(일) | 
| --- | --- | --- | --- | 
|  4P 확인(3시간)   |  백업확인(3시간)   |  리팩토링(6시간)  | 휴식    | 
| 5P 확인(3시간) | 방해금지모드 확인(1시간) | | |
||6P 나머지확인(2시간)|||

## 📅 이터레이션 6 (9/26 ~ 9/28)
| 9/26(월) | 9/27(화) | 9/28(수) |  
| --- | --- | --- | 
| 리팩토링(6시간)    |  리팩토링(6시간)   |  리팩토링(6시간)   |  

## 📅 이터레이션 7 (9/29 ~ 10/2)
| 9/29(목) | 9/30(금) | 10/1(토) | 10/2(일) | 
| --- | --- | --- | --- | 
|  리팩토링(6시간)   |  리팩토링(6시간)   |  리팩토링(6시간)   |   리팩토링(6시간)  | 

## 📅 이터레이션 8 (10/3 ~ 10/5)
| 10/3(월) | 10/4(화) | 10/5(수) |  
| --- | --- | --- | 
|   리팩토링(6시간)  |  리팩토링(6시간)   | 리팩토링(6시간)    |  

___

# 사용한 라이브러리
1. FSCalendar
2. SnapKit
3. RealmSwift


# DB구조
![[스크린샷 2022-09-23 오전 10.05.33.png]]
___

# 220911


## 1. 상단 상태바(시간, 와이파이, 배터리) 등 지우는 법

상단 스테이터스 바를 없애 조금 깔끔한? UI를 주고 싶어 지웠다.

노치가 있는 기종에선 안 지워 지는 것 같다.

```swift
override var prefersStatusBarHidden: Bool {
	return true
}
```


## 2. Timer

시간을 나타내주는데 실시간으로 업데이트를 해줄 필요가 있다고 생각해 Timer를 사용했다.

❎ 아직 정확하게 실시간 시간으로 떨어지지 않음(60초 단위로 업데이트)

-> 해결 : timeInterval을 1로 맞춰주면 1초마다 시간에 맞춰 갱신되기 때문에 정확히 시간을 맞춰서 띄워줄 수 있다.

```swift
class FirstViewController: BaseViewController {
        
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

		// 1초 간격으로 getCurrentTime 메소드 실행
		// 실시간을 가져올 수 있음
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(getCurrentTime), userInfo: nil, repeats: true)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        timer?.invalidate()
    }
    
    override func configure() {
        getCurrentTime()
    }

	// 레이블에 시간 나타내주는 메소드
    @objc func getCurrentTime() {
        mainView.presentTimeLabel.text = DateFormatChange.shared.fullDate.string(from: Date())
    }
}
```


## 헤더뷰 레이블 달기

```swift
func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

	let headerView = UIView()
	headerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 40)

	let titleLabel = UILabel()
	titleLabel.text = "할 일"
	titleLabel.textColor = .black
	titleLabel.font = .boldSystemFont(ofSize: 20)
	titleLabel.frame = CGRect(x: 0, y: 0, width: headerView.frame.width, height: headerView.frame.height)
	headerView.addSubview(titleLabel)

	return headerView
}
```
___

# 220912


## 1. circular progress view 

- loadview로 뷰를 불러오면 뷰가 겹치기 때문에 안 됨
- 때문에 뷰컨트롤러에 나머지 뷰를 넣어줌

```swift
// In TimerView
final class TimerView: BaseView {
    
    private enum Const {
        static let progressLineWidth = 10.0
        static let backgroundLineWidth = progressLineWidth - 5.0
        static let startAngle = CGFloat(-Double.pi / 2)
        static let endAngle = CGFloat(3 * Double.pi / 2)
        static let backgroundStrokeColor = UIColor.systemGray.cgColor
        static let progressStrokeColor = UIColor.systemOrange.cgColor
    }
    
    private let backgroundLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.lineWidth = Const.backgroundLineWidth
        layer.strokeEnd = 1
        layer.fillColor = UIColor.clear.cgColor
        layer.strokeColor = Const.backgroundStrokeColor
        return layer
    }()
    
    private let progressLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.lineWidth = Const.progressLineWidth
        layer.strokeEnd = 0
        layer.fillColor = UIColor.clear.cgColor
        layer.strokeColor = Const.progressStrokeColor
        return layer
    }()
    
    private var circularPath: UIBezierPath {
        UIBezierPath(
            arcCenter: CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height / 2),
            radius: self.frame.size.width / 2,
            startAngle: Const.startAngle,
            endAngle: Const.endAngle,
            clockwise: true
        )
    }
    
    var backgroundLayerColor: CGColor? {
        get { self.backgroundLayer.strokeColor }
        set { self.backgroundLayer.strokeColor = newValue }
    }
    var progressLayerColor: CGColor? {
        get { self.progressLayer.strokeColor }
        set { self.progressLayer.strokeColor = newValue }
    }
    var lineWidth: CGFloat {
        get { self.backgroundLayer.lineWidth }
        set { self.backgroundLayer.lineWidth = newValue }
    }
    
    required init() {
        super.init(frame: .zero)
        
        self.backgroundColor = .clear
        self.backgroundLayer.path = self.circularPath.cgPath
        self.progressLayer.path = self.circularPath.cgPath
        
        self.layer.addSublayer(self.backgroundLayer)
        self.layer.addSublayer(self.progressLayer)
    }
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        
        self.backgroundLayer.path = self.circularPath.cgPath
        self.progressLayer.path = self.circularPath.cgPath
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func start(duration: TimeInterval) {
        self.progressLayer.removeAnimation(forKey: "progress")
        let circularProgressAnimation = CABasicAnimation(keyPath: "strokeEnd")
        circularProgressAnimation.duration = duration
        circularProgressAnimation.toValue = 1.0
        circularProgressAnimation.fillMode = .forwards
        circularProgressAnimation.isRemovedOnCompletion = false
        self.progressLayer.add(circularProgressAnimation, forKey: "progress")
    }
}

// In ViewController
class TimerViewController: BaseViewController {
    
    let timeLabel = UILabel()
    
    var leftTime: Int = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground
        self.addTimerView(on: self.timeLabel)
        
        self.timeLabel.textAlignment = .center
        self.timeLabel.font = .boldSystemFont(ofSize: 40)
        
        self.view.addSubview(self.timeLabel)
        self.timeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.timeLabel.heightAnchor.constraint(equalToConstant: 300),
            self.timeLabel.widthAnchor.constraint(equalToConstant: 300),
            self.timeLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.timeLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
        ])
        
        // MARK: 타이머
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (t) in
            
            self.leftTime -= 1
            
            let minute = self.leftTime / 60
            let second = self.leftTime % 60
            
            if self.leftTime > 0 {
                self.timeLabel.text = String(format: "%02d:%02d", minute, second)
            } else {
                self.timeLabel.text = "끝!"
                self.okButton.layer.borderColor = UIColor.systemOrange.cgColor
                self.okButton.backgroundColor = .systemOrange
                self.okButton.isUserInteractionEnabled = true
            }
        })
    }
    
    private func addTimerView(on subview: UIView) {
        let timerView = TimerView()
        subview.addSubview(timerView)
        timerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            timerView.leftAnchor.constraint(equalTo: subview.leftAnchor),
            timerView.rightAnchor.constraint(equalTo: subview.rightAnchor),
            timerView.bottomAnchor.constraint(equalTo: subview.bottomAnchor),
            timerView.topAnchor.constraint(equalTo: subview.topAnchor),
        ])
        timerView.start(duration: Double(leftTime))
    }
}

final class RoundLabel: UILabel {

    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.clipsToBounds = true
        self.layer.cornerRadius = self.bounds.height / 2.0

    }
}
```


## 2. multiple button click and change background color

![[스크린샷 2022-09-13 오전 3.24.57.png | 300]]


### 중요사항

1. 버튼에 태그 지정해주기( 태그는 생존범위를 벗어난다고해서 사라지지 않음)
2. sender로 받기

```swift
// load View에 태그지정(뷰를 그려야 태그?를 지정할 수 있는 거 같음)
override func loadView() {
	self.view = mainView

	// 버튼에 tag 부여
	let dayButtonArr = [mainView.sundayButton, mainView.mondayButton, mainView.tuesdayButton, mainView.wedensdayButton, mainView.thursdayButton, mainView.fridayButton, mainView.saturdayButton]
	
	for i in 0...6 {
		dayButtonArr[i].tag = i
	}
}

// 각각 버튼에게 addTarget 부여
override func configure() {
        
	let dayButtonArr = [mainView.sundayButton, mainView.mondayButton, mainView.tuesdayButton, mainView.wedensdayButton, mainView.thursdayButton, mainView.fridayButton, mainView.saturdayButton]
	
	for i in 0..<dayButtonArr.count {
		dayButtonArr[i].addTarget(self, action: #selector(dayButtonClicked), for: .touchUpInside)
	}
}

// sender.tag로 받아서 백그라운드 컬러 변경
@objc func dayButtonClicked(sender: UIButton) {
	
	let dayButtonArr = [mainView.sundayButton, mainView.mondayButton, mainView.tuesdayButton, mainView.wedensdayButton, mainView.thursdayButton, mainView.fridayButton, mainView.saturdayButton]
	
	if dayButtonArr[sender.tag].backgroundColor == UIColor.gray {
		dayButtonArr[sender.tag].backgroundColor = .orange
	} else if dayButtonArr[sender.tag].backgroundColor == UIColor.orange {
		dayButtonArr[sender.tag].backgroundColor = .gray
	}
}

```

___

# 220913


## 1. Notification

1.  처음 뷰컨트롤러에 notificationCenter 초기화(싱글톤 패턴)
2.  requestNotificationAuthorization으로 처음에 알림 권한 설정

```swift
class FirstViewController: BaseViewController {
    
    let notificationCenter = UNUserNotificationCenter.current()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestNotificationAuthorization()
    }
    
    func requestNotificationAuthorization() {

        notificationCenter.requestAuthorization(options: [.alert, .sound]) { success, error in
            if let error = error {
                print(error)
            }
        }
    }
}
```


3. 알람 나타내고 싶은 뷰컨트롤러에 notificationCenter 다시초기화
4. callNotification 함수 만들어주기

```swift
class TimerViewController: BaseViewController {
    
    let notificationCenter = UNUserNotificationCenter.current()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.callNotification(time: 1, title: "미션 완료!!!", body: "다음 미션도 완수해주세요~~\n다 마치셨다면 당신은 멋쟁이!!!")
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { success, error in
            print(error)
        }
    }
    
    func callNotification(time: Double, title: String, body: String) {
        notificationCenter.removeAllPendingNotificationRequests()
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .defaultCritical
        content.badge = 2
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: time, repeats: false)
        
        let request = UNNotificationRequest(identifier: "notification", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            guard let error = error else { return }
            print(error)
        }
    }
}
```



## 2. Alert + DatePicker

1.  UIDatePicker() 초기화 후 스타일 잡아주기
2. UIAlertController 초기화 후 서브 뷰로 datePicker 넣어주기
3. 레이아웃 잡아주고 얼럿 액션 추가해주기
4. ok버튼 클릭시 시간선택 버튼 타이틀 해당 시간을 선택한 시간으로 변경해주기

```swift
@objc func setStartTimeButtonClicked(sender: UIDatePicker) {
	
	let datePicker = UIDatePicker()
	
	datePicker.datePickerMode = .time
	datePicker.preferredDatePickerStyle = .wheels
	datePicker.locale = NSLocale(localeIdentifier: "ko-KR") as Locale
	
	let alert = UIAlertController(title: "\n\n\n\n\n\n\n\n\n\n\n", message: nil, preferredStyle: .actionSheet)
	
	alert.view.addSubview(datePicker)
	
	datePicker.snp.makeConstraints {
		$0.centerX.equalTo(alert.view)
		$0.top.equalTo(alert.view).offset(8)
	}
	
	let ok = UIAlertAction(title: "확인", style: .default) { (action) in
		let dateString = DateFormatChange.shared.dateOfHourAndPM.string(from: datePicker.date)
		self.mainView.setStartTimeButton.setTitle(dateString, for: .normal)
		self.mainView.setStartTimeButton.setTitleColor(.systemBlue, for: .normal)
	}
	
	let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
	
	alert.addAction(ok)
	alert.addAction(cancel)
	
	present(alert, animated: true, completion: nil)
}
```
___

# 220914

## 1. CollectionView

<img width="669" alt="스크린샷 2022-09-14 오후 10 38 08" src="https://user-images.githubusercontent.com/92367484/190170742-2e358b39-679b-4686-ad33-57795f224fd2.png">

코드베이스로 컬렉션뷰를 테이블뷰와 같이 추가해 주려 했으나 다음과 같은 오류가 발생했다.

무슨 이유인지 알아보니 컬렉션뷰는 레이아웃이 없이 초기화가 불가능하다는 것이다.

즉 collectionView는 TableView와 다르게 뷰객체를 만들기전에 레이아웃을 다 지정해주어야한다.

다음과 같이 말이다.

```swift
public let collectionView: UICollectionView = {
	let layout = UICollectionViewFlowLayout()
	let space: CGFloat = 4
	let width = UIScreen.main.bounds.width - (space * 7)
	let height = width

	layout.itemSize = CGSize(width: width / 6, height: width / 6)
	layout.scrollDirection = .horizontal
	layout.sectionInset = UIEdgeInsets(top: space, left: space, bottom: space, right: space)
	layout.minimumLineSpacing = space
	layout.minimumInteritemSpacing = space
	
	let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
	
	return view
}()
```



##  2. TableView

추가한 스케쥴을 유저가 캘린더에서 클릭 시 확인할 수 있도록 하기위해 테이블 뷰로 작성했다.

아직은 UI만 된 상태....


<img width="250" alt="image" src= "https://user-images.githubusercontent.com/92367484/190173335-bc13ec8a-a65e-4b56-9cb8-77e5362b153c.png">


___

# 220915


## 1. Realm 

유저가 미션, 요일, 시간을 정해서 등록하면 등록일부터 이번 달 마지막일 까지 스케쥴이 생성될 수 있도록  만들고자 했습니다.

때문에 컬럼에 PK, 시작시간, 종료시간, Date, 미션이름, 수행여부를 나타내주기로 했습니다.

| PK    | 시작시간    |  종료시간     | Date    |  미션이름  | 수행여부 |
| --- | --- | --- | ---| --- | --- | 
| abcd1234|10:00 | 11:00| 23:12:22:... | 백준문제풀기 | false | 


### 1-1. Object Model 정의

```swift
import RealmSwift

class UserSchedule: Object {
    @Persisted var startTime: String
    @Persisted var endTime: String
    @Persisted var scheduleDate = Date()
    @Persisted var schedule: String
    @Persisted var scheduleSuccess: Bool
    
    @Persisted(primaryKey: true) var objectID: ObjectId
    
    convenience init(startTime: String, endTime: String, scheduleDate: Date, schedule: String, scheduleSuccess: Bool) {
        self.init()
        self.startTime = startTime
        self.endTime = endTime
        self.scheduleDate = scheduleDate
        self.schedule = schedule
        self.scheduleSuccess = false
    }
}
```



### 1-2. 다음 날부터 이번 달 마지막일까지 선택한  요일 스케쥴 등록

매일 or 매주가 아니라 한 달 단위로 계획을 세우고자 했습니다.

그렇기 때문에 이미 지나간 날은 빼줘야했고 아침이기 때문에 다음 날 기준으로 스케쥴이 생성되도록 했습니다.

추가적으로 달이 넘어가면 스케쥴이 더 이상 생성되지 않아야 되는 것과 선택한 요일만 추가 되어야한다는 것을 다음과 같이 구현했습니다.

```swift
var now = Date() + 86400 
let calendar = Calendar.current
let weekDayArr = ["일", "월", "화", "수", "목", "금", "토"]

@objc func okButtonClicked() {
	
	let currentMonth = self.calendar.component(.month, from: now)
		
		while true {
			
			let month = calendar.component(.month, from: now)
			let day = calendar.component(.weekday, from: now) - 1
			
			if currentMonth < month {
				break
			} else if weekDayArr[day] == mainView.sundayButton.titleLabel?.text && mainView.sundayButton.backgroundColor == .lightGray ||
				weekDayArr[day] == mainView.mondayButton.titleLabel?.text && mainView.mondayButton.backgroundColor == .lightGray ||
				weekDayArr[day] == mainView.tuesdayButton.titleLabel?.text && mainView.tuesdayButton.backgroundColor == .lightGray ||
				weekDayArr[day] == mainView.wedensdayButton.titleLabel?.text && mainView.wedensdayButton.backgroundColor == .lightGray ||
				weekDayArr[day] == mainView.thursdayButton.titleLabel?.text && mainView.thursdayButton.backgroundColor == .lightGray ||
				weekDayArr[day] == mainView.fridayButton.titleLabel?.text && mainView.fridayButton.backgroundColor == .lightGray ||
				weekDayArr[day] == mainView.saturdayButton.titleLabel?.text && mainView.saturdayButton.backgroundColor == .lightGray {
				now += 86400
				continue
			} else {
				repository.addSchedule(startTime: mainView.setStartTimeButton.titleLabel?.text ?? "", endTime: mainView.setEndTimeButton.titleLabel?.text ?? "", date: now, schedule: mainView.setScheduleTextField.text!, success: false)
				now += 86400
		}
			
		dismiss(animated: true)
	}
}
```

weekDayArr 배열을 만들어주고 calendar를 사용해 weekday를 가져오고나서 - 1을 해주면  weekDayArr[day]는 일요일이 되어 인덱싱이 이루어집니다.

그러면 내일부터 다음 달 이전까지의 요일을 가져올 수 있습니다.

그리고 그 요일이 만약 월요일이고 색깔이 lightGray ( 선택이 되지 않은 버튼)이면 다음 날로 넘어가고 continue로 무시해줘 선택하지 않은 요일은 건너 뛰어집니다.


### 1-3. 등록가능시간 예외처리

앱의 특성상 오전시간만 선택이 가능할 수 있도록 하는 것이 맞다고 생각했습니다.

오전 4시부터 오전9시까지 그 안에서만 시간 설정이 가능하도록 예외처리를 해주었습니다.

```Swfit
let ok = UIAlertAction(title: "확인", style: .default) { (action) in
	let dateString = DateFormatChange.shared.dateOfHourAndPM.string(from: datePicker.date)
	
	if self.calendar.component(.hour, from: datePicker.date) > 3 && self.calendar.component(.hour, from: datePicker.date) < 9 {
		self.mainView.setStartTimeButton.setTitle(dateString, for: .normal)
		self.mainView.setStartTimeButton.setTitleColor(.systemBlue, for: .normal)
	} else {
		self.showAlertOnlyOk(title: "오전 4시부터 오전9시까지만 시간설정이 가능합니다")
	}
}
```

캘린더를 사용해 데이트피커의 시간에서 hour만 가져와서 오전 4시 ~ 오전9시 사이의 시간만 등록이 가능하게 했습니다.

___

# 220916


## 1. 캘린더에 점(스케쥴) 찍어주기

```swift
func setEvents() {

	for i in 0..<tasks.count {
		let eventDateString = DateFormatChange.shared.dateOfYearMonthDay.string(from: tasks[i].scheduleDate)
		
		guard let eventDate = DateFormatChange.shared.dateOfYearMonthDay.date(from: eventDateString) else {
			return
		}
		
		events.append(eventDate)
	}
}

extension SecondViewController: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    
    // ... 개수
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        
        var j = 0
        
        let koreanStringDate = DateFormatChange.shared.dateOfYearMonthDay.string(from: date)
        guard let koreanDate = DateFormatChange.shared.dateOfYearMonthDay.date(from: koreanStringDate) else { return  1 }
        
        if self.events.contains(date) {
            j = 0
            for i in 0..<tasks.count {
                if self.events[i] == date {
                    j += 1
                }
            }
            mainView.calendar.appearance.eventDefaultColor = .systemGray3
            print("++++++++++ \(koreanDate)")
            return j
        } else {
            return 0
        }
    }
}

```

FSCalendar의 델리게이트 패턴을 이용하면 캘린더에서 다양한 기능들을 사용할 수 있게된다.

스케쥴을 등록하면 해당 날짜 밑에 ...을 만들어주고 싶었고 그 메소드는 `numberOfEventsFor` 메소드에서 다룰 수 있었다.

이 메소드는 이번 달의 date가 차례대로 모두 출력되게하는 기능?을 가지고 있는데 테이블뷰의 indexPath와 비슷하다.

그래서 date 값을 서로 비교해서 스케쥴이 있으면 출력해줘야한다고 생각했고 가장 먼저 eventArr 배열을 만들어 Realm의 ScheduleDate를 형태에 맞춰 date 배열로 만들어 줬다.

다음 이를 활용해 이벤트를 점으로 나타내려면 다음과 같은 로직이 필요하다고 생각했다.

1. 해당 날에 스케쥴을 가지고있는지 없는지
2. 만약 있다면 몇 개를 가지고 있는지
3. 스케쥴 개수 만큼 리턴해서 점 찍어주기

contain으로 확인해주고 변수 j를 활용해 스케쥴 개수만큼 리턴해줄 수 있도록했다.



## 1-2 ❎ 문제발생 ❎

앱을 껐다키면 제대로 ...이 날짜에 맞추어 인식되지만 스케쥴 등록 후 캘린더에 들어가면 제대로 ...이 안찍히는 현상일 발생했다.

최초에 스케쥴 등록시엔 잘 등록이 되지만 두 번째 부턴 밀리기 시작한다...

<img width="500" alt="스크린샷 2022-09-17 오후 4 06 21" src="https://user-images.githubusercontent.com/92367484/190851697-a11b02dd-911a-4caa-9a1c-e039160db9c9.png">

어째서인지 22일 23일에 ..이 등록되지 않고 27, 28일로 넘어가 버렸다... 그런데 앱을 껐다키면 제대로 인식이 되어 나타난다...

<img width="500" alt="스크린샷 2022-09-17 오후 4 08 28" src="https://user-images.githubusercontent.com/92367484/190851726-e3d31b21-b6bc-462f-8de7-3d85d279c391.png">


```swift
override func viewWillAppear(_ animated: Bool) {
	super.viewWillAppear(animated)
	
	// 반드시 fetch를 해주고 setEvents를 실행시켜 해주어야함
	// 그래야 Realm에서 tasks.count를 맞춰 setEvents메소드를 쓸 수 있음
	
	fetchRealm()
	setEvents()
	
	mainView.calendar.reloadData()
	print(eventArr)
}


func setEvents() -> [Date] {

	for i in 0..<tasks.count {
		let eventDateString = DateFormatChange.shared.dateOfYearMonthDay.string(from: tasks[i].scheduleDate
			
		guard let eventDate = DateFormatChange.shared.dateOfYearMonthDay.date(from: eventDateString) else {
			return [Date()]
		}
		
		eventArr.append(eventDate)
	}
	
	return eventArr
}

extension SecondViewController: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    
    // ... 개수
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        
        var j = 0
        
        if self.eventArr.contains(date) {
            j = 0
            for i in 0..<tasks.count {
                if self.eventArr[i] == date {
                    j += 1
                }
            }
            mainView.calendar.appearance.eventDefaultColor = .systemGray3
            return j
        } else {
            return 0
        }
    }
}
```


하나씩 찍어보니 이와 같은 문제가 발생하고 있었다.

<img width="900" alt="스크린샷 2022-09-17 오후 6 35 01" src="https://user-images.githubusercontent.com/92367484/190851625-e3b56b72-3780-4564-8699-d78cb64902a8.png">

viewWillAppear 시점에 `setEvents()` 를 해주니 뷰가 나올 때 마다 `setEvents()`가 실행되었고 때문에 eventArr의 인덱스값이 꼬이게되어 ... 이 제대로 찍히지 않은 것이다.

그렇다고 setEvents()의 시점을 바꾸자니 fetch 시점과 어긋나서 tasks.count와의 크기가 안 맞게되어버린다. 그렇다면 시점으로 해결할 문제는 일단 아니다.

다음으로 시도해본 것은 바보같지만 그럼 `setEvents()` 에 조건을 주어 새로 값이 추가될 때만 실행되게하면 어떨까 해서 다음과 같은 조건을 주었다.

```swift
override func viewWillAppear(_ animated: Bool) {
	super.viewWillAppear(animated)
	
	fetchRealm()

	if tasks.count > eventArr {
		setEvents()
	}
	
	mainView.calendar.reloadData()
	print(eventArr)
}
```

이렇게하면 분명 뷰가 나올 때마다 실행되는 것이 아니라 tasks에 이벤트가 업데이트 되어 `tasks.count`가 `eventArr`의 크기보다 커야 `setEvents()`가 실행 되게 될 것이다.

그렇다면 데이터를 추가하고 뷰를 띄우면 어떻게 될까?

새로운 값만 추가되는 것이 아니라 기존과 동일하게 기존값 + 새로운 값이 `eventArr`에 추가된다.

왜냐하면 `tasks`가 `eventArr`보다 클 때만 `setEvents()`를 실행하라고 했지 중복된 값은 빼라고 한게 아니니깐....

중복???? 그러면 배열에서 중복된 값을 없애주는 <span style="color:red">Set</span> 을 사용하면 어떨까???


## 1-3 오류해결 (feat. Set)

결국 문제는 중복된 값이 등록되기 때문이었다. 

그렇다면 우리는 중복된 값을 없애주는 Set을 가지고 있기 때문에 이걸 잘 사용하면 해결할 수 있을거라 생각했다.

```swift
class SecondViewController: BaseViewController {
    
    var eventArr = Set<Date>()
    
    func setEvents() {

        for i in 0..<tasks.count {
            let eventDate = tasks[i].scheduleDate
            eventArr.insert(eventDate)
        }
    }
    
}

extension SecondViewController: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    
    // ... 개수
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        
        var j = 0
        
        let tempArr = eventArr.map { DateFormatChange.shared.dateOfYearMonthDay.string(from: $0) }
        let tempArr2 = tempArr.map { DateFormatChange.shared.dateOfYearMonthDay.date(from: $0) }
        
        if tempArr2.contains(date) {
            j = 0
            for i in 0..<tasks.count {
                if tempArr2[i] == date {
                    j += 1
                }
            }
            mainView.calendar.appearance.eventDefaultColor = .systemGray3
            return j
        } else {
            return 0
        }
    }
}
```


1.  eventArr을 Array -> Set으로 변경

2.   기존 eventArr에 yyyy-MM-dd 형태로 Date값을 변환시켜 담았지만 그냥 Realm의 scheduleDate를 그대로 담음
	- 만약 변환시켜서 담으면 day 단위로 중복된게 다 없어지기 때문에 스케쥴 등록이 제대로 안이루어질 것임
	- 때문에 초까지 나오는 ScheduleDate그대로의 값을 담음

3. numberOfEventsFor에서 형변환을 시켜주고 비교후에 ... 의 개수를 리턴시켜줌


이와 같이 만들어주면 viewWillAppear 할 때마다 Set이기 때문에 중복된 값이 추가되지 않아 tasks에 있는 scheduleDate를 그대로  eventArr에 담을 수 있게된다.

그러면 인덱싱을 하는데 문제가 없기 때문에 제대로 달력에 ... 이 찍히게 된다.

처음에 분명 껐다키면 제대로 ... 이 찍혔다고 했는데 왜냐하면 껐다키고 처음으로 화면을 띄우면 setEvents()가 한 번밖에 실행되지 않았기 때문에 제대로 인덱싱이 되어있어 ...이 제대로 나타난 것이였다.

그리고 스케쥴을 추가하고 오면 viewWillAppear에 의해 setEvents()가 실행되고 eventArr에 중복된값들이 추가되어 제대로 나타나지 않은 것이었다.


___

# 220917


## 1. 캘린더 날짜 선택시 스케쥴 테이블뷰에 띄워주기

2Page의 테이블뷰셀에 캘린더에서 선택한 날에 대한 데이터를 나타내고자 했다.

먼저 클릭하면 해당 날짜와 일치한 스케쥴이 잘 출력되는 지 확인 했다.

그런데 출력이 잘 되지 않았다...


### 1-1. 문제발생(인덱싱?)

반복문을 통해 tasks.count만큼 반복해주고 거기에서 선택한 날짜와 형변환 시켜준 날짜가 같으면 해당 인덱스의 tasks를 보여주면 되는식으로 하면 간단하게 나타낼 수 있을거라 생각했다.

```swift
func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
	
	let eventStringArr = eventArr.map { DateFormatChange.shared.dateOfYearMonthDay.string(from: $0) }
	let eventDateArr = eventStringArr.map { DateFormatChange.shared.dateOfYearMonthDay.date(from: $0) }
	
	for i in tasks.count {
		if eventDateArr[i] == date {
			dayEventArr.append(tasks[i].scheduleDate)
		}
	}
	
	mainView.tableView.reloadData()
}
```

위 메소드는 fscalendar에서 지원하는 메소드로 캘린더의 날짜를 입력하면 해당 날의 date와 monthPosition(인덱스)를 반환해준다.

이렇게 하면 분명 인덱스에 맞춰 잘 schedule을 뱉어낼거라고 생각한 내가 바보였다...

왜냐하면 `eventDateArr[i]` 가 선택한 date와 같을 때의 인덱스 i값이 tasks의 인덱스로 쓰이게되는데 그럴 경우 해당날짜와 무조건 같은 스케쥴이 나올 수 없게된다.

왜냐하면 현재 tasks의 구조는 이러하기 때문이다.

<img width="300" alt="스크린샷 2022-09-18 오후 12 31 21" src="https://user-images.githubusercontent.com/92367484/190884938-7e81cd28-c61a-4439-98af-32a6418202a4.png">


날짜에 맞춰 정렬이되어있으면 가능할 거 같았지만 데이터를 넣을 때 반복문으로 넣어서 그런지 fetch를 불러줘도 정렬이 계속 안 되었다...

두 가지 생각을 했었다.

1. Realm을 어떻게든 다시 Date로 정렬해주고 위의 반복문을 통해 나타낸다.
2. Realm에서 filter?를 통해 가져와서 보여준다.



### 1-2. 문제 해결( feat. where )

더 좋은 방법이 뭘까 고민하다가 멘토님을 찾아가 조언을 구하니 반복문을 자제하고 쿼리에서 데이터를 가져오는식으로 하라는 솔루션을 받았다.

그리고 Realm에서 where이라는 좋은 기능?을 발견했다.

참고로 where은 원래 Realm에서 지원을 하지 않았지만 최근에 들어서 지원한 문법이라고 한다!!!

where을 사용해 선택한 date 값이 해당 날의 00:00AM ~ 23:59PM 사이에 있는 값을 나타내면 되겠다 생각했다.

```swift 
class UserScheduleRepository: UserScheduleRepositoryType {
    
    let localRealm = try! Realm()
    
    let calendar = Calendar.current
        
    func dateArr(date: Date) -> Results<UserSchedule> {
        
        return localRealm.objects(UserSchedule.self).where {
            $0.scheduleDate >= calendar.startOfDay(for: date) && $0.scheduleDate < calendar.startOfDay(for: date + 86400)
        }
    }
}
```

`calnedar.startOfDay(for:_)` 메소드는 해당 날의 00:00AM을 나타내주는 함수이다.

때문에 이거보다 date값이 크거나 같고  `calendar.startOfDay(for: date + 86400)`는 다음 날 00:00AM이니까 그것보다 작으면 00:00AM ~ 23:59PM의 범위를 특정할 수 있 게된다.

그러면 클릭한 날의 date 값을 받아 Realm에서 그 날의 schedule, startTime, endTime 등등을 보여줄 수 있게되는 것이다.

그리고 나서 캘린더에 코드를 작성해보면

```swift
func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
	
	// 다시 클릭하면 배열을 비워줘야함(append가 계속되기 때문)
	dayEventArr = []
	
	for i in 0..<repository.dateArr(date: date).count {
		dayEventArr.append(repository.dateArr(date: date)[i].schedule)
	}
	
	mainView.tableView.reloadData()

}
```

클릭시에 dayEventArr 배열에 해당 스케쥴을 담아주게 된다.

이를 그대로 테이블뷰 셀에 뿌려주면 데이터를 제대로 나타낼 수 있다.


___

# 220919

## 0. 개인피드백

- 캘린더에 스케쥴 수행하면 색 표시
- 삭제 기능(테이블뷰) -> 언제 어떻게 얼마나 지울지 생각해보기
- 겹치는 시간 등록 X
- 백그라운드 상태에서 체크
- 퍼즈기능
- 이미 시간이 지났으면 셀 삭제 불가하게


## 1. 팀빌딩

tableViewDelegate, tableViewDataSource 즉 델리게이트패턴 쪽은 최대한 가볍게 처리하는게 좋다.

왜냐하면 뷰를 그릴 때 cellForRowAt 같은 경우 row가 하나 생길 때마다 안에있는 코드들을 반복하기 때문이다.


### 1-1. 내가 막힌 부분

컬렉션뷰를 사용해 이번 달 총 수행한 스케쥴의 개수를 나타내고 싶어서 수행한 스케쥴(true)인 부분을 필터로 가져와 배열에 담고 딕셔너리로 처리하고자했는데 값이 중복된 부분을 어떻게 처리해줘야할지 모르겠다.

-> reduce를 활용해보라는 피드백을 받음


## 2. Collection View에 데이터 띄워주기

<img width="300" alt="스크린샷 2022-09-19 오후 3 04 44" src="https://user-images.githubusercontent.com/92367484/190958044-d3af8d8d-e293-46dd-87ee-4879d8f7a702.png">

다음과 같이 컬렉션 뷰에 스케쥴과 수행횟수를 나타내주고 싶었습니다.

수행한 스케쥴이기 때문에 가장먼저 Realm에서 Success여부가 true인 것을 필터해서 가져왔습니다.

```swift
func successSchedule() -> Results<UserSchedule> {
	return localRealm.objects(UserSchedule.self).filter("scheduleSuccess == true")
}
```

이렇게하면 `["운동", "운동","운동", "공부", "공부", "독서"]` 이런식으로 배열에 담을 수 있게됩니다.

그리고 스케쥴, 횟수가 짝지어져 있기 때문에 이를 딕셔너리로 나타내고자했습니다.


### 2-1. ❎문제발생❎

반복문을 통해 스케쥴을 담았기 때문에 스케쥴들이 서로 섞일 수가 없는 구조입니다.

때문에 반복문을 통해 앞의 인덱스와 현재 인덱스를 비교한 후 같으면 value를 1씩 추가해주는 식으로 딕셔너리를 나타내려고 시도했습니다.

```swift
var j = 1

for i in 0..<repository.successSchedule().count {
	if tempArr[i] == tempArr[i+1] {
		j += 1
	} else {
		scheduleCountDic.updateValue(j, forKey: repository.successSchedule()[i].schedule)
	}
}
```

이런식으로 접근을 했습니다. 하지만 이렇게하면 해당배열의 크기보다 +1 더 큰 경우와 비교해야하는데 그렇게되면 index out of range 오류가 발생하게 됩니다...

그리고 이렇게 반복문을 통해 접근하는게 별로 바람직한 생각이 아니라고 들었습니다... ( 쿼리에서 가져오라는 멘토님의 조언이... 떠올랐습니다!!!)


### 2-2. ✅ 문제해결

```swift
for i in 0..<repository.successSchedule().count {
	scheduleCountDic.updateValue(i+1, forKey: repository.successSchedule()[i].schedule)
	print(repository.successSchedule()[i].schedule)
}

// ["강아지", "강아지", "강아지", "고양이", "악어", "악어"]
// ["강아지":3, "고양이":4, "악어":6] 으로 딕셔너리가 업데이트됨
```

위의 코드를 활용해서 어떻게 해결해보자는 어리석은... 생각을 계속하고 있었습니다.

대입은 되지만 배열의 아이템 개수에 맞춰 value가 업데이트 되지 않지만 어떻게 손을 보면 제대로 넣을 수 있을거라 생각했기 때문에...

이 땐 Realm에 필터를 거는데는 무조건 상수??만 될 거라고 생각을 했습니다...(왜지?...) 다 filter처리를 " "안에서만 해줘서 그랬나봐요 ㅠㅠ

하지만 filter에도 매개변수를 넣어 해당 값을 불러올 수 있다는 이야기를 팀원에게 들었습니다...

그러면 해당스케쥴의 키값과 키에맞는 value를 쿼리에서 필터를 통해 가져올 수 있다는 이야기죠...

```swift
func successScheduleNumber(key: String) -> Results<UserSchedule> {
	return localRealm.objects(UserSchedule.self).filter("scheduleSuccess == true AND schedule == '\(key)'")
}
```

바로 scheduleSuccess가 true임과 동시에 스케쥴이 키값과 같은 경우의 쿼리를 리턴해주는 메소드를 만들었습니다.

```swift
for i in 0..<repository.successSchedule().count {
	scheduleCountDic.updateValue(repository.successScheduleNumber(key: repository.successSchedule()[i].schedule).count, forKey: repository.successSchedule()[i].schedule)
}
```

그 다음 딕셔너리에 키값과 밸류를 담아주었습니다.

마지막으로 많이 성공한 스케쥴을 순서대로 보여주고 싶어 정렬을 해준 뒤 셀에 나타내줬습니다.

```swift
func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

	// value의 크기대로 딕셔너리 정렬
	let sortedScheduleCountDic = scheduleCountDic.sorted { (first, second) in
		return first.value > second.value
	}

	guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SecondCollectionViewCell.reuseIdentifier, for: indexPath) as? SecondCollectionViewCell else {
		return UICollectionViewCell()
	}

	// 정렬된 딕셔너리에 맞춰 cell에 값 넣어주ㄱ
	cell.scheduleLabel.text = sortedScheduleCountDic[indexPath.item].key
	cell.numberOfScheduleLabel.text = "\(sortedScheduleCountDic[indexPath.item].value)"

	return cell
}
```

___

# 220920


## 0. 팀빌딩

Date값으로 Realm에 저장을하면 그리니치천문대기준(UTC)로  저장된다.

그래서 저는 한국과 시차가 9시간이여서 9시간을 더해서 한국시간으로 맞춰 더해주었다. (Realm에도 한국시간으로 맞춰 저장됨)


### 피드백 
1. Realm에 한국 시간으로 맞춰 저장해버리면 다른 국가에서 사용할 때 시간 조정이 어렵지 않을까요??
2. timezone을  사용해서 맞춰 보세요!!!(String으로 바꾸어저장)


### 내 생각
- 이벤트를 추가할 때 Date값을 기준으로 86400을 더해서 반복문으로 넣어줬는데 그럼 Date를  String으로 저장한다면 또 어떻게 맞춰가야할까???


## UTC Date To KST Date(UTC에서 KST Date값으로 변환하는 함수)
```swift
func changeToSystemTimeZone(_ date: Date, from: TimeZone, to: TimeZone = TimeZone.current) -> Date {
    let sourceOffset = from.secondsFromGMT(for: date)
    let destinationOffset = to.secondsFromGMT(for: date)
    let timeInterval = TimeInterval(destinationOffset - sourceOffset)
    return Date(timeInterval: timeInterval, since: date)
}

let myTime = "2019-11-02 02:00:00"
let dateFormatter = DateFormatter()
dateFormatter.locale = Locale(identifier: "en_US_POSIX")
dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

if let date = dateFormatter.date(from: myTime), let timeZone = TimeZone(abbreviation: "UTC") {
    let offsetedDate = changeToSystemTimeZone(date, from: timeZone)
    print(date, Calendar.current.timeZone)
    print(offsetedDate, timeZone)
}

let realmTime = Date.now
print(realmTime)

let utcSecondsFromGMT = TimeZone(abbreviation: "UTC")!.secondsFromGMT(for: realmTime)
let kstSecondsFromGMT = TimeZone(abbreviation: "KST")!.secondsFromGMT(for: realmTime)
let secondsBetweenUTCAndKST = TimeInterval(kstSecondsFromGMT - utcSecondsFromGMT)
let realmTimeToKST = Date(timeInterval: secondsBetweenUTCAndKST, since: realmTime)
print(realmTimeToKST)
```



## 1. 테이블뷰에 스케쥴 제대로 띄워주기(삽질)

제가 삽질했던?! 내용은 대략적으로 이러합니다...

FSCalendar에서 날짜를 클릭하면 해당 날짜의 범위에 있는 Realm 값을 필터링해서 dayTasks에 담고 나타내주는 것이었습니다.

필터링을 할 때 

```swift
func filterDayTasks(date: Date) -> Results<UserSchedule> {
	
	return localRealm.objects(UserSchedule.self).where {
		$0.scheduleDate >= calendar.startOfDay(for: date) && $0.scheduleDate < calendar.startOfDay(for: date)  + 86400
	}
}
```

다음과 같이 클릭한 date를 받아와서 필터링 해주었습니다...

클릭한 날짜는 무조건 UTC기준으로 당일 15:00로 주었고 `calendar.startOfDay(for:Date)` 는 해당 날의 00:00을 나타내주기 때문에 +86400을 하면 다음 날 00:00을 특정할 수 있고 그것보다 작으면 00:00~23:59를 특정할 수 있게됩니다.

하지만 `calendar.startOfDay(for:Date)` 는 UTC기준으로 나타내주기 때문에 한국시간보다 9시간 느렸습니다. 즉 한국시간으로 자정이면 15:00으로 인식되는 것이죠.


### 1-1. 삽질(뻘 짓)의 시작...

왜인지 모르겠지만 당시 Realm을 봤을 때 날짜와 비교해봤을 때 테이블뷰에 이상한 데이터를 띄워준다고 착각했습니다.

오늘기준으로 다음 날부터 월말까지 정해진 요일에 스케쥴이 등록되는데 Date는 당연히 UTC 값으로 들어가겠죠... 그러면 Date 컬럼으의 데이터가 한국시간하곤 안 맞지만 제대로 정한 요일에 등록이 됐을거에요...

그런데 어? 하루가밀렸네 착각하고... 이를 한국시간에 맞춰주려고 했습니다...

```swift
var now = Date() + 86400 + 3600 * 9

func filterDayTasks(date: Date) -> Results<UserSchedule> {
	
	return localRealm.objects(UserSchedule.self).where {
            $0.scheduleDate >= calendar.startOfDay(for: date) + 3600 * 9 && $0.scheduleDate < calendar.startOfDay(for: date) + 86400 + 3600 * 9
	}
}

```

9시간 차이가 나니까 범위를 한국시간 기준으로 00:00 ~ 23:59 맞추고 now의 값도 한국시간을 기준으로 맞춰줬습니다.

굳이 이렇게 해 주지 않아도 잘 데이터가 들어가는데 제가 착각을 한 거죠... UTC로 등로된 Date 값을 보고 캘린더엔 KST로 등록된 걸 비교하니까... 값이 안맞지 ㅠㅠ...

저렇게 한국시간을 기준으로 맞춰도 데이터가 잘 나오긴 하는데... 나중에 국제대응 하거나 다국화??? 시킬 때 분명 좋은 방법이 아닐거 같아 처음으로 되돌렸습니다...


## 2. 스와이프 삭제기능

테이블뷰에서 스와이프시 삭제기능을 넣었습니다.

<img width="250" alt="스크린샷 2022-09-21 오전 2 03 55" src="https://user-images.githubusercontent.com/92367484/191320460-b6c8161a-7d44-4f58-85dc-343cf556c60a.png">

제가 생각한 방법은 다음과 같습니다.

1. 클릭시에 나오는 필터링된 daytasks를 가져온다.
2. 삭제한다.
3. 컬렉션뷰 업데이트(true인 셀을 지웠을 수도 있기 때문)

```swift
// In UserScheduleRepository
func filterDayTasks(date: Date) -> Results<UserSchedule> {
	
	return localRealm.objects(UserSchedule.self).where {
		$0.scheduleDate >= calendar.startOfDay(for: date) && $0.scheduleDate < calendar.startOfDay(for: date)  + 86400
	}
}

// In SecondViewController
// 스와이프시 삭제 
func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
	
	if editingStyle == .delete {
		repository.delete(item: dayTasks?[indexPath.row])
	}
	
	// 셀삭제하면 컬렉션뷰에 나타난 count 업데이트
	for i in 0..<repository.successSchedule().count {
		scheduleCountDic.updateValue(repository.successScheduleNumber(key: repository.successSchedule()[i].schedule).count, forKey: repository.successSchedule()[i].schedule)
	}
	
	self.fetchRealm()
}

// 선택시 dayTasks에 선택한 날 데이터 필터링해주는 함수
func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
	
	selectedDate = date
	
	scheduleInfo = []
	
	dayTasks = repository.filterDayTasks(date: date)
	self.fetchRealm()

	mainView.tableViewHeaderLabel.text = DateFormatChange.shared.dateOfMonth.string(from: date)
}
```

___

# 220921


## 1. FSCalendar 오류?

특정 날을 찍으면 잠깐 다른 날에서 깜빡깜빡 거리는 현상이 발생했습니다.

https://user-images.githubusercontent.com/92367484/191509176-178cdfe5-244e-467f-80e1-7dde14892785.mp4

고민하던 중 reloadData 시점에서 무언가 문제가 있지 않았을까? 생각헀습니다.

그래서 이 부분을 수정해주었습니다.

```swift
var tasks: Results<UserSchedule>! {
	didSet {
		dayTasks = repository.filterDayTasks(date: selectedDate)
		mainView.tableView.reloadData()
		mainView.collectionView.reloadData()
//      mainView.calendar.reloadData()
	}
}
```

그랬더니 깜빡거리는 오류?가 사라졌습니다.

https://user-images.githubusercontent.com/92367484/191509997-3a593b10-b0d3-4e50-9316-96f464f54434.mp4

그런데 이렇게 하 경우 셀을 삭제할 때 캘린더의 ...이 초기화가 안 됩니다.

task가 변할경우 `calendar.reloadData()` 가 안 되기 떄문이죠...

그래서 셀을 삭제해 줄 때 `calendar.reloadData()` 를 해줍니다.

```swift
func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
	
	if editingStyle == .delete {
		repository.delete(item: dayTasks?[indexPath.row])
	}
	
	// 셀삭제하면 컬렉션뷰에 나타난 count 업데이트
	for i in 0..<repository.successSchedule().count {
		scheduleCountDic.updateValue(repository.successScheduleNumber(key: repository.successSchedule()[i].schedule).count, forKey: repository.successSchedule()[i].schedule)
	}
	
	mainView.calendar.reloadData()
	self.fetchRealm()
}
```



## 2. 타이머 중단기능 추가

기존 취소 시작 버튼밖에 없었던 TimerView에 멈추는 기능을 추가해줬습니다.


<img width="200" alt="스크린샷 2022-09-22 오전 12 43 54" src="https://user-images.githubusercontent.com/92367484/191550185-ae0bcccf-2df0-4d4f-8643-bb7ab184a887.png">


### 2-0. ❎주의사항❎

타이머는 한 번 실행되면 계속 돌아가기 때문에 사용이 끝나면 반드시 invalidate를 처리해주어야합니다.


### 2-1. 고민했던 지점

- 시간이 짧을 경우 끊겨서 보이는현상

https://user-images.githubusercontent.com/92367484/191554374-73b85dad-1558-4042-bc32-ee23f51fba2a.mp4


### 2-2. 해결

사실 타이머를 멈추는 기능은 `timer?.invalidate()`  코드만 작성해주면 되어서  간단했지만 시간이 짧을 경우 프로그레스바가 끊겨서 보이는 현상이 발생했습니다.

이를 해결하기위해 leftTime을 Double형으로 바꾸고 0.01초마다 프로그레스바가 갱신될 수 있도록 해주었습니다.

```swift
timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { (t) in
	
	self.leftTime -= 0.01
	
	let minute = Int(self.leftTime) / 60
	let second = Int(self.leftTime) % 60
	
	if self.leftTime > 0 {
		self.timeLabel.text = String(format: "%02d:%02d", minute, second)
		self.progress = Double(self.leftTime) / Double(self.x)
		self.timerView.start(duration: 0.0001 , value: 1.0 - self.progress)
	} else {
		// 완료시 노티주기
		self.callNotification(time: 1, title: "미션 완료!!!", body: "다음 미션도 완수해주세요~~\n다 마치셨다면 당신은 멋쟁이!!!")
		
		self.timeLabel.text = "끝!"
		self.okButton.layer.borderColor = UIColor.systemOrange.cgColor
		self.okButton.backgroundColor = .systemOrange
		self.okButton.isUserInteractionEnabled = true
		self.pauseAndPlayButton.isUserInteractionEnabled = false
		self.timer?.invalidate()
	}
})
```

https://user-images.githubusercontent.com/92367484/191554436-4f154f62-85a1-4f95-8314-56b9bf9880b7.mp4


___

# 220922

## 1. CollectionView 달에 따라 현황 보여주기

기존 컬렉션 뷰는 ScheduleSuccess여부가 true인 값만 필터링을 해와서 달에 상관없이 성공한 스케쥴이라면 모두 나타나게 되어있었다.(9월인데도 10월 11월 스케쥴 나타남)

```swift
// In UserScheduleRepository
func successSchedule() -> Results<UserSchedule> {
	return localRealm.objects(UserSchedule.self).filter("scheduleSuccess == true")
}
```


### 1-1. 달의시작, 다음 달 구하기

```swift
let calendar = Calendar.current
print("calendar : \(calendar)") // calendar : gregorian (current)

let date = Date()
print("date : \(date)") // date : 2022-09-22 08:16:25 +0000

let components = calendar.dateComponents([.year, .month], from: date)
print("components : \(components)") // components : year: 2022 month: 9 isLeapMonth: false

// components에 day를 기입하지 않았기 때문에 components를 date로 바꿔주면 달의 첫번째 날이 나옴
let startOfMonth = calendar.date(from: components)
print("startOfMonth : \(startOfMonth!)") // startOfMonth : 2022-08-31 15:00:00 +0000

// value의 값에 따라 1달, 2달이 늘어나게됨
let nextMonth = calendar.date(byAdding: .month, value: +0, to: startOfMonth!)
print("nextMonth : \(nextMonth!)") // nextMonth : nextMonth : 2022-08-31 15:00:00 +0000

let nextMonth2 = calendar.date(byAdding: .month, value: +1, to: startOfMonth!)
print("nextMonth2 : \(nextMonth2!)") // nextMonth2 : 2022-09-30 15:00:00 +0000
```


### 1-2. 딕셔너리에 담아주기

```swift
// In UserScheduleRepository
func successScheduleInMonth(currentDate: Date) -> Results<UserSchedule> {

	let nextMonth = calendar.date(byAdding: .month, value: +1, to: currentDate)

	return localRealm.objects(UserSchedule.self).where {
		$0.scheduleSuccess == true && $0.scheduleDate >= currentDate && $0.scheduleDate < nextMonth!
	}
}

func successScheduleNumber(key: String) -> Results<UserSchedule> {
	return localRealm.objects(UserSchedule.self).filter("scheduleSuccess == true AND schedule == '\(key)'")
}

// In SecondViewController
var scheduleInfo = [scheduleInfoModel]()
var date = Date()

override func viewWillAppear(_ animated: Bool) {
	super.viewWillAppear(animated)
	
	let components = calendar.dateComponents([.year, .month], from: date)
	let startOfMonth = calendar.date(from: components)!
	
	
	// 컬렉션뷰 업데이트
	for i in 0..<repository.successScheduleInMonth(currentDate: startOfMonth).count {
		scheduleCountDic.updateValue(repository.successScheduleNumber(key: repository.successScheduleInMonth(currentDate: startOfMonth)[i].schedule).count, forKey: repository.successScheduleInMonth(currentDate: startOfMonth)[i].schedule)
	}
}

```

제가 해줘야하는 것은 컬렉션뷰에 이번 달 성공한 스케쥴 + 성공횟수 였습니다.

때문에 이번 달 성공한 스케쥴과 성공횟수를 DB에서 가져와 주는 것이 주요쟁점 이었습니다.

먼저 오늘날짜인 date를 기준으로 startOfMonth(월의 가장 첫날)을 가져와주고 첫 날을 기준으로 `successScheduleInMonth(currentDate: Date) -> Results<UserSchedule>` 메소드를 통해 nextMonth(다음 달 첫 날)을 특정해 그 값을 반환시켜줍니다.

그러면 성공한 스케쥴을 모두 가져올 수 있게 되는 것이죠.

그리고 나면 성공한 스케쥴이 각각 몇 번씩 인지를 가져와줘야겠죠?

이 때 저는 `successShceduleNumber(key: String) -> Results<UserSchedule>` 메소드를 통해 성공한 스케쥴 + 스케쥴 이름을 키값으로 받아와서 각각의 스케쥴이 몇 번 성공했는지 가져왔습니다.

그리고 for문을 통해 성공한 스케쥴의 개수만큼 반복해서 성공한스케쥴의 개수를 value에 성공한 스케쥴을 key값으로 담아 주었습니다.


### 1-3. 캘린더 스와이프시 값 변경

스와이프 시(달이 변경될 때) 각각의 달의 성공 횟수를 컬렉션뷰로 보여주어야 했습니다.

이 때 FSCalendar의 delegate패턴의 `calendarCurrentPageDidChange(_ calendar: FSCalendar)` 메소드를 활용했습니다.

```swift
func calendarCurrentPageDidChange(_ calendar: FSCalendar) {


	// 현재 달력 페이지의 첫 날 값을 가져옴
	let currentPageDate = calendar.currentPage
	let month = Calendar.current.component(.month, from: currentPageDate)
	
	scheduleCountDic = [:]
	successCount = 0
	
	// 스와이프시 date값을 변경시켜야 다른 페이지를 갔다와도 해당 월의 스케쥴 성공여부가 컬렉션뷰에 잘 나옴
	date = currentPageDate
	
	for i in 0..<repository.successScheduleInMonth(currentDate: currentPageDate).count {
		scheduleCountDic.updateValue(repository.successScheduleNumber(key: repository.successScheduleInMonth(currentDate: currentPageDate)[i].schedule).count, forKey: repository.successScheduleInMonth(currentDate: currentPageDate)[i].schedule)
	}
	
	mainView.collectionViewHeaderLabel.text = "\(month)월 미션 현황"
			
	// 캘린더 스와이프시에 테이블뷰 숨기기
	mainView.tableView.isHidden = true

	mainView.collectionView.reloadData()
}
```

스와이프 할 때마다 scheduleCountDic을 비워주고 다시 해당 월의 값을 받아 값을 채워주어 컬렉션뷰에 나타내 줍니다.

https://user-images.githubusercontent.com/92367484/194487347-25a117d5-a30e-4c16-9dea-49d48c2dc40f.MP4


# 220923

## 1. 셀 수정

셀 수정에서 제가 고려한 부분은 이미 지나간 스케쥴의 경우 수정이 불가하게 막는 것이었습니다. 

한 달간 계획을 챌린지하게 세우는데 성공했던 스케쥴이나 실패했던 스케쥴을 수정가능하게 두면 안 되기 때문입니다.

### ❎ 주의사항 ❎

모달은 ViewWillAppear시점이 통하지 않기 때문에 클로져로 값 전달 후 값을 수정한다.

클로저, 노티피케이션, 프로토콜을 이용해 값 전달을 할 때에는  모달, 푸시앤팝 등으로 다음화면과 전 화면을 특정할 수 있어야 값 전달이 제대로 이루어진다.


### 1-1. 클로저를 이용한 값 전달

#### 1) 값 전달받을 뷰컨트롤러에서 클로저 선언
```swift
// In ChangeScheduleViewController
final class ChangeScheduleViewController: BaseViewController {
	// 1. 실행될 빈 클로저 선언
	var okButtonActionHandler: ( () -> Void )?
}
```

#### 2) 클로저 함수 정의
```swift
// In SecondViewController
func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
	let vc = ChangeScheduleViewController()
	
	// 지나간 날짜 + 현재 시간 기준 오전9시가 넘으면 수정 불가
	// 1. scheduleDate와 오늘 날짜가 같음
	// 2. 오전 9시 ~ 24시까지 사이엔 수정 불가
	
	if dayTasks[indexPath.row].scheduleSuccess == true {
		showAlertOnlyOk(title: "완료한 스케쥴은 수정할 수 없습니다")
	} else {
		if dayTasks[indexPath.row].scheduleDate < calendar.startOfDay(for: now) ||
			DateFormatChange.shared.dateOfYearMonthDay.string(from: dayTasks[indexPath.row].scheduleDate) == DateFormatChange.shared.dateOfYearMonthDay.string(from: now) &&
			(now > calendar.startOfDay(for: now) + 32400 && now < calendar.startOfDay(for: now) + 86400 ) {
			
			showAlertOnlyOk(title: "지난 일정은 수정할 수 없습니다")
		} else {
			
			// 2. 클로저 함수 정의
			vc.okButtonActionHandler = {
				self.mainView.tableView.reloadData()
			}
			
			let nav = UINavigationController(rootViewController: vc)
			present(nav, animated: true)
		}
	}
}
```


#### 3) 전달받은 클로저 실행

```swift
// In ChageScheduleViewController
@objc func okButtonClicked() {
	
	guard let setStartTimeButtonDate = DateFormatChange.shared.dateOfHourAndPM.date(from: mainView.setStartTimeButton.titleLabel?.text ?? "") else { return }
	
	guard let setEndTimeButtonDate = DateFormatChange.shared.dateOfHourAndPM.date(from: mainView.setEndTimeButton.titleLabel?.text ?? "") else { return }
	
	if mainView.setScheduleTextField.text?.count == 0 {
		showAlertOnlyOk(title: "미션을 입력해주세요")
	} else if mainView.setStartTimeButton.titleLabel?.text == mainView.setEndTimeButton.titleLabel?.text {
		showAlertOnlyOk(title: "시작시간과 종료시간은\n같을 수 없습니다\n다른 시간을 선택해주세요")
	} else if setStartTimeButtonDate > setEndTimeButtonDate {
		self.showAlertOnlyOk(title: "시작시간은 종료시간보다 빨라야합니다\n종료시간을 다시 선택해주세요")
	} else {
		
		// 렘 수정
		repository.updateSchedule(objectID: objectID!, startTime: self.mainView.setStartTimeButton.titleLabel?.text ?? "", endTime: self.mainView.setEndTimeButton.titleLabel?.text ?? "", schedule: self.mainView.setScheduleTextField.text!)

		// 3. 클로저실행
		okButtonActionHandler?()

		dismiss(animated: true)
	}
}
```


## 2. 셀 삭제

셀 삭제에서 제가 고려한 부분은 이미 날짜가 지나간 셀은 삭제가 불가능하게 하는 것이었습니다.

왜냐하면 이미 지나간 스케쥴을 삭제하게 만들면 후에 통계를 낼 때 조작이 될 수 있기 때문입니다.

그래서 이와같이 예외처리를해서 코드를 짰습니다.

```swift
func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
	 
	if dayTasks[indexPath.row].scheduleSuccess == true {
		showAlertOnlyOk(title: "완료한 스케쥴은 삭제할 수 없습니다")
	} else {
		if dayTasks[indexPath.row].scheduleDate < calendar.startOfDay(for: now) + 86400 {
			showAlertOnlyOk(title: "지난 일정이나 당일 일정은 삭제할 수 없습니다.")
		} else {
			if editingStyle == .delete {
				repository.delete(item: dayTasks?[indexPath.row])
			}
			
			mainView.calendar.reloadData()
			self.fetchRealm()
		}
	}
}
```


# 220924

## 1. 캘린더에 스케쥴 & 수행여부 dot으로 표현

캘린더에 유저가 스케쥴을 몇 개 등록했고 몇 개 수행했는지를 달력에 표시해주기 위해 FSCalendar에서 제공하는 event를 사용하기로 했습니다.

FSCalendar는 날짜를 선택하면 eventSelectionColor로 바뀌기 때문에 선택시에도 eventColor를 일치시켜 주어야 합니다.

```swift
enum EventDotColor {
    static let successZeroTime = [UIColor.systemGray4, UIColor.systemGray4, UIColor.systemGray4]
    static let successOneTime = [UIColor.successColor, UIColor.systemGray4, UIColor.systemGray4]
    static let successTwoTime = [UIColor.successColor, UIColor.successColor, UIColor.systemGray4]
    static let successThreeTime = [UIColor.successColor, UIColor.successColor, UIColor.successColor]
}

extension SecondViewController: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    
    // ... 개수
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {

        let eventStringArr = eventArr.map { DateFormatChange.shared.dateOfYearMonthDay.string(from: $0) }
        let eventDateArr = eventStringArr.map { DateFormatChange.shared.dateOfYearMonthDay.date(from: $0) }
                
        if eventDateArr.contains(date) {
            switch repository.filterDayTasks(date: date).count {
            case 0:
                return 0
            case 1:
                return 1
            case 2:
                return 2
            case 3:
                return 3
            default:
                return 3
            }
        } else {
            return 0
        }
    }
    
    // ... 색
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventDefaultColorsFor date: Date) -> [UIColor]? {
        
        dayTasksAndSuccess = repository.filterDayTasksAndSuccess(date: date)
        
        switch dayTasksAndSuccess.count {
        case 0:
            return EventDotColor.successZeroTime
        case 1:
            return EventDotColor.successOneTime
        case 2:
            return EventDotColor.successTwoTime
        case 3:
            return EventDotColor.successThreeTime
        default:
            return EventDotColor.successThreeTime
        }
    }

	// 선택시 ... 색
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventSelectionColorsFor date: Date) -> [UIColor]? {

        switch dayTasksAndSuccess.count {
        case 0:
            return EventDotColor.successZeroTime
        case 1:
            return EventDotColor.successOneTime
        case 2:
            return EventDotColor.successTwoTime
        case 3:
            return EventDotColor.successThreeTime
        default:
            return EventDotColor.successThreeTime
        }
    }
}
```


## 2. 오류수정

시간선택시 텍스트 기준("시간선택" 텍스트를 조건문으로 처리)으로 처리해서 수정시에 "시간선택"이 아니라 기존의 시간이 등록되어 있어 오류가 발생했습니다.

```swift
// 기존 코드

// In ChangeScheduleViewController

// 시작시간 선택버튼
@objc func setStartTimeButtonClicked(sender: UIDatePicker) {
        
	let ok = UIAlertAction(title: "확인", style: .default) { (action) in
		
		let dateString = DateFormatChange.shared.dateOfHourAndPM.string(from: datePicker.date)
		self.setStartTimeDatePickerDate = datePicker.date
		
		if self.mainView.setEndTimeButton.titleLabel?.text == dateString {
			self.showAlertOnlyOk(title: "시작시간과 종료시간은\n같을 수 없습니다\n다른 시간을 선택해주세요")
		} else if self.setEndTimeDatePickerDate! > self.setEndTimeDatePickerDate! {
			self.showAlertOnlyOk(title: "시작시간은 종료시간보다 빨라야합니다\n종료시간을 다시 선택해주세요")
		} else if self.calendar.component(.hour, from: datePicker.date) > 3 && self.calendar.component(.hour, from: datePicker.date) < 9 {
			self.mainView.setStartTimeButton.setTitle(dateString, for: .normal)
			self.mainView.setStartTimeButton.setTitleColor(.systemBlue, for: .normal)
		} else {
			self.showAlertOnlyOk(title: "오전 4시부터 오전9시까지만 시간설정이 가능합니다")
		}
	}
}


// 종료시간 선택버튼
@objc func setEndTimeButtonClicked() {
	
	let ok = UIAlertAction(title: "확인", style: .default) { (action) in
	
		let dateString = DateFormatChange.shared.dateOfHourAndPM.string(from: datePicker.date)
		self.setEndTimeDatePickerDate = datePicker.date
		
		if self.mainView.setStartTimeButton.titleLabel?.text == "시간선택" {
			self.showAlertOnlyOk(title: "시작시간을 먼저 선택해주세요")
		} else if self.mainView.setStartTimeButton.titleLabel?.text == dateString {
			self.showAlertOnlyOk(title: "시작시간과 종료시간은\n같을 수 없습니다\n다른 시간을 선택해주세요")
		} else if self.setStartTimeDatePickerDate! > self.setEndTimeDatePickerDate! {
			self.showAlertOnlyOk(title: "시작시간은 종료시간보다 빨라야합니다\n종료시간을 다시 선택해주세요")
		} else {
			if self.calendar.component(.hour, from: datePicker.date) > 3 && self.calendar.component(.hour, from: datePicker.date) < 9 {
				self.mainView.setEndTimeButton.setTitle(dateString, for: .normal)
				self.mainView.setEndTimeButton.setTitleColor(.systemBlue, for: .normal)
			} else {
				self.showAlertOnlyOk(title: "오전 4시부터 오전9시까지만 시간설정이 가능합니다")
			}
		}
	}
}
```


```swift
// 수정된코드
@objc func setStartTimeButtonClicked(sender: UIDatePicker) {
	
	let ok = UIAlertAction(title: "확인", style: .default) { (action) in
		
		let dateString = DateFormatChange.shared.dateOfHourAndPM.string(from: datePicker.date)
		self.setStartTimeDatePickerDate = datePicker.date
		
		if self.calendar.component(.hour, from: datePicker.date) > 3 && self.calendar.component(.hour, from: datePicker.date) < 9 {
			self.mainView.setStartTimeButton.setTitle(dateString, for: .normal)
			self.mainView.setStartTimeButton.setTitleColor(.systemBlue, for: .normal)
		} else {
			self.showAlertOnlyOk(title: "오전 4시부터 오전9시까지만 시간설정이 가능합니다")
		}
	}
}

@objc func setEndTimeButtonClicked() {
	
	let ok = UIAlertAction(title: "확인", style: .default) { (action) in
	
		let dateString = DateFormatChange.shared.dateOfHourAndPM.string(from: datePicker.date)
		self.setEndTimeDatePickerDate = datePicker.date
		
		if self.mainView.setStartTimeButton.titleLabel?.text == self.mainView.setEndTimeButton.titleLabel?.text {
			self.showAlertOnlyOk(title: "시작시간과 종료시간은\n같을 수 없습니다\n다른 시간을 선택해주세요")
		} else {
			if self.calendar.component(.hour, from: datePicker.date) > 3 && self.calendar.component(.hour, from: datePicker.date) < 9 {
				self.mainView.setEndTimeButton.setTitle(dateString, for: .normal)
				self.mainView.setEndTimeButton.setTitleColor(.systemBlue, for: .normal)
			} else {
				self.showAlertOnlyOk(title: "오전 4시부터 오전9시까지만 시간설정이 가능합니다")
			}
		}
	}
}
```


# 220926

## 1. 날짜를 누르고 스와이프를 계속하면 오류발생

<img width="669" alt="스크린샷 2022-09-25 오전 11 50 13" src="https://user-images.githubusercontent.com/92367484/194553850-5c031e10-e674-490f-a1e7-6dbca667a9d1.png">


```swift
func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventSelectionColorsFor date: Date) -> [UIColor]? {

	var successCount = 0

	dayTasks = repository.filterDayTasks(date: date)

	for i in 0..<dayTasks.count {
		if dayTasks[i].scheduleSuccess == true {
			successCount += 1
		}
	}

	
	switch successCount {
	case 0:
		return EventDotColor.successZeroTime
	case 1:
		return EventDotColor.successOneTime
	case 2:
		return EventDotColor.successTwoTime
	case 3:
		return EventDotColor.successThreeTime
	default:
		return EventDotColor.successThreeTime
	}
}
```

찾아보니 캘린더에 점을 찍는 지점에서 인덱스 오류가 나고있었다. 

로직은 분명 맞는데 왜 인덱싱이 계속 랜덤으로 바뀌어 오류가 발생하는걸까...

답은 여기에있었다.

```swift
// 캘린더 날짜 선택
func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
	
	selectedDate = date
	scheduleInfo = []

// 날짜 선택시 dayTasks 현재 날짜에 있는 거만 필터링 시켜주기(테이블뷰에 나타내주기 위해)
//   dayTasks = repository.filterDayTasks(date: date)
	self.fetchRealm()

	mainView.tableViewHeaderLabel.text = DateFormatChange.shared.dateOfMonth.string(from: date)
	
	// 캘린더 스와이프시에 테이블뷰 나타내기
	mainView.tableView.isHidden = false
}
```

날짜를 선택하면 그 날짜에 속한 데이터를 테이블뷰로 보여주기위해 다음과 같은 코드를 작성했다.

하지만 이렇게 되면 캘린더를 선택할 때도 dayTasks가 초기화되고 처음에 ...에 색을 부여하기 위해 dayTasks를 초기화 시키게 된다.

즉 뷰를 띄우면 처음 `eventSelectionColorsFor`가 실행되어 dayTasks가 초기화되고 셀을 선택하면 `didSelect`가 실행되어 dayTasks가 실행되기 때문에 충돌이 발생하게 됐다.(어쩐지 날짜선택안하고 스와이프 하면 오류가 안 발생했었다...)

그래서 `didSelect`시에 dayTasks를 초기화 시켜주는 부분은 삭제하고 제일 처음 뷰를 띄울 때 `eventSelectionColorsFor`에만 dayTasks를 초기화 시켜주도록 했다.

### 다시 오류 발생...

 잘 되다가 또 안된다... 이유가 뭘까??

스와이프시에 dayTasks를 안맞춰 주어서 그런가???

print를 찍어봤는데 매 번 successCount가 스와이프시마다 바뀌는 걸 확인할 수 있었다...

이게 중요한게 성공횟수를 나타내주고 그에 따라 점에 색을 채워주는 건데... 그러면 이게 문제인걸까?


### ✅ 해결 ✅

successCount를 반복문으로 가져오는 것은 생각해보니... 그렇게 좋은 방법은 아닌거같다.

그래서 Realm을 통해 해당일의 스케쥴 성공한 값을 필터링해서 가져와서 나타내고자 시도했다.

```swift
// In UserScheduleRepository
func filterDayTasksAndSuccess(date: Date) -> Results<UserSchedule> {
	return localRealm.objects(UserSchedule.self).where {
		$0.scheduleDate >= calendar.startOfDay(for: date) && $0.scheduleDate < calendar.startOfDay(for: date)  + 86400 && $0.scheduleSuccess == true
	}
}

// In SecondViewController
var dayTasksAndSuccess: Results<UserSchedule>!

// In Calendar + Delegate
func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventDefaultColorsFor date: Date) -> [UIColor]? {
	
	dayTasksAndSuccess = repository.filterDayTasksAndSuccess(date: date)
	
	switch dayTasksAndSuccess.count {
	case 0:
		return EventDotColor.successZeroTime
	case 1:
		return EventDotColor.successOneTime
	case 2:
		return EventDotColor.successTwoTime
	case 3:
		return EventDotColor.successThreeTime
	default:
		return EventDotColor.successThreeTime
	}
}
```

dayTasks가 아니라 Realm을 통해 필터링을 해주니 오류가 해결되었다.

진작 Realm에서 가져와 나타내줄 걸 그랬다. 반복문을 사용해 successCount를 높이는 거보다 훨씬 더 깔끔한 코드가 되었다.

최대한 Realm을 활용하고자 노력해야겠습니다...


# 220927

## 1. 특정시간대에 노티피케이션 설정(feat. 로컬 노티는 64개까지!!!)

전에 배웠지만... 기억력 이슈로 인해 로컬 노티피케이션은 64개 까지인걸 인지 못한 저는 사용자가 스케쥴 등록할 때 마다 매 번 노티피케이션을 설정해주게하면 좋겠다... 라고 생각했습니다.

<img width="200" alt="image" src="https://user-images.githubusercontent.com/92367484/194526329-8b3c8923-abe5-4879-bd34-5349a10ba618.png">

그래서 뷰를 이렇게 만들었죠... 

그리고 피드백을 받은 후에 일정 시간대에 알람을 설정할 수 있도록 바꾸어 주었습니다...

https://user-images.githubusercontent.com/92367484/194529182-674fcd16-ecac-4fe5-993a-d9019ff0d5b5.mp4

이 파트에서 저는 사용자가 권한을 허용해주거나 or 안 해주거나 두 가지에 매몰되어 간단한 부분을 놓쳤습니다.


### 1-1. 권한설정 여부에만 신경썼어요...

처음 노티피케이션 설정을 해줄 때 저는 당연하게 __권한 설정이 되어있을 때__ or __권한설정이 되어있지 않을 때__ 이 두가지를 가지고 모든걸 판단하려했습니다.

그러다보니 권한설정이 되어있는지 안 되어있는지를 확인할 수 있는 메소드를 가지고 권한설정이 true이면 시간설정이 가능하게 아니면 권한설정 창으로 바로 이동하게 해주는 식으로 하려 했습니다.

```swift
let center = UNUserNotificationCenter.current()

cetner.getNotificationCenter.current()
center.getNotificationSettings { settings in 
    switch settings.alertSetting {
        case .enabled:
            // 허용한 상태일 경우
        default:
            // 허용하지 않은 상태 + 나머지 모든 경우
    }
}
```

그러면 킬 때는 사용자가 권한설정으로 이동이 가능하게 해줬는데 끌 때는 어떻게 될까요?

앱 내에서 시스템설정의 권한설정여부를 조정해줄 수 있을까요?

네... 이걸 몰랐죠 전 ㅠㅠ...

<span style="color:red">앱 내 설정으로 시스템설정을 컨트롤 하는 것은 불가능 합니다.</span>

권한설정창 쪽으로 사용자가 이동되게 할 수는 있지만요.

처음 제가 생각했던 "앱내에서 알림권한 설정여부를 확인하고 사용자가 스위치를 끄면 시스템 설정에서의 알림 권한을 꺼질 수 있게 하도록 하자!"는 불가능한 것이였죠.


### 1-2. 그냥 삭제하면 되죠!!!

이를 어떻게 해결했냐면 바로 노티피케이션을 끄면 등록되어있는 노티피케이션이 모두 삭제 되도록 했습니다.

그러면 어찌됐던 알림은 사용자에게 가지 않습니다. 시간이 등록되어 있지 않으니까요.

"그러면 알림권한은 켜져있는 상태가 아닌가요?" 라는 생각을 할 수 있겠죠. 저도 그랬듯...

네 알림 권한은 사실 켜져있는 상태인거죠. 하지만 알림은 다 삭제됐으니까 크게 상관 없겠죠?

그리고 사용자가 알림을 설정하고 싶으면 스위치를 키고 다시 권한설정 창으로 유도되는데 권한설정이 켜져있다하더라도 다시 권한을 끌가요?

아니죠. '켜져있구나' 확인만하고 다시 앱으로 와서 알림 시간을 설정해주면됩니다.

사실 권한설정이 켜져있든 꺼져있든 유저 입장에선 크게 상관이 없고 알림이 오냐 안오냐 설정이 잘 되있냐 이 것이 유저가 신경쓰는 포인트일 것입니다.

그래서 이와같이 코드를 구성했습니다.

```swift
override func viewDidLoad() {
	super.viewDidLoad()
	
	self.navigationItem.title = "설정"
	
	mainView.backgroundColor = .systemBackground

	// 왜 비동기로해야할까?
	notificationCenter.getPendingNotificationRequests { requests in
		if requests.isEmpty == true {
			DispatchQueue.main.async {
				self.mainView.alarmToggle.setOn(false, animated: false)
				self.mainView.setTimeButton.setTitle("시간설정", for: .normal)
			}
		} else {
			let storedTime = UserDefaults.standard.string(forKey: "settingTime")
			DispatchQueue.main.async {
				self.mainView.alarmToggle.setOn(true, animated: false)
				self.mainView.setTimeButton.setTitle(storedTime, for: .normal)
			}
		}
	}
}

// 알람스위치 클릭액션
@objc func alarmToggleClicked() {
	if mainView.alarmToggle.isOn == true {
		guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
		
		if UIApplication.shared.canOpenURL(url) {
			UIApplication.shared.open(url)
		}
	} else {
		
		notificationCenter.removeAllPendingNotificationRequests()
		mainView.setTimeButton.setTitle("시간설정", for: .normal)
	}
}

// 
func sendNotification(alarmHour: Int, alarmMinute: Int) {
	UNUserNotificationCenter.current().getNotificationSettings { settings in
		if settings.authorizationStatus == UNAuthorizationStatus.authorized {

			let notiContent = UNMutableNotificationContent()
			notiContent.title = "시간이 됐어요!"
			notiContent.subtitle = "일어나 스케쥴을 수행해주세요~~"
			notiContent.sound = .defaultCritical

			var date = DateComponents()
			date.hour = alarmHour
			date.minute = alarmMinute

			let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
			let request = UNNotificationRequest(identifier: "wakeup", content: notiContent, trigger: trigger)

			UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)

		} else {
			print("User not agree")
		}
	}
}

func getPendingNotificationRequests(completionHandler: ([UNNotificationRequest]) -> Void) { }
```


### 1-3. notification 설정은 왜 비동기로 해야할까?
<img width="650" alt="스크린샷 2022-10-07 오후 8 03 19" src="https://user-images.githubusercontent.com/92367484/194539372-9ba684f2-ae81-46ce-b541-5d23d70d92ca.png">
`getPendingNotificationRequests` 는 노티피케이션 요청이 있는지 없는지를 판단해주는 메소드 입니다.

이 메소드를 사용해서 노티피케이션이 있는지 없는지 판단하고 없는 경우 "시간설정"으로 아닌 경우 설정시간을 UserDefaults로 저장해서 유저의 시간설정을 저장해주었습니다.

그런데 이 메소드를 사용하려면 Async로 처리해줘야합니다. 그렇지 않으면 위와 같이 보라색 오류가 발생하게 됩니다.

그렇다면 대체 왜 비동기로 처리해주어야 할까요?

<img width="650" alt="스크린샷 2022-10-07 오후 9 07 37" src="https://user-images.githubusercontent.com/92367484/194554086-b9081547-12a7-4460-bda5-741d7d3871d0.png">


네  사용한 `getPendingNotificationRequests` 메소드가 async(비동기)로 처리되기 때문입니다.

이와 관련된 내용은 추후 블로그에서 자세하게 다루겠습니다.

# 220928

# 220929

# 220930

# 221001

# 221002

# 221003

# 221004


