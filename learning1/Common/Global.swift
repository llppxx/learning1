//
//  Global.swift
//  learning1
//
//  Created by Lipeixuan on 2026/7/14.
//
import UIKit
import SnapKit

public func __(_ text: String) -> String {
    return NSLocalizedString(text, tableName: "Localizable", bundle: Bundle.main, value: "", comment: "")
}
