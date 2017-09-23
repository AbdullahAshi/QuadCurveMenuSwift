//
//  AGMedallionView.swift
//  QuadCurveMenuSWIFT
//
//  Created by Abdullah Al-Ashi on 17/Sep/17.
//  Copyright © 2017 Abdullah Al-Ashi. All rights reserved.
//

import Foundation
import UIKit

class AGMedallionView: UIView {
    
    var image: UIImage
    {
        didSet
        {
            self.setNeedsDisplay()
        }
    }
    var highlightedImage:UIImage
    var borderColor : UIColor
    {
        didSet
        {
            self.setNeedsDisplay()
        }
    }
    var borderWidth :CGFloat?
    var shadowColor : UIColor
    var shadowOffset : CGSize
    var shadowBlur :CGFloat
    var highlighted : Bool
    var progressColor :UIColor
    var progress : CGFloat
    var alphaGradient: CGGradient
    {
                let colors : [CGFloat] = [1.0, 0.75, 1.0, 0.0, 0.0, 0.0]
                let colorStops : [CGFloat] = [1.0, 0.35, 0.0]
                let grayColorSpace : CGColorSpace = CGColorSpaceCreateDeviceGray()
                return CGGradient(colorSpace: grayColorSpace, colorComponents: colors, locations: colorStops, count: 3)!
    }
 
    func DEGREES_2_RADIANS(_ x: Double) -> CGFloat{
        return CGFloat(0.0174532925 * (x))
    }
    
    func setBorderWidth(aBorderWidth: CGFloat) -> Void{
        if (borderWidth != aBorderWidth)
        {
            borderWidth = aBorderWidth
            
            self.setNeedsDisplay()
        }
    }
    
    func setShadowColor(aShadowColor: UIColor) -> Void{
        if (shadowColor != aShadowColor)
        {
            shadowColor = aShadowColor
            
            self.setNeedsDisplay()
        }
    }
    
    func setShadowOffset(aShadowOffset: CGSize) -> Void{
        if (!shadowOffset.equalTo(aShadowOffset))
        {
            shadowOffset.width = aShadowOffset.width;
            shadowOffset.height = aShadowOffset.height;
            
            self.setNeedsDisplay()
        }
    }
    
    func setShadowBlur(aShadowBlur: CGFloat) -> Void{
        if (shadowBlur != aShadowBlur)
        {
            shadowBlur = aShadowBlur
            
            self.setNeedsDisplay()
        }
    }
    
    func setProgress(aProgress: CGFloat) -> Void{
        if (progress != aProgress)
        {
            progress = aProgress
            
            self.setNeedsDisplay()
        }
    }
    
    func setup() -> Void
    {
        self.borderColor = UIColor.white
        self.borderWidth = 5.0
        self.shadowColor = UIColor(red: 0.25, green: 0.25, blue: 0.25, alpha: 0.75)
        self.shadowOffset = CGSize(width: 0, height: 0)
        self.shadowBlur = 2.0;
        self.backgroundColor = UIColor.clear
        self.progress = 0.0;
        self.progressColor = UIColor.gray
    }
    
    convenience init()
    {
        self.init(frame: CGRect(x: 0.0, y: 0.0, width: 128, height: 128))
    }
    
