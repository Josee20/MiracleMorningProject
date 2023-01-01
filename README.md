# MIMO(미모)

미모는 미(라클)모(닝)의 줄임말로 아침에 일찍 일어나 자기개발 하는 것을 돕고 수행한 스케쥴들을 한 눈에 보고 관리할 수 있도록 만든 서비스입니다.

## About MIMO

MIMO는 <span style="color:red">개발자가 직접 기획부터 디자인까지 해서 개발</span>한 앱입니다. 이를 통해 앱이 만들어지는 전체적인 플로우를 익힐 수 있었습니다.

### ✅ 주요기능
- 스케쥴 수행 시간 및 현황을 알려주는 **타이머**
- 스케쥴 확인을 도와주는 **캘린더**
- 월별 스케쥴 통계를 나타내주는 **차트**
- **알림**

<img width="700" alt="미모 MOCK" src="https://user-images.githubusercontent.com/92367484/209270836-825b3555-9377-4eef-838e-82dd991c22d3.png">

### 📝 업데이트 - 꾸준히 crash, 피드백을 반영해 업데이트하고 있습니다.
__1.1 업데이트__
- 차트 데이터 모두 실패처리로 나오는 오류 수정
- 온보딩 화면 추가
- <span style = "background-color:purple">노티피케이션 수정(알람 기능) - crash 발생부분</span>
__1.2 업데이트__
- Charts 업데이트로 인해 바뀐 범례(legend) 코드 수정
- 차트 월 선택 오류 수정
- 프로필 네비게이션 바 오류 수정
__1.21 업데이트__
- <span style = "background-color:purple">12월에 스케쥴 추가시 발생하는 오류 수정 - crash 발생부분</span>
- 데이트피커 사용 언어에 맞춰 현지화
- Charts 업데이트로 인해 %단위 오류 수정

### ☀️ 개요
**Architecture** : `MVC` <br>
**Framework** : `UIKit`, `UserNotifications` <br>
__Library__ : `Charts`, `FSCalendar`, `SnapKit`, `Realm`, `FirebaseAnalytics`, `FirebaseMessaging` <br>

- __MVC패턴 적용__
	- MVVM패턴에 대한 이해도 부족 및 약 4주 정도의 기간내에 기획, 디자인, 개발까지 해야되어 개발속도가 빠른 MVC패턴을 채택했습니다.
	- 프로젝트의 규모가 크지 않다고 생각되어 MVC패턴으로도 유지보수가 어렵지 않을거라 생각했습니다.
-  **UI**
	- 오토레이아웃으로 UI를 구성하는데 직관적인 코드와 유지보수를 위해 SnapKit을 사용했습니다
- **Timer**
	- 스케쥴 수행과 수행여부를 유저가 쉽게 확인할 수 있도록 Timer를 구현했습니다.
- **원형차트**
	- 생산성을 높이기 위해 Charts라이브러리를 사용했습니다.
	- 스케쥴 성공여부 및 현황을 직관적으로 확인할 수 있게 원형차트를 커스텀해 구현했습니다.
	- 세부사항(성공횟수, 수행시간)은 범례(legend)로 확인할 수 있게 했습니다.
- **달력**
	- 생산성을 높이기 위해 FSCalendar 라이브러리를 사용했습니다.
	- 달력의 액션(클릭, 스와이프)에 따라 컬렉션뷰와 테이블뷰가 갱신될 수 있게 해줬습니다.
- **DB**
	- CoreData와 Realm 중 CoreData가 직관적이지 않고 사용이 불편해 Realm을 채택했습니다.
	- Realm Studio를 통해 DB상태를 직관적으로 확인할 수 있어 편리했습니다.
	- Swift의 문법을 사용할 수 있어 직관적인 코드로 작업할 수 있어 편리했습니다.
- **알람**
	- 유저가 아침에 일어나는 것을 돕고자 알림기능을 구현했습니다.
- **유지보수 및 업데이트**
	- Firebase Analytics를 적용해 crash를 분석하고 그에 맞춰 업데이트하고 있습니다.

### 💻 기술스택
-   UIBezierPath와 Timer를 활용해 **Custom Timer View**를 구현했습니다.
-   Realm 쿼리기반으로 Charts의 __Custom Piechart, Custom Legend(범례)__ 를 만들었습니다.
-   유저 액션에 따른 UI 갱신(캘린더 & 컬렉션뷰 & 테이블뷰)을 단방향 데이터 바인딩을 통해 제어했습니다.
-   **Repository Pattern**으로 Realm의 CRUD를 관리했습니다.
-   **Singleton Pattern**으로 여러 Dateformat을 관리했습니다
-   클로저를 통한 값 전달로 스케쥴의 **수정기능**을 구현했습니다.
-   UIPickerView를 활용하여, **Custom** **DatePickerView**를 구현했습니다.
-   NumberFormatter와 Charts를 활용해 **%단위**를 구현했습니다.
-   **Extension**을 활용해 UIButton을 Custom하여 코드 재사용성을 높였습니다.
-   알림허용 여부 구현시 UISwitch와 관련된 작업을 메인쓰레드에서 동작되게 처리했습니다.
-   Firebase를 활용해 __crash를 관리 및 분석 후 업데이트__ 했습니다.

