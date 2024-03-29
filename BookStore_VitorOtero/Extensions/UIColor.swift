//
//  UIColor.swift
//  BookStore_VitorOtero
//
//  Created by VitorOtero on 14/12/2019.
//  Copyright © 2019 VitorOtero. All rights reserved.
//

import UIKit

extension UIColor {
    
    static func hex(value: UInt32) -> UIColor {
        let red = CGFloat((value & 0xFF0000) >> 16)
        let green = CGFloat((value & 0x00FF00) >> 8)
        let blue = CGFloat(value & 0x0000FF)
        return UIColor.rgba(red, green, blue)
    }
    
    static func rgba(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat, _ alpha: CGFloat = 1) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
    }
    
}
