//
//  Utils.swift
//  Tic-Tac-Toe_Mickens
//
//  Created by Maurice Mickens on 5/6/17.
//
//

import Foundation
import UIKit

struct ScreenSize {
    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height
    static let maxScreenLength = max(ScreenSize.screenWidth, ScreenSize.screenHeight)
    static let minScreenLength = min(ScreenSize.screenWidth, ScreenSize.screenHeight)
}

struct DeviceType {
    static let iPhone4OrLess = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxScreenLength < 568.0
    static let iPhone5 = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxScreenLength == 568.0
    static let iPhone6 = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxScreenLength == 667.0
    static let iPhone6Plus = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxScreenLength == 736.0
    static let iPad = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.maxScreenLength == 1024.0
    static let iPad_Pro = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.maxScreenLength == 1366.0
}
