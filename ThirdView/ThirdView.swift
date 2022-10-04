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
        view.layer.cornerRadius = 10
        view.semanticContentAttribute = UIApplication.shared
            .userInterfaceLayoutDirection == .rightToLeft ? .forceLeftToRight : .forceRightToLeft
        return view
    }()
    
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
    
    let currentMonthSchedulePercentageChart: PieChartView = {
        let view = PieChartView()
        
        // 카테고리 텍스트 컬러
        view.entryLabelColor = .black
        
        // centerText속성
        let text = "성공 스케쥴\n   TOP8"
        let textFont = UIFont.boldSystemFont(ofSize: 13)
        let attributes: [NSAttributedString.Key: Any] = [
            .font: textFont,
        ]
        view.centerAttributedText = NSAttributedString(string: text, attributes: attributes)
        
        // 원 안쪽 크기 조절
        view.usePercentValuesEnabled = true
        view.drawSlicesUnderHoleEnabled = false
        view.holeRadiusPercent = 0.35
        view.transparentCircleRadiusPercent = 0.38
        view.noDataText = "성공한 스케쥴이 없습니다."
        view.noDataTextColor = .failColor
        view.noDataFont = .boldSystemFont(ofSize: 15)
        
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
            $0.leadingMargin.equalTo(36)
            $0.topMargin.equalTo(20)
        }
        
        currentMonthSuccessChart.snp.makeConstraints {
            $0.topMargin.equalTo(monthPickerButton.snp.bottom).offset(28)
            $0.leadingMargin.equalTo(40)
            $0.trailingMargin.equalTo(-40)
            $0.height.equalTo(currentMonthSchedulePercentageChart.snp.height)
            $0.bottomMargin.equalTo(currentMonthSchedulePercentageChart.snp.top).offset(-20)
            
            $0.centerX.equalTo(self)
        }
        
        currentMonthSchedulePercentageChart.snp.makeConstraints {
            $0.leadingMargin.equalTo(40)
            $0.trailingMargin.equalTo(-40)
            $0.bottomMargin.equalTo(-40)
            $0.centerX.equalTo(self)
        }
        
        borderWithTabBar.snp.makeConstraints {
            $0.width.equalTo(UIScreen.main.bounds.width)
            $0.height.equalTo(1)
            $0.bottom.equalTo(self.safeAreaLayoutGuide).offset(-12)
        }
    }
}
