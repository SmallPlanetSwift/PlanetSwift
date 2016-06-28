//
// Autogenerated by gaxb at 11:46:44 AM on 02/24/15
//

import UIKit

public class Control: ControlBase {
	
	public var control:UIControl?
	override public var view: UIView {
		get {
			if control != nil {
				return control!
			}
			return super.view
		}
		set {
			if newValue is UIControl {
				control = (newValue as! UIControl)
			}
		}
	}
	
	public override func gaxbPrepare() {
		super.gaxbPrepare()
		
		if let control = control {
			
			if enabled != nil {
				control.isEnabled = enabled!
			}
			if selected != nil {
				control.isSelected = selected!
			}
			if highlighted != nil {
				control.isHighlighted = highlighted!
			}
		}
	}
}