    override init(frame: CGRect) {
        self.image = UIImage()
        self.highlightedImage = UIImage()
        self.borderColor = UIColor.white
        self.borderWidth = 5.0
        self.shadowColor = UIColor(red: 0.25, green: 0.25, blue: 0.25, alpha: 0.75)
        self.shadowOffset = CGSize(width: 0, height: 0)
        self.shadowBlur = 2.0;
        self.progress = 0.0;
        self.progressColor = UIColor.gray
        self.highlighted = false
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear

    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder)
    {
        self.image = UIImage()
        self.highlightedImage = UIImage()
        self.borderColor = UIColor.white
        self.borderWidth = 5.0
        self.shadowColor = UIColor(red: 0.25, green: 0.25, blue: 0.25, alpha: 0.75)
        self.shadowOffset = CGSize(width: 0, height: 0)
        self.shadowBlur = 2.0;
        self.progress = 0.0;
        self.progressColor = UIColor.gray
        self.highlighted = false
        super.init(coder: aDecoder)
        self.backgroundColor = UIColor.clear
    }
    
    
    override func draw(_ rect: CGRect){
        
        let imageRect : CGRect = CGRect(x: (self.borderWidth)!,
                                        y: (self.borderWidth)!,
                                        width: rect.size.width - (self.borderWidth! * 2),
                                        height: rect.size.height - (self.borderWidth! * 2))
        
        let maskColorSpaceRef : CGColorSpace  = CGColorSpaceCreateDeviceGray();
        
        let mainMaskContextRef : CGContext  = CGContext(data: nil,
                                                        width: Int(rect.size.width),
                                                        height: Int(rect.size.height),
                                                        bitsPerComponent: 8,
                                                        bytesPerRow: Int(rect.size.width),
                                                        space: maskColorSpaceRef,
                                                        bitmapInfo: 0)!
        
        let shineMaskContextRef : CGContext  = CGContext(data: nil,
                                                         width: Int(rect.size.width),
                                                         height: Int(rect.size.height),
                                                         bitsPerComponent: 8,
                                                         bytesPerRow: Int(rect.size.width),
                                                         space: maskColorSpaceRef,
                                                         bitmapInfo: 0)!
        
        mainMaskContextRef.setFillColor(UIColor.black.cgColor)
        shineMaskContextRef.setFillColor(UIColor.black.cgColor)
        
        mainMaskContextRef.fill(rect)
        shineMaskContextRef.fill(rect)
        
        mainMaskContextRef.setFillColor(UIColor.white.cgColor)
        shineMaskContextRef.setFillColor(UIColor.white.cgColor)
        
        mainMaskContextRef.move(to: CGPoint(x: 0, y: 0))
        mainMaskContextRef.addEllipse(in: imageRect)
        mainMaskContextRef.fillPath()
        
        
        shineMaskContextRef.translateBy(x: -(rect.size.width / 4),
                                        y: rect.size.height / 4 * 3)
        shineMaskContextRef.rotate(by: -45.0)
        shineMaskContextRef.move(to: CGPoint(x: 0, y: 0))
        
        shineMaskContextRef.fill(CGRect(x: 0,
                                        y: 0,
                                        width: rect.size.width / 8 * 5,
                                        height: rect.size.height))
        

        let mainMaskImageRef : CGImage = mainMaskContextRef.makeImage()!
        let shineMaskImageRef : CGImage = shineMaskContextRef.makeImage()!
        
        let contextRef : CGContext = UIGraphicsGetCurrentContext()!;
        contextRef.saveGState();
        
        let currentImage : UIImage = (self.highlighted ? self.highlightedImage : self.image)
        
        let imageRef : CGImage  = currentImage.cgImage!.masking(mainMaskImageRef)!
        
        contextRef.translateBy(x: 0, y: rect.size.height)
        contextRef.scaleBy(x: 1.0, y: -1.0)
        
        contextRef.saveGState()
        
        contextRef.draw(imageRef, in: rect)
        
        contextRef.restoreGState()
        contextRef.saveGState()
        
        contextRef.clip(to: self.bounds, mask: mainMaskImageRef)
        contextRef.clip(to: self.bounds, mask: shineMaskImageRef)
        contextRef.setBlendMode(CGBlendMode.lighten)
        contextRef.drawLinearGradient(self.alphaGradient, start: CGPoint(x: 0, y: 0), end: CGPoint(x: 0, y: self.bounds.size.height), options: CGGradientDrawingOptions.init(rawValue: 0))
        
        contextRef.restoreGState()
        
        contextRef.setLineWidth(self.borderWidth!)
        contextRef.setStrokeColor(self.borderColor.cgColor)
        contextRef.move(to: CGPoint(x: 0, y: 0))
        contextRef.addEllipse(in: imageRect)
        
        contextRef.setShadow(offset: self.shadowOffset,
                             blur: self.shadowBlur,
                             color: self.shadowColor.cgColor);
        contextRef.strokePath();
        contextRef.restoreGState();
        
        contextRef.saveGState();
        
        let centerPoint : CGPoint = CGPoint(x: imageRect.origin.x + imageRect.size.width / 2,
                                            y: imageRect.origin.y + imageRect.size.height / 2)
        
        if (self.progress != 0.0) {
            
            let radius : CGFloat = CGFloat(imageRect.size.height / 2)
            let endAngle : CGFloat = DEGREES_2_RADIANS( Double(self.progress * 359.9) - 90.0)
            let startAngle : CGFloat = DEGREES_2_RADIANS(270)
            
            let progressPath : CGMutablePath = CGMutablePath()
            progressPath.addArc(center: centerPoint, radius: radius, startAngle: CGFloat(startAngle), endAngle: CGFloat(endAngle), clockwise: false)
            
            contextRef.setStrokeColor(self.progressColor.cgColor)
            contextRef.setLineWidth(3.0)
            contextRef.addPath(progressPath)
            contextRef.strokePath()
        }
        
        contextRef.restoreGState();
    }
    
}


















