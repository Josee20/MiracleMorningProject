//
//  ThirdView.swift
//  MiracleMorningProject
//
//  Created by 이동기 on 2022/09/11.
//

import UIKit

import Charts

class ThirdView: BaseView {
      
    let monthPickerButton: UIButton = {
        let pointSize: CGFloat = 8
        let view = UIButton()
        let imageConfig = UIImage.SymbolConfiguration(pointSize: pointSize)
        
        
        var config = UIButton.Configuration.plain()
        config.preferredSymbolConfigurationForImage = imageConfig
        view.configuration = config

        view.setTitleColor(UIColor.darkGray, for: .normal)
        view.setImage(UIImage(systemName: "arrowtriangle.down.fill"), for: .normal)
        view.tintColor = .black
        view.contentMode = .scaleToFill
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 15
        view.semanticContentAttribute = UIApplication.shared
            .userInterfaceLayoutDirection == .rightToLeft ? .forceLeftToRight : .forceRightToLeft
        return view
    }()
    
    let currentMonthSuccessChart: PieChartView = {
        let view = PieChartView()
        return view
    }()
    
    let currentMonthSchedulePercentageChart: PieChartView = {
        let view = PieChartView()
        return view
    }()
    
    let borderWithTabBar: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.systemGray3.cgColor
        return view
    }()
    
    override func configureUI() {
        [monthPickerButton, currentMonthSuccessChart, currentMonthSchedulePercentageChart, borderWithTabBar].forEach { self.addSubview($0) }
    }
    
    override func setConstraints() {
        
        monthPickerButton.snp.makeConstraints {
            $0.width.equalTo(150)
            $0.height.equalTo(60)
            $0.centerX.equalTo(self)
            $0.topMargin.equalTo(20)
        }
        
        currentMonthSuccessChart.snp.makeConstraints {
            $0.topMargin.equalTo(monthPickerButton.snp.bottom).offset(20)
            $0.width.height.equalTo(280)
            $0.centerX.equalTo(self)
        }
        
        currentMonthSchedulePercentageChart.snp.makeConstraints {
            $0.width.height.equalTo(280)
            $0.topMargin.equalTo(currentMonthSuccessChart.snp.bottom).offset(12)
            $0.centerX.equalTo(self)
        }
        
        borderWithTabBar.snp.makeConstraints {
            $0.width.equalTo(UIScreen.main.bounds.width)
            $0.height.equalTo(1)
            $0.bottom.equalTo(self.safeAreaLayoutGuide).offset(-12)
        }
    }
}
