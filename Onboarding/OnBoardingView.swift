//
//  OnBoardingView.swift
//  MiracleMorningProject
//
//  Created by 이동기 on 2022/10/11.
//

import UIKit

class OnBoardingView: BaseView {
    
    public let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alwaysBounceVertical = false
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        view.isScrollEnabled = true
        view.isPagingEnabled = true
        view.bounces = false
        view.backgroundColor = .lightGray
        view.contentSize = CGSize(width: UIScreen.main.bounds.width * CGFloat(3.0), height: UIScreen.main.bounds.height)
        return view
    }()
    
    public let pageControl: UIPageControl = {
        let view = UIPageControl()
        view.currentPage = 0
        view.numberOfPages = 3
        view.pageIndicatorTintColor = .lightGray
        view.currentPageIndicatorTintColor = .black
        return view
    }()
    
    override func configureUI() {
        self.addSubview(scrollView)
        self.addSubview(pageControl)
    }
    
    override func setConstraints() {
        
        scrollView.snp.makeConstraints {
            $0.leading.trailing.equalTo(safeAreaLayoutGuide)
            $0.center.equalTo(self)
            $0.topMargin.equalTo(20)
            $0.bottomMargin.equalTo(-40)
        }
        
        pageControl.snp.makeConstraints {
            $0.width.equalTo(UIScreen.main.bounds.width)
            $0.height.equalTo(20)
            $0.bottom.equalTo(scrollView.snp.bottom).offset(-20)
        }
    }
}
