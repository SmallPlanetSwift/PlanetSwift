//
// Autogenerated by gaxb at 10:39:28 AM on 12/12/14
//

import UIKit

public class View: ViewBase {
    public var view = UIView()

    public override func gaxbPrepare() {
		super.gaxbPrepare()
		
        if frame != nil {
            view.bounds = CGRectMake(0, 0, frame!.size.width, frame!.size.height)
            view.center = CGPointMake(CGRectGetMidX(frame!), CGRectGetMidY(frame!))
        }
        if color != nil {
            view.backgroundColor = color
        }
        if alpha != nil {
            view.alpha = CGFloat(alpha!)
        }
        if clipsToBounds != nil {
            view.clipsToBounds = clipsToBounds!
        }
        if hidden != nil {
            view.hidden = hidden!
        }
        if tag != nil {
            view.tag = tag!
        }
		if contentMode != nil {
            view.contentMode = View.contentModeFromEnum(contentMode!)
        }

		findParentView()?.view.addSubview(view)
    }
    
    public class func contentModeFromEnum(mode:PlanetUI.ContentMode) -> UIViewContentMode {
        
        switch(mode) {
        case .scaleToFill:
            return .ScaleToFill
        case .scaleAspectFit:
            return .ScaleAspectFit
        case .scaleAspectFill:
            return .ScaleAspectFill
        case .redraw:
            return .Redraw
        case .center:
            return .Center
        case .top:
            return .Top
        case .bottom:
            return .Bottom
        case .left:
            return .Left
        case .right:
            return .Right
        case .topLeft:
            return .TopLeft
        case .topRight:
            return .TopRight
        case .bottomLeft:
            return .BottomLeft
        case .bottomRight:
            return .BottomRight
        default:
            return .ScaleToFill
        }
    }
	
	internal func findParentView() -> View? {
		var parent:GaxbElement? = self.parent
		while parent != nil {
			
			if let view = parent as? View {
				return view
			}
			
			parent = parent!.parent
		}
		return nil
	}
	
}
