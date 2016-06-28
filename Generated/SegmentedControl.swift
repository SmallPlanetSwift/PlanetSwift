//
// Autogenerated by gaxb at 02:06:09 PM on 02/06/15
//

import UIKit

public class SegmentedControl: SegmentedControlBase {
    lazy public var segmentedControl = UISegmentedControl()
    
    override public var control: UIControl? {
        get {
            return segmentedControl
        }
        set {
            if newValue is UISegmentedControl {
                segmentedControl = newValue as! UISegmentedControl
            }
        }
    }
    
    public override func gaxbPrepare() {
        super.gaxbPrepare()
        segmentedControl.tintColor = tintColor
        segmentedControl.setTitleTextAttributes(textAttributes(UIControlState()), for: UIControlState())
        segmentedControl.setTitleTextAttributes(textAttributes(.selected), for: .selected)
    }

    private func textAttributes(_ state: UIControlState) -> [NSObject : AnyObject]? {
        var attributes: [NSObject : AnyObject] = Dictionary()
        if state == UIControlState() {
            if textColorNormal != nil {
                attributes.updateValue(textColorNormal!, forKey: NSForegroundColorAttributeName)
            }
            if fontNormal != nil {
                let font = UIFont(name: fontNormal!, size:CGFloat(fontSizeNormal))!
                attributes.updateValue(font, forKey: NSFontAttributeName)
            }
            return attributes
        }
        if state == UIControlState.selected {
            if textColorSelected != nil {
                attributes.updateValue(textColorSelected!, forKey: NSForegroundColorAttributeName)
            }
            if fontSelected != nil {
                let font = UIFont(name: fontSelected!, size:CGFloat(fontSizeSelected))!
                attributes.updateValue(font, forKey: NSFontAttributeName)
            }
            return attributes
        }
        return nil
    }
    
}
