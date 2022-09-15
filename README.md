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


![Simulator Screen Shot - iPhone 11 - 2022-09-14 at 22 51 39 | 200](https://user-images.githubusercontent.com/92367484/190173335-bc13ec8a-a65e-4b56-9cb8-77e5362b153c.png)

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



___