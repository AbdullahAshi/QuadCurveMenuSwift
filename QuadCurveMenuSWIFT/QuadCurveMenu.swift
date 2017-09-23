//
//  QuadCurveMenu.swift
//  QuadCurveMenuSWIFT
//
//  Created by Abdullah Al-Ashi on 17/Sep/17.
//  Copyright © 2017 Abdullah Al-Ashi. All rights reserved.
//

import UIKit

let kQuadCurveMenuItemStartingTag : Int = 1000

class QuadCurveMenu: UIView {
    
    var menuDirector : QuadCurveMotionDirector
    
    var mainMenuItemFactory : QuadCurveMenuItemFactory
    var menuItemFactory : QuadCurveMenuItemFactory
    
    var selectedAnimation : QuadCurveAnimation
    var unselectedanimation : QuadCurveAnimation
    var expandItemAnimation : QuadCurveAnimation
    var closeItemAnimation : QuadCurveAnimation
    var mainMenuExpandAnimation : QuadCurveAnimation
    var mainMenuCloseAnimation : QuadCurveAnimation
    
    var delegate : QuadCurveMenuDelegate?
    {
        didSet
        {
            self.setupDelegate()
        }
    }
    var dataSource : QuadCurveDataSourceDelegate
    
    var mainMenuButton : QuadCurveMenuItem
    var centerPoint : CGPoint
    
    var expanding : Bool = false
    var delegateHasDidTapMainMenu : Bool = false
    var delegateHasDidLongPressMainMenu : Bool = false
    var delegateHasShouldExpand : Bool = false
    var delegateHasShouldClose : Bool = false
    var delegateHasWillExpand : Bool = false
    var delegateHasDidExpand : Bool = false
    var delegateHasWillClose : Bool = false
    var delegateHasDidClose : Bool = false
    var delegateHasDidTapMenuItem : Bool = false
    var delegateHasDidLongPressMenuItem : Bool = false
    
    
    convenience init(frame : CGRect, array : NSArray){
        self.init(frame: frame,
                  centerPoint: CGPoint(x: frame.size.width / 2, y: frame.size.height / 2),
                  dataSource: QuadCurveDefaultDataSource(WithArray: array),
                  mainFactory: QuadCurveDefaultMenuItemFactory.defaultMainMenuItemFactory(),
                  menuItemFactory: QuadCurveDefaultMenuItemFactory.defaultMenuItemFactory())
    }

    convenience init(frame : CGRect,
                     dataSource : QuadCurveDataSourceDelegate){
        self.init(frame: frame,
                  centerPoint: CGPoint(x: frame.size.width / 2, y: frame.size.height / 2),
                  dataSource: dataSource,
                  mainFactory: QuadCurveDefaultMenuItemFactory.defaultMainMenuItemFactory(),
                  menuItemFactory: QuadCurveDefaultMenuItemFactory.defaultMenuItemFactory())
    }
    
    convenience init(frame : CGRect,
         centerPoint : CGPoint,
         dataSource : QuadCurveDataSourceDelegate,
         mainFactory : QuadCurveMenuItemFactory,
         menuItemFactory: QuadCurveMenuItemFactory ){
        self.init(frame: frame,
                         centerPoint: centerPoint,
                         dataSource: dataSource,
                         mainFactory: mainFactory,
                         menuItemFactory: menuItemFactory,
                         motionDirector: QuadCurveRadialDirector())
    }
    