### 🤔 고민 및 해결

#### 1. 비동기 처리 메소드가 무엇인지 그 안에서의 UI작업은 어떻게 처리할지

<img width="700" alt="스크린샷 2022-12-25 오후 9 38 11" src="https://user-images.githubusercontent.com/92367484/209915139-a76b7019-d3e0-4ee6-847b-7349c1c1d8a8.png">

	⭐️ 고민지점 ⭐️
	UISwitch.setOn 메소드가 메인쓰레드에서 작업되어야 한다는 오류를 겪게되었습니다.쓰레드 작업을 별도로 처리해주지 않으면 메인쓰레드에서 작업을 하는 것으로 알고있는데 왜 이와같은 오류가 발생했는지에 대해 고민했습니다.
	
	🔎 해결과정 🔍
	1. UISwitch.setOn 메소드가 메인쓰레드에서 처리되지 않고있다는 것을 인지했습니다.
	2. URLSession을 사용할 때 메소드 자체가 비동기로 처리되었던 것이 고민하는 도중에 생각났습니다.   
	3. getPendingNotificationRequests가 비동기 메소드인 것을 공식문서에서 확인할 수 있었습니다.
	4. 때문에 UISwitch.setOn이 왜 백그라운드 쓰레드에서 작업되는지 알게 되었습니다. 
	
	✅ 해결 ✅
	DispatchQueue.main.async를 사용해 메인쓰레드에서 동작되도록 했습니다.

오류를 해결하면서 또 하나의 의문이 생겼습니다. "왜 `UISwitch.setOn` 메소드는 메인쓰레드에서 작업되어야 하는지"입니다. 이에 대한 것도 고민하고 해결했습니다.

	⭐️ 고민지점 ⭐️
	왜 UISwitch.setOn 메소드는 왜 메인쓰레드에서 처리되어야 하는지에 대해 고민했습니다.
	
	🔎 해결과정 🔍
	1. UISwitch.setOn 메소드는 UI관련 작업인 것을 인지했습니다.
	2. 찾아보니 UI관련 작업은 메인쓰레드에서 이루어져야한다는 것을 확인할 수 있었습니다.
	3. 그렇다면 왜 UI관련 작업은 메인쓰레드에서 이루어져야하는 것인지 찾아보았습니다.
	
	✅ 해결 ✅
	UIKit이 thread-safe하지 않기 때문에, 렌더링 성능이슈 때문인 것을 확인할 수 있었습니다.

