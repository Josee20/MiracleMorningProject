//
//  ReusableProtocol.swift
//  MiracleMorningProject
//
//  Created by 이동기 on 2022/09/11.
//

import Foundation
import UIKit

protocol ReusableProtocol: AnyObject {
    static var reuseIdentifier: String { get }
}

extension UIViewController: ReusableProtocol {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReusableProtocol {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
