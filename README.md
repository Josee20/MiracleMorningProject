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
