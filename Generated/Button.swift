//
// Autogenerated by gaxb at 11:23:55 PM on 01/11/15
//

import UIKit

public class Button: ButtonBase {
    
    lazy public var button: PlanetButton = PlanetButton()
    override public var control: UIControl? {
        get {
            return button
        }
        set {
            if newValue is PlanetButton {
                button = newValue as! PlanetButton
            }
        }
    }
    
    public func updateTitle(text: String?, forState state: UIControlState = .Normal) {
        button.setTitle(text.map{NSLocalizedString($0, comment:"")}, forState:state)
    }
    
    public override func gaxbPrepare() {
        super.gaxbPrepare()
        
        if onTouchUp != nil {
            button.addTarget(self, action: Selector("buttonOnTouchUp:"), forControlEvents: .TouchUpInside)
        }
        if onTouchDown != nil {
            button.addTarget(self, action: Selector("buttonOnTouchDown:"), forControlEvents: .TouchDown)
        }
        button.tintColor = tintColor
        
        updateTitle(title, forState: .Normal)
        updateTitle(titleHighlighted, forState: .Highlighted)
        updateTitle(titleSelected, forState: .Selected)
        updateTitle(titleSelectedHighlighted, forState: [.Selected, .Highlighted])
        updateTitle(titleDisabled, forState: .Disabled)
        
        button.setTitleColor(titleFontColor, forState: .Normal)
        button.setTitleColor(titleFontColorHighlighted, forState: .Highlighted)
        button.setTitleColor(titleFontColorSelected, forState: .Selected)
        button.setTitleColor(titleFontColorSelectedHighlighted, forState: [.Selected, .Highlighted])
        button.setTitleColor(titleFontColorDisabled, forState: .Disabled)
        
        if titleFont != nil {
            button.titleLabel?.font = UIFont(name: titleFont!, size: UIFont.systemFontSize())
        }
        if titleFontSize != nil {
            button.titleLabel?.font = button.titleLabel?.font.fontWithSize(CGFloat(titleFontSize!))
        }
        
        if backgroundImage != nil {
            let img = UIImage(gaxbString: backgroundImage)
            button.setBackgroundImage(img, forState: .Normal)
        }
        if backgroundImageHighlighted != nil {
            let img = UIImage(gaxbString: backgroundImageHighlighted)
            button.setBackgroundImage(img, forState: .Highlighted)
        }
        if backgroundImageSelected != nil {
            let img = UIImage(gaxbString: backgroundImageSelected)
            button.setBackgroundImage(img, forState: .Selected)
        }
        if backgroundImageSelectedHighlighted != nil {
            let img = UIImage(gaxbString: backgroundImageSelectedHighlighted)
            button.setBackgroundImage(img, forState: [.Selected, .Highlighted])
        }
        if backgroundImageDisabled != nil {
            let img = UIImage(gaxbString: backgroundImageDisabled)
            button.setBackgroundImage(img, forState: .Disabled)
        }
        
        if image != nil {
            let img = UIImage(gaxbString: image)
            button.setImage(img, forState: .Normal)
        }
        if imageHighlighted != nil {
            let img = UIImage(gaxbString: imageHighlighted!)
            button.setImage(img, forState: .Highlighted)
        }
        if imageSelected != nil {
            let img = UIImage(gaxbString: imageSelected)
            button.setImage(img, forState: .Selected)
        }
        if imageSelectedHighlighted != nil {
            let img = UIImage(gaxbString: imageSelectedHighlighted)
            button.setImage(img, forState: [.Selected, .Highlighted])
        }
        if imageDisabled != nil {
            let img = UIImage(gaxbString: imageDisabled)
            button.setImage(img, forState: .Disabled)
        }
        
        if let imageSet = imageSet {
            let pathLength = imageSet.characters.count
            let extensionLength = imageSet.componentsSeparatedByString(".").last?.characters.count ?? 0
            let insertPosition = pathLength - extensionLength - ( extensionLength > 0 ? 1 : 0 )
            
            let normalPath = imageSet.substringToIndex(imageSet.startIndex.advancedBy(insertPosition)) + "_normal" + imageSet.substringFromIndex(imageSet.startIndex.advancedBy(insertPosition))
            let highlightedPath = imageSet.substringToIndex(imageSet.startIndex.advancedBy(insertPosition)) + "_highlighted" + imageSet.substringFromIndex(imageSet.startIndex.advancedBy(insertPosition))
            let selectedPath = imageSet.substringToIndex(imageSet.startIndex.advancedBy(insertPosition)) + "_selected" + imageSet.substringFromIndex(imageSet.startIndex.advancedBy(insertPosition))
            let selectedHighlightedPath = imageSet.substringToIndex(imageSet.startIndex.advancedBy(insertPosition)) + "_selected_highlighted" + imageSet.substringFromIndex(imageSet.startIndex.advancedBy(insertPosition))
            let disabledPath = imageSet.substringToIndex(imageSet.startIndex.advancedBy(insertPosition)) + "_disabled" + imageSet.substringFromIndex(imageSet.startIndex.advancedBy(insertPosition))
            
            var img = UIImage(contentsOfFile: String(bundlePath: normalPath)) ?? UIImage(contentsOfFile: String(bundlePath: imageSet))
            button.setImage(img, forState: .Normal)
            img = UIImage(contentsOfFile: String(bundlePath: highlightedPath))
            button.setImage(img, forState: .Highlighted)
            img = UIImage(contentsOfFile: String(bundlePath: selectedPath))
            button.setImage(img, forState: .Selected)
            img = UIImage(contentsOfFile: String(bundlePath: selectedHighlightedPath))
            button.setImage(img, forState: [.Selected, .Highlighted])
            img = UIImage(contentsOfFile: String(bundlePath: disabledPath))
            button.setImage(img, forState: .Disabled)
        }
        
        if let backgroundImageSet = backgroundImageSet {
            let pathLength = backgroundImageSet.characters.count
            let extensionLength = backgroundImageSet.componentsSeparatedByString(".").last?.characters.count ?? 0
            let insertPosition = pathLength - extensionLength - (extensionLength > 0 ? 1 : 0)
            
            let normalPath = backgroundImageSet.substringToIndex(backgroundImageSet.startIndex.advancedBy(insertPosition)) + "_normal" + backgroundImageSet.substringFromIndex(backgroundImageSet.startIndex.advancedBy(insertPosition))
            let highlightedPath = backgroundImageSet.substringToIndex(backgroundImageSet.startIndex.advancedBy(insertPosition)) + "_highlighted" + backgroundImageSet.substringFromIndex(backgroundImageSet.startIndex.advancedBy(insertPosition))
            let selectedPath = backgroundImageSet.substringToIndex(backgroundImageSet.startIndex.advancedBy(insertPosition)) + "_selected" + backgroundImageSet.substringFromIndex(backgroundImageSet.startIndex.advancedBy(insertPosition))
            let selectedHighlightedPath = backgroundImageSet.substringToIndex(backgroundImageSet.startIndex.advancedBy(insertPosition)) + "_selected_highlighted" + backgroundImageSet.substringFromIndex(backgroundImageSet.startIndex.advancedBy(insertPosition))
            let disabledPath = backgroundImageSet.substringToIndex(backgroundImageSet.startIndex.advancedBy(insertPosition)) + "_disabled" + backgroundImageSet.substringFromIndex(backgroundImageSet.startIndex.advancedBy(insertPosition))
            
            var img = UIImage(contentsOfFile: String(bundlePath: normalPath)) ?? UIImage(contentsOfFile: String(bundlePath: backgroundImageSet))
            button.setBackgroundImage(img, forState: .Normal)
            img = UIImage(contentsOfFile: String(bundlePath: highlightedPath))
            button.setBackgroundImage(img, forState: .Highlighted)
            img = UIImage(contentsOfFile: String(bundlePath: selectedPath))
            button.setBackgroundImage(img, forState: .Selected)
            img = UIImage(contentsOfFile: String(bundlePath: selectedHighlightedPath))
            button.setBackgroundImage(img, forState: [.Selected, .Highlighted])
            img = UIImage(contentsOfFile: String(bundlePath: disabledPath))
            button.setBackgroundImage(img, forState: .Disabled)
        }
		
        button.backgroundColorNormal = backgroundColor
        button.backgroundColorHighlighted = backgroundColorHighlighted
        button.backgroundColorSelected = backgroundColorSelected
        button.backgroundColorSelectedHighlighted = backgroundColorSelectedHighlighted
        button.backgroundColorDisabled = backgroundColorDisabled
        
        button.isToggle = isToggle
        if contentEdgeInsets != nil {
            button.contentEdgeInsets = contentEdgeInsets!
        }
        if titleEdgeInsets != nil {
            button.titleEdgeInsets = titleEdgeInsets!
        }
        if imageEdgeInsets != nil {
            button.imageEdgeInsets = imageEdgeInsets!
        }
    }
    
    @objc func buttonOnTouchUp(sender:UIButton!)
    {
        if onTouchUp != nil {
            let (scopeObject, name) = self.parseNotification(onTouchUp)
            if name != nil {
                NSNotificationCenter.defaultCenter().postNotificationName(name!, object: scopeObject)  // todo scope
            }
        }
    }
    
    @objc func buttonOnTouchDown(sender:UIButton!)
    {
        if onTouchDown != nil {
            let (scopeObject, name) = self.parseNotification(onTouchDown)
            if name != nil {
                NSNotificationCenter.defaultCenter().postNotificationName(name!, object: scopeObject)  // todo scope
            }
        }
    }
}
