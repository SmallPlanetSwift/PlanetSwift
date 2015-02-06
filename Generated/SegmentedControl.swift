//
// Autogenerated by gaxb at 02:06:09 PM on 02/06/15
//

import UIKit

public class SegmentedControl: SegmentedControlBase {
    lazy public var segmentedControl = UISegmentedControl()
    
    override public var view: UIView {
        get {
            return segmentedControl
        }
        set {
            if newValue is UISegmentedControl {
                segmentedControl = newValue as UISegmentedControl
            }
        }
    }
    
    public override func gaxbPrepare() {
        super.gaxbPrepare()
        segmentedControl.tintColor = tintColor
        segmentedControl.setTitleTextAttributes(textAttributes(.Normal), forState: .Normal)
    }

    private func textAttributes(state: UIControlState) -> [NSObject : AnyObject]? {
        var attributes: [NSObject : AnyObject] = Dictionary()
        if state == UIControlState.Normal {
            if textColorNormal != nil {
                attributes.updateValue(textColorNormal!, forKey: NSForegroundColorAttributeName)
            }
            if fontNormal != nil {
                let font = UIFont(name: fontNormal!, size: CGFloat(fontSizeNormal))
                attributes.updateValue(font!, forKey: NSForegroundColorAttributeName)
            }
            return attributes
        }
        return nil
    }
    
}
