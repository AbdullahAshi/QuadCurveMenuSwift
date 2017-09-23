//
//  QuadCurveDefaultMenuItemFactory.swift
//  QuadCurveMenuSWIFT
//
//  Created by Abdullah Al-Ashi on 17/Sep/17.
//  Copyright © 2017 Abdullah Al-Ashi. All rights reserved.
//

import Foundation
import UIKit

class QuadCurveDefaultMenuItemFactory: NSObject, QuadCurveMenuItemFactory  {

    var image : UIImage
    var highlightImage : UIImage?
    
    
    init(image : UIImage, highlightImage : UIImage?)
    {
        self.image = image
        self.highlightImage = highlightImage
        super.init()
    }
    
    init(image : UIImage)
    {
        self.image = image
        self.highlightImage = nil
        super.init()
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createMenuItemWithDataObject(dataObject : AnyObject?) -> QuadCurveMenuItem{
       
        var item : QuadCurveMenuItem
        if (highlightImage != nil)
        {
            item = QuadCurveMenuItem(image: image, highlightedImage: highlightImage!)
        }
        else
        {
            item = QuadCurveMenuItem(image: image, highlightedImage: image)
        }
        
        if dataObject != nil
        {
            item.dataObject = dataObject!
        }
        
        return item;
    }
    
    static func defaultMenuItemFactory() -> QuadCurveDefaultMenuItemFactory
    {
        return QuadCurveDefaultMenuItemFactory(image: UIImage(named: "icon-star.png")!)
    }
    
    static func defaultMainMenuItemFactory() -> QuadCurveDefaultMenuItemFactory
    {
        return QuadCurveDefaultMenuItemFactory(image: UIImage(named: "icon-plus.png")!)
    }
    
}
