//
// Autogenerated by gaxb at 05:04:35 PM on 02/19/15
//

import UIKit

public class GestureRecognizer: GestureRecognizerBase {
	
	public var recognizer:UIGestureRecognizer?
	private lazy var helper = GestureRecognizerHelper()
	
	public override func gaxbPrepare() {
		super.gaxbPrepare()
		
		if let recognizer = recognizer {
			
			if cancelsTouchesInView != nil {
				recognizer.cancelsTouchesInView = cancelsTouchesInView!
			}
			if delaysTouchesBegan != nil {
				recognizer.delaysTouchesBegan = delaysTouchesBegan!
			}
			if delaysTouchesEnded != nil {
				recognizer.delaysTouchesEnded = delaysTouchesEnded!
			}
			
			if onStateChange != nil {
				helper.delegate = self;
				recognizer.addTarget(helper, action: #selector(GestureRecognizerHelper.recognizerStateDidChange(_:)))
			}
		}
	}
	
	public override func gaxbDidPrepare() {
		super.gaxbDidPrepare()
		
		//TODO: clean up this pyramid once swift 1.2 is out
		if let recognizer = recognizer, view = view, referencedView = (scope() as? Object)?.objectForId(view) as? View {
			referencedView.view.addGestureRecognizer(recognizer)
		}
	}
	
	func recognizerStateDidChange(_ recognizer:UIGestureRecognizer) {
		if onStateChange != nil {
			let (scopeObject, name) = self.parseNotification(onStateChange)
			if name != nil {
				NotificationCenter.default().post(name: Foundation.Notification.Name(rawValue: name!), object: scopeObject)
			}
		}
	}
}

class GestureRecognizerHelper: NSObject {
	weak var delegate: GestureRecognizer?
	
	func recognizerStateDidChange(_ recognizer:UIGestureRecognizer) {
		delegate?.recognizerStateDidChange(recognizer)
	}
}
