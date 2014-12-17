//
// Autogenerated by gaxb at 10:39:28 AM on 12/12/14
//

import UIKit

public class View: ViewBase {
    public var view = UIView()
    
    override func gaxbValueDidChange(name: String) {
        switch name {
        case "frame":
            view.frame = frame!
        case "color":
            view.backgroundColor = color
        case "alpha":
            view.alpha = CGFloat(alpha!)
        case "clipsToBounds":
            if clipsToBounds != nil {
                view.clipsToBounds = clipsToBounds!
            }
        case "hidden":
            if hidden != nil {
                view.hidden = hidden!
            }
        case "tag":
            if tag != nil {
                view.tag = tag!
            }
        default:
            break
        }
    }
    
    public func loadInto(parentView: UIView) {
        for child in views {
            child.loadInto(view)
        }
        parentView.addSubview(view)
    }
    
}
