//
//  TimerView.swift
//  MiracleMorningProject
//
//  Created by 이동기 on 2022/09/12.
//

import UIKit

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
        // 회색테두리 Path를 어디까지 그릴 것인지 (1이면 처음부터 끝까지)
        layer.strokeEnd = 1
        layer.fillColor = UIColor.clear.cgColor
//        layer.fillColor = UIColor.green.cgColor
        layer.strokeColor = Const.backgroundStrokeColor
        return layer
    }()
    
    public let progressLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.lineWidth = Const.progressLineWidth
        // 주황색 테두리 Path 0부터시작
        layer.strokeEnd = 0
        layer.fillColor = UIColor.clear.cgColor
//        layer.fillColor = UIColor.black.cgColor
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
        // UIBezierPath로 그린 원을 backgroundLayer(회색테두리), progressLayer(주황색테두리)가 따라가게 해줌
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
    
    func start(duration: TimeInterval, value: Double) {
        self.progressLayer.removeAnimation(forKey: "progress")
        let circularProgressAnimation = CABasicAnimation(keyPath: "strokeEnd")
        circularProgressAnimation.duration = duration
        circularProgressAnimation.fromValue = 0
        circularProgressAnimation.toValue = value
        circularProgressAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        
        // -0.9 ... -0.8 하다가 결국 1이됨
        self.progressLayer.strokeEnd = CGFloat(value)
        self.progressLayer.add(circularProgressAnimation, forKey: "progress")
    }
}