    init(frame : CGRect,
            centerPoint : CGPoint,
            dataSource : QuadCurveDataSourceDelegate,
            mainFactory : QuadCurveMenuItemFactory,
            menuItemFactory : QuadCurveMenuItemFactory,
            motionDirector : QuadCurveMotionDirector){

        self.selectedAnimation = QuadCurveBlowupAnimation()
        self.unselectedanimation = QuadCurveShrinkAnimation()
        
        self.expandItemAnimation = QuadCurveItemExpandAnimation()
        self.closeItemAnimation = QuadCurveItemCloseAnimation()
        
        self.mainMenuExpandAnimation = QuadCurveTiltAnimation.initWithCounterClockwiseTilt()
        self.mainMenuCloseAnimation = QuadCurveTiltAnimation.init(tiltDirection: 0.0)
        
        self.menuItemFactory = menuItemFactory
        self.menuDirector = motionDirector
        self.dataSource = dataSource
        self.centerPoint = centerPoint
        self.mainMenuItemFactory = mainFactory
        
        self.mainMenuButton = self.mainMenuItemFactory.createMenuItemWithDataObject(dataObject: nil)
        super.init(frame: frame)
        
        self.setMainMenuItemFactory()
        self.backgroundColor = UIColor.clear
        
        
        let singleTapGesture : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(singleTapInMenuView))
        self.addGestureRecognizer(singleTapGesture)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setMainMenuItemFactory() -> Void{
        mainMenuButton.removeFromSuperview()
        
        self.mainMenuButton.delegate = self;
        
        self.mainMenuButton.center = self.centerPoint;
        
        self.addSubview(self.mainMenuButton)
        
        self.setNeedsDisplay()

    }
    
    func expandMenu() -> Void{
        if !self.expanding
        {
            self.setExpanding(expanding: true)
        }
    }
    
    func closeMenu() -> Void{
        if self.expanding
        {
            self.setExpanding(expanding: false)
        }
    }
    
    @objc func singleTapInMenuView(tapGesture :UITapGestureRecognizer) -> Void
    {
        self.closeMenu()
    }
    