**"UI작업은 왜 메인쓰레드에서 되어야하는가"** 에 대해 자세한 내용은 👉 [블로그](https://josee2.tistory.com/63) 에서 확인하실 수 있습니다.

#### 2. Modal Presentation Style이 Default일 경우 값 전달

<img width="200" alt="Modal Default Screen" src="https://user-images.githubusercontent.com/92367484/209917858-4ba07c30-7e54-42b3-b663-9c214404760b.jpeg">
	
	⭐️ 고민지점 ⭐️
	Modal PresentationStyle이 디폴트(automatic)이면 뷰컨트롤러의 생명주기를 가지지 않게된다는 것을 알게 되었습니다. 스케쥴 수정하는데 값전달이 반드시 필요했기 때문에 어떻게 전달할지에 대해 고민했습니다. 
	
	🔎 해결과정 🔍
	1. ModalPresentationStyle이 디폴트인 경우 뷰컨트롤럴의 생명주기 가지지 않는 것을 확인했습니다.
	2. 값 전달 방법에 대해 찾아보고 학습했습니다. 
	3. 간단한 작업이라고 생각해 프로토콜, 노티피케이션, 클로저를 활용한 값 전달 방법 중 클로저를 활용한 값 전달을 사용했습니다.
	
	✅ 해결 ✅
	1. 값 전달받을 뷰컨트롤러에 실행될 빈 클로저 선언
	2. 값 전달하는 쪽에서 클로저 함수 정의
	3. 전달받은 클로저 실행

```swift
// 값 전달 받을 뷰컨트롤러
final class ChangeScheduleViewController: BaseViewController {
	// 1. 빈 클로저 선언
	var okButtonActionHandler: ( () -> Void )?
}

// 값 전달할 뷰컨트롤러
func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
	let vc = ChangeScheduleViewController()
		// 2. 클로저 함수 정의
		vc.okButtonActionHandler = {
			self.mainView.tableView.reloadData()
		}
		let nav = UINavigationController(rootViewController: vc)
		present(nav, animated: true)
		}
	}
}

// 값 전달 받을 뷰컨트롤러
@objc func okButtonClicked() {
		// 3. 클로저실행
		okButtonActionHandler?()
		dismiss(animated: true)
	}
}
```

#### 3. 반복되는 코드를 어떻게 줄일까

	⭐️ 고민지점 ⭐️
	앱의 특성상 Realm의 데이터를 필터링하고 Dateformat을 변환해서 보여줘야하는 상황이 많았습니다. 때문에 Realm 필터링 메소드와 Dateformat 관련 메소드가 여러 곳에 반복되어 사용되었습니다.
	이렇게 코드를짜면 관리하기가 어렵고 후에 유지보수하는데 어려움을 많이 겪을 것 같아서 어떻게하면 효율적으로 이를 관리할 수 있을지 고민했습니다.
	
	🔎 해결과정 🔍
	1. 반복되는 Realm 필터링 메소드 및 Dateformat 변환 코드가 비효율적이라 생각했습니다.
	2. 이를 해결하고자 한 곳에서 관리하고 처리할 수 있는 방법을 탐구했습니다.
	3. 클래스를 따로 만들어 관련코드들을 처리하는 Singleton Pattern, Repository Pattern에 대해 학습하고 적용했습니다.
	
	✅ 해결 ✅
	1. DateFormat처리 코드들을 Singleton Pattern을 사용해 관리했습니다.
	2. Realm CRUD처리 메소드들을 Repository Pattern을 사용해 관리했습니다.
	3. 이로인해 중복된 코드들을 줄이고 유지보수가 용이해졌습니다.

#### 4. 오류를 어떻게 찾고 관리할까

	⭐️ 고민지점 ⭐️
	평소 저는 앱 사용 도중 오류가 발생하면 앱을 삭제하거나 잘 사용을 안하게 되었습니다. 때문에 앱을 사용하는데 나타나는 에러나 오류들을 꼭 관리해야한다고 생각했습니다.
	앱스토어 리뷰나 지인들의 피드백으로는 발생하는 오류들을 다 관리하기는 어렵다고 생각했고 이를 관리할 수 있는 방법에대해 고민했습니다.
	
	🔎 해결과정 🔍
	1. 사용자가 겪는 오류를 찾고 분석해줄 수 있는 방법에 대해 찾음
	2. 구글의 Firebase에 대해 알게되었고 이에대해 학습 후 적용
	
	✅ 해결 ✅
	Firebase Analyticcs를 활용해 crash 주기적으로 확인 후 업데이트

### ✍️ 회고

-   **File Convention의 부재**
    중구난방인 파일컨벤션으로 인해 파일이 어떤 역할을 하는지 직관적이지 않아 비효율적으로 작업을 하게 되었습니다. 추후엔 파일컨벤션을 적용해 프로젝트를 진행해보고자 파일 컨벤션에 대해 학습하였습니다.
    
-   **부족한 코드 퀄리티**
    반복되고 재사용할 수 없는 코드, 수많은 리터럴, 수많은 for문 등 구현에만 급급해 좋은 코드를 짜려고 노력하지 못한 것이 너무나 아쉬웠습니다. 추후엔 리터럴 값들을 enum으로 관리하고 최대한 로직을 분리시켜 코드의 퀄리티를 높이고자 합니다.
    
-   **방대한 ViewController**
    개발기간이 짧아 MVC 패턴으로 프로젝트를 진행하다보니 복잡한 메소드가 들어가거나 하면 코드의 양이 생각보다 많이 늘어났습니다. 때문에 업데이트를 진행할 때 다소 어려움을 겪게 되었습니다. 추후 MVVM 패턴을 적용해 리팩토링을 진핼할 예정입니다.
    
-   **일관성 없는 버전관리**
    업데이트를 진행하는데 일관성 없이 버전관리를하여 버전을 보고 기능이 추가됐는지, 버그를 고쳤는지 등에 대한 판단이 어려웠습니다. 추후 업그레이드 시에 Semantic Versioning을 적용하고자 합니다.


# 개발일지

<img width="850" alt="스크린샷 2022-12-30 오후 4 55 07" src="https://user-images.githubusercontent.com/92367484/210047599-37307c3c-f6f0-44a1-a8ee-a5cb3400ee17.png">

## 220911

### 1. Timer

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

### 2. 헤더뷰 레이블 달기

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

## 220912

### 1. circular progress bar

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

### 2. multiple button click and change background color

<img width="297" alt="스크린샷 2022-09-13 오전 3 24 57" src="https://user-images.githubusercontent.com/92367484/210048211-7dd20833-5e5b-4d19-aa84-76c63483c62d.png">
#### 중요사항

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

## 220913

### 1. Notification

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



### 2. Alert + DatePicker

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

## 220914

### 1. CollectionView

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

###  2. TableView

추가한 스케쥴을 유저가 캘린더에서 클릭 시 확인할 수 있도록 하기위해 테이블 뷰로 작성했다.

아직은 UI만 된 상태....

<img width="250" alt="스크린샷 2022-09-14 오후 10 38 08" src="https://user-images.githubusercontent.com/92367484/190173335-bc13ec8a-a65e-4b56-9cb8-77e5362b153c.png">

## 220915

### 1. Realm 설계

유저가 미션, 요일, 시간을 정해서 등록하면 등록일부터 이번 달 마지막일 까지 스케쥴이 생성될 수 있도록  만들고자 했습니다.

때문에 컬럼에 PK, 시작시간, 종료시간, Date, 미션이름, 수행여부를 나타내주기로 했습니다.

| PK    | 시작시간    |  종료시간     | Date    |  미션이름  | 수행여부 |
| --- | --- | --- | ---| --- | --- | 
| abcd1234|10:00 | 11:00| 23:12:22:... | 백준문제풀기 | false | 


### 2. Object Model 정의

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

### 3. 다음 날부터 이번 달 마지막일까지 선택한  요일 스케쥴 등록

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


### 4. 등록가능시간 예외처리

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

## 220917

### 1. 캘린더에 dot추가 하기

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

### 1-2 ❎ 문제발생 ❎

앱을 껐다키면 제대로 ...이 날짜에 맞추어 인식되지만 스케쥴 등록 후 캘린더에 들어가면 제대로 ...이 안찍히는 현상일 발생했다.

최초에 스케쥴 등록시엔 잘 등록이 되지만 두 번째 부턴 밀리기 시작한다...

![[스크린샷 2022-09-17 오후 4.06.21.png | 500]]

어째서인지 22일 23일에 등록되지 않고 27, 28일로 넘어가 버렸다... 그런데 앱을 껐다키면 제대로 인식이 되어 나타난다...

![[스크린샷 2022-09-17 오후 4.08.28.png | 500]]


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

![[스크린샷 2022-09-17 오후 6.35.01.png]]

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


### 1-3 오류해결 (feat. Set)

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

## 220918

### 1. 캘린더 날짜 선택시 스케쥴 테이블뷰에 띄워주기

2Page의 테이블뷰셀에 캘린더에서 선택한 날에 대한 데이터를 나타내고자 했다.

먼저 클릭하면 해당 날짜와 일치한 스케쥴이 잘 출력되는 지 확인 했다.

그런데 출력이 잘 되지 않았다...



#### 1-1. 문제발생(인덱싱?)

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

<img width="250" alt="스크린샷 2022-09-18 오후 12 31 21" src="https://user-images.githubusercontent.com/92367484/210048871-2af1add1-cdda-476c-9896-475491505afd.png">

날짜에 맞춰 정렬이되어있으면 가능할 거 같았지만 데이터를 넣을 때 반복문으로 넣어서 그런지 fetch를 불러줘도 정렬이 계속 안 되었다...

두 가지 생각을 했었다.

1. Realm을 어떻게든 다시 Date로 정렬해주고 위의 반복문을 통해 나타낸다.
2. Realm에서 filter?를 통해 가져와서 보여준다.



#### 1-2. 문제 해결( feat. where )

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

## 220919

### 1. Collection View에 데이터 띄워주기

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


#### 1-1. ❎문제발생❎

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


#### 1-2. ✅ 문제해결

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

## 220920

### 1. 테이블뷰에 스케쥴 제대로 띄워주기(삽질)

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


#### 1-1. 삽질(뻘 짓)의 시작...

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


### 2. 스와이프 삭제기능

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

## 220921

### 1. FSCalendar 오류?

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



### 2. 타이머 중단기능 추가

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

## 220922

### 1. CollectionView 달에 따라 현황 보여주기

기존 컬렉션 뷰는 ScheduleSuccess여부가 true인 값만 필터링을 해와서 달에 상관없이 성공한 스케쥴이라면 모두 나타나게 되어있었다.(9월인데도 10월 11월 스케쥴 나타남)

```swift
// In UserScheduleRepository
func successSchedule() -> Results<UserSchedule> {
	return localRealm.objects(UserSchedule.self).filter("scheduleSuccess == true")
}
```


#### 1-1. 달의시작, 다음 달 구하기

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


#### 1-2. 딕셔너리에 담아주기

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


#### 1-3. 캘린더 스와이프시 값 변경

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

## 220923

### 1. 셀 수정

셀 수정에서 제가 고려한 부분은 이미 지나간 스케쥴의 경우 수정이 불가하게 막는 것이었습니다. 

한 달간 계획을 챌린지하게 세우는데 성공했던 스케쥴이나 실패했던 스케쥴을 수정가능하게 두면 안 되기 때문입니다.

#### ❎ 주의사항 ❎

모달은 ViewWillAppear시점이 통하지 않기 때문에 클로져로 값 전달 후 값을 수정한다.

클로저, 노티피케이션, 프로토콜을 이용해 값 전달을 할 때에는  모달, 푸시앤팝 등으로 다음화면과 전 화면을 특정할 수 있어야 값 전달이 제대로 이루어진다.


#### 1-1. 클로저를 이용한 값 전달

##### 1) 값 전달받을 뷰컨트롤러에서 클로저 선언

```swift
// In ChangeScheduleViewController
final class ChangeScheduleViewController: BaseViewController {
	// 1. 실행될 빈 클로저 선언
	var okButtonActionHandler: ( () -> Void )?
}
```

##### 2) 클로저 함수 정의

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

##### 3) 전달받은 클로저 실행

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

### 2. 셀 삭제

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

## 220924

### 1. 캘린더에 스케쥴 & 수행여부 dot으로 표현

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


### 2. 오류수정

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

## 220925

### 1. 날짜를 누르고 스와이프를 계속하면 오류발생

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


#### ✅ 해결 ✅

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

최대한 Realm을 활용하고자 노력해야겠다!!!

## 220927

### 1. 특정시간대에 노티피케이션 설정(feat. 로컬 노티는 64개까지!!!)

전에 배웠지만... 기억력 이슈로 인해 로컬 노티피케이션은 64개 까지인걸 인지 못한 저는 사용자가 스케쥴 등록할 때 마다 매 번 노티피케이션을 설정해주게하면 좋겠다... 라고 생각했습니다.

<img width="200" alt="image" src="https://user-images.githubusercontent.com/92367484/194526329-8b3c8923-abe5-4879-bd34-5349a10ba618.png">

그래서 뷰를 이렇게 만들었죠... 

그리고 피드백을 받은 후에 일정 시간대에 알람을 설정할 수 있도록 바꾸어 주었습니다...

https://user-images.githubusercontent.com/92367484/194529182-674fcd16-ecac-4fe5-993a-d9019ff0d5b5.mp4

이 파트에서 저는 사용자가 권한을 허용해주거나 or 안 해주거나 두 가지에 매몰되어 간단한 부분을 놓쳤습니다.


#### 1-1. 권한설정 여부에만 신경썼어요...

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


#### 1-2. 그냥 삭제하면 되죠!!!

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

#### 1-3. notification 설정은 왜 비동기로 해야할까?

<img width="650" alt="스크린샷 2022-10-07 오후 8 03 19" src="https://user-images.githubusercontent.com/92367484/194539372-9ba684f2-ae81-46ce-b541-5d23d70d92ca.png">

`getPendingNotificationRequests` 는 노티피케이션 요청이 있는지 없는지를 판단해주는 메소드 입니다.

이 메소드를 사용해서 노티피케이션이 있는지 없는지 판단하고 없는 경우 "시간설정"으로 아닌 경우 설정시간을 UserDefaults로 저장해서 유저의 시간설정을 저장해주었습니다.

그런데 이 메소드를 사용하려면 Async로 처리해줘야합니다. 그렇지 않으면 위와 같이 보라색 오류가 발생하게 됩니다.

그렇다면 대체 왜 비동기로 처리해주어야 할까요?

<img width="650" alt="스크린샷 2022-10-07 오후 9 07 37" src="https://user-images.githubusercontent.com/92367484/194554086-b9081547-12a7-4460-bda5-741d7d3871d0.png">

네  사용한 `getPendingNotificationRequests` 메소드가 async(비동기)로 처리되기 때문입니다.

## 220928

### 1. UI 수정 

기존에 기능을 구현하느라 못 했던 UI를 좀 다듬고 systemOrange로 된 색을 다른색으로 변경시켜 주었다.

기존에 systemOrange를 왜 키 컬러로 가져갔냐 함은... 아침하면 태양! 태양하면 주황색! 태양의 색을 표현하면 좋겠다 라고 막연하게 생각했기 때문이다.

하지만 주황색은 생각보다 쨍하다... 그래서 톤을 좀 다운 시키면 뭔가 칙칙한? 느낌이 나서 색을 변경하고자 했다.

그럼 아침의 파란 하늘?로 해보자해서 좀 괜찮은 하늘색을 컬러로 가져왔지만 이쁘긴한데 뭔가 유저입장에서 이쁘기만할 뿐 딱히 어떤 의미를 주지 못한다고 생각했다.

그래서 좀 더 고민하던 중 기존에 스케쥴 성공과 실패에 따라 체크버튼으로만 표시를 해준 것을 좀 더 보완해서 __성공시 스케쥴 색을 초록색으로 실패 시 빨간색으로 나타내주면 좋겠다!__ 라고 생각해 이를 반영하였다.

또한 초록색을 키 컬러로 잡고 색을 전면 수정하였다.

이 때 UIColor를 각각 지정해줬던 것을 따로 Extension으로 빼서 색을 지정해준 후 에 사용하였다.

```swift
extension UIColor {
    
    static let mainOrange = UIColor (
        red: 151/255,
        green: 210/255,
        blue: 236/255,
        alpha: 1
    )
    
    static let mainGreen = UIColor (
        red: 56/255,
        green: 229/255,
        blue: 77/255,
        alpha: 1
    )
    
    static let mainRed = UIColor (
        red: 245/255,
        green: 115/255,
        blue: 40/255,
        alpha: 1
    )
    
    static let collectionViewColor = UIColor.systemGray6
    
    static let collectionViewTextColor = UIColor.darkGray
}
```

이렇게 코드를 작성하니 색을 수정할 때 이 곳에서만 바꿔주면 모든 곳에 반영이되니 훨씬 편리했다.

그리고 최종 디자인을 다음과 같이 만들었다... 아직 부족한 부분이 많은데 추후 하나씩 수정해 나가겠습니다 😂😂

<img width="500" alt="스크린샷 2022-10-10 오후 3 13 01" src="https://user-images.githubusercontent.com/92367484/194807284-0ba4cb7f-22d4-4d54-b494-3988da738aac.png">

## 220929

### 1. 차트 디자인

#### 1-1. 파이차트뷰

Charts 라이브러리를 사용해서 차트를 만들고자 했습니다.

차트로 보여주고 싶은 것은 '달 마다의 진행상황과 성공 스케쥴의 비율' 두 가지 였습니다.

때문에 둘 다를 한 페이지에 보여주면 좋겠다고 생각했고 이를 쉽게 보려면 원형차트(파이차트)가 좋겠다 생각해 그리고자 했습니다.

```swift
let currentMonthSuccessChart: PieChartView = {
	let view = PieChartView()
	
	view.entryLabelColor = .black
	
	let text = "달성률"
	let textFont = UIFont.boldSystemFont(ofSize: 15)
	let attributes: [NSAttributedString.Key: Any] = [
		.font: textFont,
	]
	view.centerAttributedText = NSAttributedString(string: text, attributes: attributes)
	
	// 원 안쪽 크기 조절
	view.usePercentValuesEnabled = true
	view.drawSlicesUnderHoleEnabled = false
	view.holeRadiusPercent = 0.30
	view.transparentCircleRadiusPercent = 0.33
	
	view.noDataText = "등록된 스케쥴이 없습니다."
	view.noDataTextColor = .failColor
	view.noDataFont = .boldSystemFont(ofSize: 15)
	return view
}()
```

처음엔 Charts 라이브러리에 커스텀이 가능한 부분이 별로 없는 거 같아 많이 고민 됐었습니다... 이 라이브러리를 계속 써야하나?

하지만 역시 저의 착각이였고 라이브러리에 들어가서 하나씩 살펴보고 구글링도 열심히 하니까 어떻게 되긴 하더라구요!!! 

차트 안의 글자에 차트 타이틀을 작성해주고 안쪽 원의 크기를 조정해주고 자체적으로 데이터가 없을 때 제공해주는 noDataText두 위와 같이 조절 해주었습니다.


#### 1-2. 현황 어떻게 세부적으로?

데이터를 어떻게 보여줘야 할 지에 대해 엄청 고민했었습니다.

그냥 차트 안에 데이터와 데이터 값을 둘 다표현해 주자니 글자가 길어 질 경우 겹치게 되어 유저 입장에서 불편하게 될 것이고... 표를 만들어 따로 분리해 주자니... 한 화면에 둘 다 표시해주기 어려울 거 같고... 그래서 결론 내렸습니다.

" 범례에 표시를 해주자!!!" 

범례를 커스텀하게 나타낼 수 있는 메소드를 사용해 범례의 색, 데이터, 그리고 몇 분(1번 차트), 몇 회(2번 차트)를 나타내 주었습니다.

```swift
func customizeChart(dataPoints: [String], values: [Double]) {
	
	// 1. Set ChartDateEntry
	var dataEntries: [ChartDataEntry] = []
	var legendEntries: [LegendEntry] = []
	let legendColors: [UIColor] = [.successColor, .failColor, .notDoColor]
	
	for i in 0..<dataPoints.count {
		
		if values[0] == 0 && values[1] == 0 && values[2] == 0 {
			return
		} else {
			let dataEntry = PieChartDataEntry(value: values[i], label: nil, data: dataPoints[i] as AnyObject)
			dataEntries.append(dataEntry)
			
			// legendEntry 배열에 담아주기
			let legendEntry = LegendEntry.init(label: "\(dataPoints[i]): \(Int(values[i]))회", form: .default, formSize: CGFloat.nan, formLineWidth: CGFloat.nan, formLineDashPhase: CGFloat.nan, formLineDashLengths: nil, formColor: legendColors[i])
			legendEntries.append(legendEntry)
		}
	}
	
	// legendEntires 배열 커스텀으로 등록
	mainView.currentMonthSuccessChart.legend.setCustom(entries: legendEntries)
}
```

여기서 dataEntry란 차트에 데이터를 입력해주는 것 입니다. 

차트에 입력되는 dataPoints와 value를 dataEntry로 받아 dataEntries 배열로 저장 후 이를 뿌려줍니다.

다음 글 에서 자세히 다루겠습니다.

이 때 저는 legendEntries와 legendColors를 배열로 만들어 커스텀 해주었습니다.

dataEntry에 값을 넣어주기 위해 loop를 돌릴 때 legendEntry의 값도 추가해줍니다. 

그러면 legendEntry의 label에 dataPoints와 그에 맞는 value를 정확하게 써줄 수 있게 됩니다.

그리고 마지막으로 legend.setCustom에 legendEntry를 담은 legendEntries를 등록해주면 다음과 같은 차트를 만들 수 있습니다.

<img width="250" alt="KakaoTalk_Photo_2022-10-06-20-16-01 003" src="https://user-images.githubusercontent.com/92367484/194817349-57272422-137b-4498-9816-984d50507693.png">

한 페이지에 두 개의 차트를 나타내는 것과 범례로 세부사항을 나타내주는게 맞는 건지에 대한 고민은 좀 더 필요한 거 같습니다...

## 220930

### 1. 차트에 데이터 뿌려주기

이번에 차트를 만들면서 가장 어려웠던게 바로 이 파트였습니다.

사실 dataPoints와 values가 고정된 상태의 경우면 그렇게 차트를 만드는 것은 어렵지 않습니다.

하지만 달 마다 데이터를 따로 가져와서 나타내줘야한다는 점, 매일 변화되는 데이터를 반영해줘야하는 점, 두개의 차트를 한 화면에 나타내는데 나타나는 부작용?(차트 하나는 변하고 하나는 안 변하고...) 등의 이슈들의 처리가 어려웠습니다.


#### 1-1. 커스텀 MonthPicker

먼저 사용자가 월만 선택할 수 있도록하는 데이트픽커를 만들어 주어야했습니다.

하지만 스위프트에서 DatePicker는 월만 선택할 수 있게 해주는 기능은 제공하지 않기 때문에 따로 PickerView를 사용해 만들어 주었습니다.

```swift
class ThirdViewController: BaseViewController {
	
    // MonthPicker
    var availableYear: [Int] = []
    let allMonth: [Int] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
    var selectedYear = 0
    var selectedMonth = 0
    var todayYear = "0"
    var todayMonth = "0"
    let now = Date()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        mainView.backgroundColor = .systemBackground

        makeAvailableDate()
    }

    // MonthPicker Date설정
    func makeAvailableDate() {
        todayYear = DateFormatChange.shared.dateOfOnlyYear.string(from: now)
        todayMonth = DateFormatChange.shared.dateOfOnlyMonth.string(from: now)
        
        // monthPicker year 설정
        for i in Int(todayYear)!...Int(todayYear)!+1 {
            availableYear.append(i)
        }
        
        selectedYear = Int(todayYear)!
        selectedMonth = Int(todayMonth)!
    }

	// 액션시트 얼럿에 MonthPickerView 넣기
    @objc func monthPickerButtonClicked() {
        let monthPickerView = UIPickerView()

		// 델리게이트패턴 적용
        monthPickerView.delegate = self
        monthPickerView.dataSource = self
        
        let alert = UIAlertController(title: "\n\n\n\n\n\n\n\n\n\n", message: nil, preferredStyle: .actionSheet)
        
        alert.view.addSubview(monthPickerView)
        
        monthPickerView.snp.makeConstraints {
            $0.centerX.equalTo(alert.view)
            $0.top.equalTo(alert.view).offset(8)
        }
        
        let ok = UIAlertAction(title: "확인", style: .default) { [self] (action) in
            ...
		}

        
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alert.addAction(ok)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
}

// 픽커뷰 델리게이트, 데이터소스 상속받음
extension ThirdViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return availableYear.count
        case 1:
            return allMonth.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return "\(availableYear[row])년"
        case 1:
            return "\(allMonth[row])월"
        default:
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            selectedYear = availableYear[row]
        case 1:
            selectedMonth = allMonth[row]
        default:
            break
        }
    }
}
```


#### 1-2. 차트 데이터 세팅

```swift
class ThirdViewController: BaseViewController {
    
    // 스케쥴 진행률 - 1번차트
    var currentMonthSuccess: [String] = []
    var currentMonthSuccessValues: [Int] = []
    
    // 스케쥴 성공 시간 - 2번차트
    var successScheduleDic = [String:Int]()
    var currentMonthSuccessScheduleArr: [String] = []
    var currentMonthSuccessScheduleValueArr: [Int] = []

    func customizeChart(dataPoints: [String], values: [Double]) {
        
        // 1. Set ChartDataEntry
        var dataEntries: [ChartDataEntry] = []
        var legendEntries: [LegendEntry] = []
        let legendColors: [UIColor] = [.successColor, .failColor, .notDoColor]
        
        for i in 0..<dataPoints.count {
            
            if values[0] == 0 && values[1] == 0 && values[2] == 0 {
                return
            } else {
                let dataEntry = PieChartDataEntry(value: values[i], label: nil, data: dataPoints[i] as AnyObject)
                dataEntries.append(dataEntry)
                
                // legendEntry 배열에 담아주기
                let legendEntry = LegendEntry.init(label: "\(dataPoints[i]): \(Int(values[i]))회", form: .default, formSize: CGFloat.nan, formLineWidth: CGFloat.nan, formLineDashPhase: CGFloat.nan, formLineDashLengths: nil, formColor: legendColors[i])
                legendEntries.append(legendEntry)
            }
        }
        
        // legendEntires 배열 커스텀으로 등록
        mainView.currentMonthSuccessChart.legend.setCustom(entries: legendEntries)
    
        //2. Set ChartDataSet
        let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: nil)
        pieChartDataSet.highlightEnabled = false
        pieChartDataSet.colors = legendColors
        pieChartDataSet.sliceSpace = 2.0
        pieChartDataSet.valueTextColor = .black
        pieChartDataSet.valueLinePart1Length = 0.4
        pieChartDataSet.valueLinePart2Length = 0.8
        
        // 3. Set ChartData
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        let format = NumberFormatter()
        format.numberStyle = .percent
        format.maximumFractionDigits = 1
        format.multiplier = 1
        format.percentSymbol = "%"
        let formatter = DefaultValueFormatter(formatter: format)
        pieChartData.setValueFormatter(formatter)
        
        mainView.currentMonthSuccessChart.data = pieChartData
    }
    
    func customizeChart2(dataPoints: [String], values: [Double]) {
        
        // 1. Set ChartDataEntry
        var dataEntries: [ChartDataEntry] = []
        var legendEntries: [LegendEntry] = []
        let legendColors: [UIColor] = [.vividGreen, .dustyGreen, .vividBlue, .vividPurple, .vividYellow, .dustyYellow, .vividPink, .dustyPink]
        
        if dataPoints.isEmpty {
            mainView.currentMonthSchedulePercentageChart.isHidden = true
            mainView.noDataSecondChartLabel.isHidden = false
            return
        } else {
            mainView.currentMonthSchedulePercentageChart.isHidden = false
            mainView.noDataSecondChartLabel.isHidden = true
        }
        
        for i in 0..<dataPoints.count {
            let dataEntry = PieChartDataEntry(value: values[i], label: nil, data: dataPoints[i] as AnyObject)
            dataEntries.append(dataEntry)
            
            let legendEntry = LegendEntry.init(label: "\(dataPoints[dataPoints.count-i-1]): \(Int(values[dataPoints.count-i-1])/60)분", form: .default, formSize: CGFloat.nan, formLineWidth: CGFloat.nan, formLineDashPhase: CGFloat.nan, formLineDashLengths: nil, formColor: legendColors[dataPoints.count-i-1])
            legendEntries.append(legendEntry)
        }
        
        mainView.currentMonthSchedulePercentageChart.legend.setCustom(entries: legendEntries)
        
        //2. Set ChartDataSet
        let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: nil)
        pieChartDataSet.highlightEnabled = false
        pieChartDataSet.colors = legendColors
        pieChartDataSet.sliceSpace = 2.0
        pieChartDataSet.yValuePosition = .outsideSlice
        pieChartDataSet.valueLinePart1Length = 0.4
        pieChartDataSet.valueTextColor = .black

        // 3. Set ChartData
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        let format = NumberFormatter()
        format.numberStyle = .percent
        format.maximumFractionDigits = 1
        format.multiplier = 1
        format.percentSymbol = "%"
        let formatter = DefaultValueFormatter(formatter: format)
        pieChartData.setValueFormatter(formatter)
        
        mainView.currentMonthSchedulePercentageChart.data = pieChartData
    }
}
```

데이터를 넣는 순서는 기본적으로 다음과 같습니다.

1. ChartDataEntry 설정
2. ChartDataSet에 dataEntries 넣어주기
3. ChartData에 설정한 dataSet 넣어주기

#### 1-3. 차트 데이터 Realm에서 가져와 뿌려주기

첫 번째 차트(진행여부)는 data가 '성공', '실패', '미진행' 세 가지 뿐입니다.

때문에 고민할 성공, 실패, 미진행을 인덱스 0, 1, 2 에 넣고 그에 대한 값도 각각 넣어줬으면 됐습니다.

하지만 두 번째 차트(스케쥴 성공 항목별 비율)은 성공한 data를 계속 넣어줄 수 있었고 그에 따라 성공한 비율을 각각 넣어주어야 했기 때문에 고민이 많았습니다.

고민 후에 저는 많이 수행한 스케쥴 8가지만 차트에 나타내주기로했고 데이터를 딕셔너리로 가져와서 나타내주기로 했습니다.

1번 차트와 다르게 어떤 값이 어떻게 들어올 지 모르기 때문입니다.

또한 앱의 특성상 오전 시간대에만 스케쥴 설정이 가능하고 수행가능하기 때문에 한 달간 설정한 스케쥴이 그렇게 많을거라 예상되진 않아서 8개 까지만 보여주기로 했습니다.

그리고 2page에서 성공여부를 확인할 수 있기 때문에... 

## 221001

### 1.  UI 수정

UI에 쓰인 컬러를 수정했습니다.
## 221003

### 1. 4P UI

탭바 4 번째 UI 중 나머지 공지사항, 닉네임 설정  등을 만들고 수정했습니다.

## 221004

### 1. 차트수정

달을 바꿀 때 차트의 데이터가 쌓이는 오류를 수정했습니다. 추가적으로 데이터가 없는 달에는 접근을 못하게 막았습니다.

### 2. 현지화

DateFormatter나 날짜 시간을 한국으로 현지화 시켜서 애플리뷰어(미국)시간으로 앱을 실행하면 발생하는 오류들이 있었습니다.

이를 해결하기위해 `ko-KR` 을 `Locale.current`로 바꾸어 처리했습니다.

### 3. 출시

앱스토어 커넥트에 심사를 올려 최종출시 완료했습니다.





