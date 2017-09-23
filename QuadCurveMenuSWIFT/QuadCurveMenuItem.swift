//
//  QuadCurveMenuItem.swift
//  QuadCurveMenuSWIFT
//
//  Created by Abdullah Al-Ashi on 17/Sep/17.
//  Copyright © 2017 Abdullah Al-Ashi. All rights reserved.
//

import Foundation
import UIKit
@objc
class QuadCurveMenuItem : UIControl
{
    var dataObject : Any?
    
    var startPoint : CGPoint?
    var endPoint : CGPoint?
    var nearPoint : CGPoint?
    var farPoint : CGPoint?
    var delegate : QuadCurveMenuItemEventDelegate?
    {
        didSet
        {
            self.setupDelegate()
        }
    }
    
    var delegateHasLongPressed : Bool = false
    var delegateHasTapped : Bool = false
    
    var image : UIImage
    {
        get
        {
            return contentImageView!.image
        }
        set(newImage)
        {
            contentImageView!.image = newImage
        }
    }
    
    var highlightedImage : UIImage
    {
        get
        {
            return contentImageView!.highlightedImage
        }
        set(newHighlightedImage)
        {
            contentImageView!.highlightedImage = newHighlightedImage
        }
    }
    
    var contentImageView : AGMedallionView?
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(image : UIImage, highlightedImage : UIImage)
    {
        //super.init()
        super.init(frame: CGRect(x: 0.0, y: 0.0, width: 0.0, height: 0.0))
        
        self.isUserInteractionEnabled = true
        
        contentImageView = AGMedallionView()
        
        self.image = image
        
        self.highlightedImage = highlightedImage
        
        self.addSubview(contentImageView!)
        
        self.frame = CGRect(x: self.center.x - self.image.size.width/2,
               y: self.center.y - self.image.size.height/2,
               width: self.image.size.width,
               height: self.image.size.height)
        
        let longPressGesture : UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressOnMenuItem))
        
        self.addGestureRecognizer(longPressGesture)
        
        let singleTapGesture : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(singleTapOnMenuItem))
        
        self.addGestureRecognizer(singleTapGesture)
        
        self.isUserInteractionEnabled = true
        
    }
    
    func setupDelegate() -> Void{
        
        if let delegate = self.delegate
        {
            self.delegateHasLongPressed = delegate.responds(to: #selector(delegate.quadCurveMenuItemLongPressed(item:)))
            self.delegateHasTapped = delegate.responds(to: #selector(delegate.quadCurveMenuItemTapped(item:)))
        }
    }
    
    @objc func longPressOnMenuItem(sender : UILongPressGestureRecognizer) -> Void{
        if (delegateHasLongPressed)
        {
            delegate!.quadCurveMenuItemLongPressed(item: self)
        }
    }
    
    @objc func singleTapOnMenuItem(sender : UITapGestureRecognizer) -> Void{
        if (delegateHasTapped)
        {
            delegate!.quadCurveMenuItemTapped(item: self)
        }
    }
    
    override func layoutSubviews() -> Void {
        
        super.layoutSubviews()
        self.frame = CGRect(x: self.center.x - self.image.size.width/2, y: self.center.y - self.image.size.height/2, width: self.image.size.width, height: self.image.size.height)
        
        let width = self.image.size.width;
        let  height = self.image.size.height;
        
        contentImageView!.frame = CGRect(x: 0.0, y: 0.0, width: width, height: height)
    }
    
    func setImage(image : UIImage) -> Void{
        contentImageView!.image = image;
    }
    
    func setHighlightedImage(highlightedImage : UIImage) -> Void{
        contentImageView!.highlightedImage = highlightedImage;
    }
    
    func setHighlighted(highlighted : Bool) -> Void
    {
        super.isHighlighted = highlighted
        contentImageView!.highlighted = highlighted
    }
    
}
