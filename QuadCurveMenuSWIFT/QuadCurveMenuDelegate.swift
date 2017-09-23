//
//  QuadCurveMenuDelegate.swift
//  QuadCurveMenuSWIFT
//
//  Created by Abdullah Al-Ashi on 16/Sep/17.
//  Copyright © 2017 Abdullah Al-Ashi. All rights reserved.
//

import Foundation

@objc protocol QuadCurveMenuDelegate : NSObjectProtocol {
    
    func quadCurveMenudidTapMenu(menu: QuadCurveMenu, mainMenuItem : QuadCurveMenuItem) -> Void
    func quadCurveMenudidLongPressMenu(menu : QuadCurveMenu, mainMenuItem: QuadCurveMenuItem) -> Void
    
    func quadCurveMenuShouldExpand(menu : QuadCurveMenu) -> Bool
    func quadCurveMenuShouldClose(menu : QuadCurveMenu) -> Bool
    
    func quadCurveMenuWillExpand(menu : QuadCurveMenu) -> Void
    func quadCurveMenuDidExpand(menu : QuadCurveMenu) -> Void
    
    func quadCurveMenuWillClose(menu : QuadCurveMenu) -> Void
    func quadCurveMenuDidClose(menu : QuadCurveMenu) -> Void
    
    func quadCurveMenudidTapMenuItem(menu : QuadCurveMenu, MenuItem: QuadCurveMenuItem) -> Void
    func quadCurveMenudidLongPressMenuItem(menu : QuadCurveMenu, MenuItem: QuadCurveMenuItem) -> Void

}
