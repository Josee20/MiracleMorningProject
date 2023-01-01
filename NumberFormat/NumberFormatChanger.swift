//
//  NumberFormatChanger.swift
//  MiracleMorningProject
//
//  Created by 이동기 on 2022/12/17.
//

import Foundation

class NumberFormatChange {
    
    private init() { }
    
    static let shared = NumberFormatChange()
    
    let percentFormat: NumberFormatter = {
        let numberFormat = NumberFormatter()
        numberFormat.numberStyle = .percent
        numberFormat.maximumFractionDigits = 1
        numberFormat.multiplier = 1
        numberFormat.percentSymbol = "%"
        return numberFormat
    }()
    
}