    func setupDelegate() -> Void{
        
        if let delegate = self.delegate
        {
            self.delegateHasDidTapMainMenu = delegate.responds(to: #selector(delegate.quadCurveMenudidTapMenu(menu:mainMenuItem:)))
            self.delegateHasDidLongPressMainMenu = delegate.responds(to: #selector(delegate.quadCurveMenudidLongPressMenu(menu:mainMenuItem:)))
            
            self.delegateHasDidTapMenuItem = delegate.responds(to: #selector(delegate.quadCurveMenudidTapMenuItem(menu:MenuItem:)))
            self.delegateHasDidLongPressMenuItem = delegate.responds(to: #selector(delegate.quadCurveMenudidLongPressMenuItem(menu:MenuItem:)))
            
            self.delegateHasShouldExpand = delegate.responds(to: #selector(delegate.quadCurveMenuShouldExpand(menu:)))
            self.delegateHasShouldClose = delegate.responds(to: #selector(delegate.quadCurveMenuShouldClose(menu:)))
            
            self.delegateHasWillExpand = delegate.responds(to: #selector(delegate.quadCurveMenuWillExpand(menu:)))
            self.delegateHasDidExpand = delegate.responds(to: #selector(delegate.quadCurveMenuDidExpand(menu:)))
            
            self.delegateHasWillClose = delegate.responds(to: #selector(delegate.quadCurveMenuWillClose(menu:)))
            self.delegateHasDidClose = delegate.responds(to: #selector(delegate.quadCurveMenuDidClose(menu:)))
        }
    }
    
    func numberOfDisplayableItems() -> Int{
        return self.dataSource.numberOfMenuItems()
    }
    
    func dataObjectAtIndex(index : Int) -> AnyObject{
        return self.dataSource.dataObjectAtIndex(itemIndex:index)
    }
    
    func menuItemAtIndex(index : Int) -> QuadCurveMenuItem
    {
        let item : UIView? = self.viewWithTag(kQuadCurveMenuItemStartingTag + index)
    
        if (item != nil)
        {
            return item as! QuadCurveMenuItem
        }
        else
        {
            return self.menuItemFactory.createMenuItemWithDataObject(dataObject: self.dataObjectAtIndex(index: index))
        }
    }
    
   
}


extension QuadCurveMenu : QuadCurveMenuItemEventDelegate{
    
    func quadCurveMenuItemLongPressed(item : QuadCurveMenuItem) -> Void{
        if (item == mainMenuButton)
        {
            self.mainMenuItemLongPressed()
        }
        else
        {
            self.menuItemLongPressed(item : item)
        }
    }
    
    func mainMenuItemLongPressed() -> Void{
        if (delegateHasDidLongPressMainMenu)
        {
            self.delegate?.quadCurveMenudidLongPressMenu(menu: self, mainMenuItem: mainMenuButton)
        }
    }
    
    func menuItemLongPressed(item : QuadCurveMenuItem) -> Void{
        if (delegateHasDidLongPressMenuItem)
        {
            self.delegate?.quadCurveMenudidLongPressMenuItem(menu: self, MenuItem: item)
        }
    
    }

    func quadCurveMenuItemTapped(item : QuadCurveMenuItem) -> Void{
        if (item === mainMenuButton)
        {
            self.mainMenuItemTapped()
        }
        else
        {
            self.menuItemTapped(item: item)
        }
    }
    
    func mainMenuItemTapped() -> Void{
        if (delegateHasDidTapMainMenu)
        {
            self.delegate?.quadCurveMenudidTapMenu(menu: self, mainMenuItem: mainMenuButton)
        }
        
        let willBeExpandingMenu : Bool = !self.expanding
        var shouldPerformAction : Bool = true
        
         if (willBeExpandingMenu && delegateHasShouldExpand)
         {
            shouldPerformAction = self.delegate!.quadCurveMenuShouldExpand(menu: self)
         }
         
         if ( !willBeExpandingMenu && delegateHasShouldClose)
         {
            shouldPerformAction = self.delegate!.quadCurveMenuShouldClose(menu: self)
         }
        
         if (shouldPerformAction)
         {
            self.setExpanding(expanding: willBeExpandingMenu)
         }
 
    }
    
    func menuItemTapped(item : QuadCurveMenuItem) -> Void{
        
        if (delegateHasDidTapMenuItem)
        {
            self.delegate?.quadCurveMenudidTapMenuItem(menu: self, MenuItem: item)
        }
        
        self.animateMenuItemsWithAnimation(items: [item], animation: self.selectedAnimation)
        
        var otherMenuItems : [UIView] = []
        if ( self.allMenuItemsBeingDisplayed().count > 0 )
        {
            otherMenuItems = ( self.allMenuItemsBeingDisplayed().filter({
                (subview) -> Bool in
                return (subview.tag != item.tag)
            }))
        }
        

        self.animateMenuItemsWithAnimation(items: otherMenuItems, animation: self.unselectedanimation)
        
        self.expanding = false
        
        self.animteExpandMainMenu(expandAnimation: expanding)
        
    }
    
    func allMenuItemsBeingDisplayed() -> [UIView]{
        
        var items : [UIView] = []
        if ((self.subviews.count) > 0)
        {
            items = (self.subviews.filter({
                (subview) -> Bool in
                return (subview.tag >= kQuadCurveMenuItemStartingTag) && (subview.tag <= (kQuadCurveMenuItemStartingTag + self.numberOfDisplayableItems()) )
            }))
        }
        
        return items
    }
    
    func animateMenuItemsWithAnimation(items : [UIView], animation : QuadCurveAnimation) -> Void{
        for item in items
        {
            if let itemQuadCurveAnimation = item as? QuadCurveMenuItem
            {
                let itemAnimation : CAAnimationGroup = animation.animationForItem(item: itemQuadCurveAnimation)
                itemQuadCurveAnimation.layer.add(itemAnimation, forKey: animation.animationName)
                itemQuadCurveAnimation.center = itemQuadCurveAnimation.startPoint!
            }
        }
    }
    
    func animteExpandMainMenu(expandAnimation : Bool ) -> Void{
        
        let animation : QuadCurveAnimation
        if (expandAnimation)
        {
            animation = self.mainMenuExpandAnimation
        }
        else
        {
            animation = self.mainMenuCloseAnimation
        }
        self.mainMenuButton.layer.add(animation.animationForItem(item: mainMenuButton), forKey: animation.animationName)
    }
    
    func setExpanding(expanding : Bool) -> Void{
        
        self.expanding = expanding
        
        self.animteExpandMainMenu(expandAnimation: self.expanding)
        
        if (self.expanding)
        {
            self.performExpandMenu()
        }
        else
        {
            self.performCloseMenu()
        }
    }
    
    func addMenuItemToViewAtPosition(item : QuadCurveMenuItem, position : NSRange){
        
        let index : Int = position.location
        let count : Int = position.length
        
        item.tag = kQuadCurveMenuItemStartingTag + index
        
        item.delegate = self;
        
        self.menuDirector.positionMenuItem(item: item, index: index, count: count, mainMenuItem: mainMenuButton)
        
        self.insertSubview(item, belowSubview: mainMenuButton)
    }
    
    func addMenuItemsToViewAndPerform(completionHandler: @escaping (_ item: QuadCurveMenuItem) -> Void) -> Void
    {
        let total : Int = self.numberOfDisplayableItems()
        
        for index in 0...(total-1)
        {
            let item : QuadCurveMenuItem = self.menuItemAtIndex(index: index)
            self.addMenuItemToViewAtPosition(item: item, position: NSMakeRange(index, total))
            completionHandler(item)
        }
    
    }
    
    func performExpandMenu() -> Void{
        if (delegateHasWillExpand)
        {
            self.delegate?.quadCurveMenuWillExpand(menu: self)
        }
        
        self.addMenuItemsToViewAndPerform(completionHandler: { item in
            item.center = item.startPoint!
        })
        
        
        let itemToBeAnimated : [UIView] = self.allMenuItemsBeingDisplayed()
        
        for x in 0...(itemToBeAnimated.count-1)
        {
            let item : QuadCurveMenuItem = itemToBeAnimated[x] as! QuadCurveMenuItem
            
            self.perform( #selector(self.animateMenuItemToEndPoint(item:)),
            with: item,
            afterDelay: (TimeInterval(self.closeItemAnimation.delayBetweenItemAnimation * CGFloat(x))))
        }
        
        if (delegateHasDidExpand)
        {
            self.delegate?.quadCurveMenuDidExpand(menu: self)
        }
        
    }
    
    
    @objc func animateMenuItemToEndPoint(item : QuadCurveMenuItem) -> Void{
        let expandAnimation : CAAnimationGroup = self.expandItemAnimation.animationForItem(item: item)
        item.layer.add(expandAnimation, forKey: self.expandItemAnimation.animationName)
        item.center = item.endPoint!
    }
    
    func performCloseMenu() -> Void{
        if (delegateHasWillClose)
        {
            self.delegate?.quadCurveMenuWillClose(menu: self)
        }
        
        let itemToBeAnimated : [UIView] = self.allMenuItemsBeingDisplayed()
        
        for x in 0...(itemToBeAnimated.count-1)
        {
            let item : QuadCurveMenuItem = itemToBeAnimated[x] as! QuadCurveMenuItem
            
            self.perform( #selector(self.animateItemToStartPoint(item:)),
                         with: item,
                         afterDelay: (TimeInterval(self.expandItemAnimation.delayBetweenItemAnimation * CGFloat(x))))
        }
        
        if (delegateHasDidClose)
        {
            self.delegate?.quadCurveMenuDidClose(menu: self)
        }
        
    }
    
    @objc func animateItemToStartPoint(item : QuadCurveMenuItem) -> Void
    {
        let closeAnimation : CAAnimationGroup = self.closeItemAnimation.animationForItem(item: item)
        item.layer.add(closeAnimation, forKey: self.closeItemAnimation.animationName)
        item.center = item.startPoint!
    }
    
}






















