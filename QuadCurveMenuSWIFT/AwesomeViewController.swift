//
//  AwesomeViewController.swift
//  QuadCurveMenuSWIFT
//
//  Created by Abdullah Al-Ashi on 16/Sep/17.
//  Copyright © 2017 Abdullah Al-Ashi. All rights reserved.
//

import UIKit

class AwesomeViewController: UIViewController, QuadCurveMenuDelegate{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.init(patternImage: UIImage(named: "classy_fabric.png")!)
        let dataSource : AwesomeDataSource = AwesomeDataSource()
        let menu : QuadCurveMenu = QuadCurveMenu(frame: self.view.bounds, dataSource: dataSource)
        menu.delegate = self
        self.view.addSubview(menu)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func quadCurveMenudidTapMenu(menu: QuadCurveMenu, mainMenuItem: QuadCurveMenuItem) -> Void{
        print("Menu - Tapped")
    }
    
    func quadCurveMenudidLongPressMenu(menu : QuadCurveMenu, mainMenuItem: QuadCurveMenuItem) -> Void{
     print("Menu - Long Pressed")
    }
    
    
    func quadCurveMenuShouldExpand(menu : QuadCurveMenu) -> Bool{
        return true
    }
    
    func quadCurveMenuShouldClose(menu : QuadCurveMenu) -> Bool{
     return true
    }
    
    func quadCurveMenuWillExpand(menu : QuadCurveMenu) -> Void{
     print("Menu - Will Expand")
    }
    
    func quadCurveMenuDidExpand(menu : QuadCurveMenu) -> Void{
     print("Menu - Did Expand")
    }
    
    func quadCurveMenuWillClose(menu : QuadCurveMenu) -> Void{
     print("Menu - Will Close")
    }
    
    func quadCurveMenuDidClose(menu : QuadCurveMenu) -> Void{
     print("Menu - Did Close")
    }
    
    func quadCurveMenudidTapMenuItem(menu : QuadCurveMenu, MenuItem: QuadCurveMenuItem) -> Void{
        print("Menu Item (\(String(describing: MenuItem.dataObject))) - Tapped")
    }
    
    func quadCurveMenudidLongPressMenuItem(menu : QuadCurveMenu, MenuItem: QuadCurveMenuItem) -> Void{
     print("Menu Item (\(String(describing: MenuItem.dataObject))) - Long Pressed")
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
