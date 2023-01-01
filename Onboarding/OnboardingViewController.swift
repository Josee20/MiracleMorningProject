//
//  OnboardingFirstVC.swift
//  MiracleMorningProject
//
//  Created by 이동기 on 2022/10/11.
//

import UIKit

import SnapKit

class OnboardingViewController: BaseViewController {
    
    let mainView = OnBoardingView()
    
    let startButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = .mainBlue
        view.setTitleColor(UIColor.white, for: .normal)
        view.layer.cornerRadius = 5
        view.setTitle("시작", for: .normal)
        return view
    }()
    
    let onBoardingImagesName: [String] = ["onBoarding1", "onBoarding2", "onBoarding3"]
    
    var frame = CGRect.zero
    
    override func loadView() {
        self.view = mainView
        
        mainView.pageControl.numberOfPages = onBoardingImagesName.count
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mainView.backgroundColor = .systemBackground
        mainView.scrollView.delegate = self
        
        for (index, imageName) in onBoardingImagesName.enumerated() {

            let image = UIImage(named: imageName)
            let imageView = UIImageView(image: image)

            imageView.frame = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            imageView.contentMode = .scaleToFill
            imageView.frame.origin.x = UIScreen.main.bounds.width * CGFloat(index)
            mainView.scrollView.addSubview(imageView)
            
            mainView.snp.makeConstraints {
                $0.top.equalTo(mainView.scrollView.snp.top)
                $0.bottom.equalTo(mainView.scrollView.snp.bottom)
                $0.center.equalTo(mainView.scrollView)
            }
            
            if index == onBoardingImagesName.count - 1 {
                mainView.addSubview(startButton)
                
                startButton.snp.makeConstraints {
                    $0.width.equalTo(100)
                    $0.height.equalTo(44)
                    $0.bottomMargin.equalTo(-52)
                    $0.centerX.equalTo(imageView)
                }
            }
            
            self.startButton.addTarget(self, action: #selector(startButtonClicked), for: .touchUpInside)
        }
    }
    
    @objc func startButtonClicked() {
        UserDefaults.standard.set(true, forKey: "onBoarding")

        let tab = TabBarController()
        let nav = UINavigationController(rootViewController: tab)

        tab.navigationController?.isNavigationBarHidden = true
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
}

extension OnboardingViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        mainView.pageControl.currentPage = Int(floor(mainView.scrollView.contentOffset.x / UIScreen.main.bounds.width))
    }
}
