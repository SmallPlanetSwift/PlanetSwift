//
// Autogenerated by gaxb at 02:53:18 PM on 01/28/15
//

import UIKit

public class TextView: TextViewBase {

	lazy public var textView = UITextView()
    lazy public var textViewToolbar : UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
	lazy private var textViewDelegate = TextViewDelegateHelper()
    
	override public var view: UIView {
		get {
            if textView.delegate == nil {
                textView.delegate = textViewDelegate
            }
            return textView
		}
		set {
			if newValue is UITextView {
				textView = newValue as! UITextView
			}
		}
	}
	
	public override func gaxbPrepare() {
		super.gaxbPrepare()
		
		textViewDelegate.delegate = self
		
		if let text = text {
			textView.text = text
		}
		if let fontName = fontName {
            #if os(iOS)
                textView.font = UIFont(name: fontName, size: UIFont.systemFontSize)
            #else
                textView.font = UIFont(name: fontName, size: 18)
            #endif
		}
        if let fontSize = fontSize, textView.font != nil {
            textView.font = textView.font!.withSize(CGFloat(fontSize))
        }
		if let textColor = textColor {
			textView.textColor = textColor
		}
		if let textAlignment = textAlignment {
			textView.textAlignment = NSTextAlignment.fromPlanetUITextAlignment(textAlignment)
		}
		if let selectable = selectable {
			textView.isSelectable = selectable
		}
        #if os(iOS)
            if let editable = editable {
                textView.isEditable = editable
            }
        #endif
        if let tintColor = tintColor {
            textView.tintColor = tintColor
        }
        
        // Attach toolbar if either the left button text or
        // right button text is provided.
        
        if leftButtonText != nil  || rightButtonText != nil {
            attachToolBar()
        }
        
        // set the keyboard type and force the keyboard.
        
        if let keyboardType = keyboardType {
            updateKeyboardType(keyboardType)
        }
        
        if forceKeyboard ?? false {
            textView.becomeFirstResponder()
        }
	}
    
	func textViewDidChange(_ textView: UITextView) {
        
        if let showMaxCount = showMaxCount, let maxCount = maxCount {
            if showMaxCount {
                let updatedCount : Int = Int(maxCount) - Int(textView.text.count)
                self.updateLeftButtonText(String(updatedCount))
            }
        }
        
		if onChange != nil {
			doNotification(onChange!)
		}
	}
	
	func textViewDidEndEditing(_ textView: UITextView) {
		if onEndEditing != nil {
			doNotification(onEndEditing!)
		}
	}
    
    func textViewShouldChangeText(_ text: String) -> Bool {
        
        // Logic here to compute if there's a max count and if the text has exceeded it,
        // do not allow any more editing.
        
        if hasReachedMaxCount() {
            if text.count > Int(maxCount!)-1 {
                return false
            }
        }
        
        return true
    }
	
    func doNotification(_ note: String, _ userInfo: [String:String]? = nil) {
		let (scopeObject, name) = self.parseNotification(note)
		if name != nil {
            if userInfo == nil {
                NotificationCenter.`default`.post(name: Foundation.Notification.Name(rawValue: name!), object: scopeObject)
            } else {
                NotificationCenter.`default`.post(name: Foundation.Notification.Name(rawValue: name!), object: scopeObject, userInfo: userInfo)
            }
        }
	}
        
    public func updateText(_ newText: String?) {
        text = newText
        gaxbPrepare()
    }
    
    // Tool Bar Related (Left/Right Button Related)
    
    func attachToolBar() {
        
        var barButtonItems : [UIBarButtonItem] = []
    
        textViewToolbar.barStyle = .default
        textViewToolbar.barTintColor = UIColor.white
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        if let leftButtonText = leftButtonText {
            let leftBarButton = generateLeftBarButton(leftButtonText)
            
            // Logic to control the enabled/disabled state depending on whether we are showing a counter
            // or a proper button.
            
            if showMaxCount ?? false {
                leftBarButton.isEnabled = false
                leftBarButton.title = String(Int(maxCount!))
            }
            
            barButtonItems.append(leftBarButton)
            barButtonItems.append(flexSpace)
        }
        
        if let rightButtonText = rightButtonText {
            let rightBarButton = generateRightBarButton(rightButtonText)
            barButtonItems.append(rightBarButton)
        }
        
        textViewToolbar.items = barButtonItems
        textViewToolbar.sizeToFit()
        
        textView.inputAccessoryView = textViewToolbar
    }
    
// Bar Button Generation
    
    func generateLeftBarButton(_ title: String) -> UIBarButtonItem {
        var leftBarButton : UIBarButtonItem
        
        // If the showMaxCount is set to true, then create a system
        // UIBarButton
        
        if let showMaxCount = showMaxCount {
            if showMaxCount {
                let leftBarButton = UIBarButtonItem()
                leftBarButton.target = self
                leftBarButton.action = #selector(leftButtonAction)
                leftBarButton.title = title
                
                return leftBarButton
            }
        }
        
        // Button is a "legit" button, check to see if there is a color
        // specified.
        
        if let leftBarButtonColor = leftButtonColor {
            
            // left bar button is a legit button, not a counter
        
            let innerButton = UIButton(type: .custom)
            innerButton.setTitle(title, for: .normal)
            innerButton.setTitleColor(leftBarButtonColor , for: .normal)
            
            // Determine 30% opacity and use as the highlighted (depressed) color
            // of the button.
            var r:CGFloat=0, g:CGFloat=0, b:CGFloat=0, a:CGFloat=0;
            if (leftBarButtonColor.getRed(&r, green: &g, blue: &b, alpha: &a)) {
                let highlightedColor = UIColor(red: r, green: g, blue: b, alpha: a * 0.30)
                innerButton.setTitleColor(highlightedColor, for: .highlighted)
            }
            innerButton.titleLabel?.font = UIFont(name: "AvenirNext-DemiBold", size: 17)
            innerButton.addTarget(self, action: #selector(leftButtonAction), for: .touchUpInside)
            
            leftBarButton = UIBarButtonItem.init(customView: innerButton)
        } else {
            leftBarButton = UIBarButtonItem()
            leftBarButton.title = title
        }
        
        leftBarButton.target = self
        leftBarButton.action = #selector(leftButtonAction)
       
        return leftBarButton
    }
    
    func generateRightBarButton(_ title: String) -> UIBarButtonItem {

        var rightBarButton : UIBarButtonItem
        
        // If a right bar button color is specified, build the bar button as
        // a custom view.
        
        if let rightBarButtonColor = rightButtonColor {
            
            let innerButton = UIButton(type: .custom)
            innerButton.setTitle(title, for: .normal)
            innerButton.setTitleColor(rightBarButtonColor , for: .normal)
            
            // Determine 30% opacity and use as the highlighted (depressed) color
            // of the button.
            var r:CGFloat=0, g:CGFloat=0, b:CGFloat=0, a:CGFloat=0;
            if(rightBarButtonColor.getRed(&r, green: &g, blue: &b, alpha: &a)) {
                let highlightedColor = UIColor(red: r, green: g, blue: b, alpha: a * 0.30)
                innerButton.setTitleColor(highlightedColor, for: .highlighted)
            }
            innerButton.titleLabel?.font = UIFont(name: "AvenirNext-DemiBold", size: 17)
            innerButton.addTarget(self, action: #selector(rightButtonAction), for: .touchUpInside)
            
            rightBarButton = UIBarButtonItem.init(customView: innerButton)

        } else {
            rightBarButton = UIBarButtonItem()
            rightBarButton.title = title
            rightBarButton.target = self
            rightBarButton.action = #selector(rightButtonAction)
        }
        
        return rightBarButton
    }
    
// Toolbar Action Methods
    
    @objc func leftButtonAction() {
        if onLeftButton != nil {
            let userInfo : [String:String] = ["value":leftButtonText!]
            doNotification(onLeftButton!,userInfo)
        }
    }
    
    @objc func rightButtonAction() {
        if onRightButton != nil {
            let userInfo : [String:String]? = shouldAttachTextToNotification() ? ["value":textView.text] : nil
            doNotification(onRightButton!,userInfo)
        }
    }
    
// Helper Methods
    
// checks if text value should be included in notification., only check if max count has been met if the max count is required
// to attach, if the max count is NOT required, then just ensure the text has at least one character.
    
    func shouldAttachTextToNotification() -> Bool {
        
        if let requireMaxCount = requireMaxCount {
            if requireMaxCount && hasReachedMaxCount() {
                return true
            }
            
            if !requireMaxCount && textView.text.count > 0 {
                return true
            }
        }
    
        return false
    }
    
    
// will check if there is a max count specified (that's non trivial) and if the current text
// has reached the max.
    
    func hasReachedMaxCount() -> Bool {
        
        if let maxCount = maxCount, maxCount > 0 {
            if textView.text.count == Int(maxCount) {
                return true
            }
        }
        
        return false
    }
    
// Update keyboard Type
    
    public func updateKeyboardType(_ newKeyboardType: String?) {
        if let newKeyboardType = newKeyboardType {
            
            switch(newKeyboardType) {
            case "default":
                textView.keyboardType = UIKeyboardType.default
            case "asciiCapable":
                textView.keyboardType = UIKeyboardType.asciiCapable
            case "numbersAndPunctuation":
                textView.keyboardType = UIKeyboardType.numbersAndPunctuation
            case "URL":
                textView.keyboardType = UIKeyboardType.URL
            case "numberPad":
                textView.keyboardType = UIKeyboardType.numberPad
            case "phonePad":
                textView.keyboardType = UIKeyboardType.phonePad
            case "namePhonePad":
                textView.keyboardType = UIKeyboardType.namePhonePad
            case "emailAddress":
                textView.keyboardType = UIKeyboardType.emailAddress
            case "decimalPad":
                textView.keyboardType = UIKeyboardType.decimalPad
            case "twitter":
                textView.keyboardType = UIKeyboardType.twitter
            case "webSearch":
                textView.keyboardType = UIKeyboardType.webSearch
            case "asciiCapableNumberPad":
                if #available(iOS 10.0, *) {
                    textView.keyboardType = UIKeyboardType.asciiCapableNumberPad
                } else {
                    // Fallback on default
                    textView.keyboardType = UIKeyboardType.default
                }
            default:
                textView.keyboardType = UIKeyboardType.default
            }
            
        }
    }

    
// Toolbar Update Methods
    
    public func updateMaxCount(_ newMaxCount: Double?) {
        maxCount = newMaxCount
    }
    
    public func updateShowMaxCount(_ newShowMaxCount: Bool?) {
        showMaxCount = newShowMaxCount
        
        if showMaxCount! {
            self.updateLeftButtonText(String(Int(maxCount!)))
        }
    }
    
    public func updateRequireMaxCount(_ newRequireMaxCount: Bool?) {
        requireMaxCount = newRequireMaxCount
    }
    
    public func updateLeftButtonText(_ newText: String?) {
    
        if let barButtonItems = textViewToolbar.items, let newText = newText {
            
            leftButtonText = newText
            
            var updatedBarButtonItems : [UIBarButtonItem] = []
            // let leftBarButton: UIBarButtonItem = UIBarButtonItem(title: newText, style: .done, target: self, action:#selector(leftButtonAction))
            
            var leftBarButton : UIBarButtonItem? = UIBarButtonItem()
            if let leftButtonText = leftButtonText {
                leftBarButton = generateLeftBarButton(leftButtonText)
            
                if showMaxCount ?? false {
                    leftBarButton?.isEnabled = false
                } else {
                    leftBarButton?.isEnabled = true
                }
            }
            
            updatedBarButtonItems.append(leftBarButton!)
            updatedBarButtonItems.append(barButtonItems[1])
            updatedBarButtonItems.append(barButtonItems[2])
            
            textViewToolbar.items = nil;
            textViewToolbar.items = updatedBarButtonItems
            textViewToolbar.sizeToFit()
            
            // gaxbPrepare()
        }
    }
    
    public func updateRightButtonText(_ newText: String?) {
        
        
        
        if let barButtonItems = textViewToolbar.items, let newText = newText {
            
            var updatedBarButtonItems : [UIBarButtonItem] = []
            updatedBarButtonItems.append(barButtonItems[0])
            updatedBarButtonItems.append(barButtonItems[1])
            
            // clear current toolbar.
            textViewToolbar.items = nil;
            
            // build the updated right hand button.
            rightButtonText = newText
            
            //let rightBarButton: UIBarButtonItem = UIBarButtonItem(title: newText, style: .done, target: self, action:#selector(rightButtonAction))
            var rightBarButton: UIBarButtonItem = UIBarButtonItem()
            
            if let rightButtonText = rightButtonText {
                rightBarButton = generateRightBarButton(rightButtonText)
            }
            
//            rightBarButton.target = self
//            rightBarButton.action = #selector(rightButtonAction)
//
            
            updatedBarButtonItems.append(rightBarButton)
            
            textViewToolbar.items = updatedBarButtonItems
            textViewToolbar.sizeToFit()
            
            // gaxbPrepare()
        }
    }
    
}



private class TextViewDelegateHelper : NSObject, UITextViewDelegate {
	
	weak var delegate:TextView?
	
    @objc func textViewDidChange(_ textView: UITextView) {
		
		if delegate != nil {
			delegate?.textViewDidChange(textView)
		}
	}
	
	@objc func textViewDidEndEditing(_ textView: UITextView) {
		
		if delegate != nil {
			delegate?.textViewDidChange(textView)
		}
	}
    
    @objc func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if delegate != nil {
            
            if let delegate = delegate  {
                if text.count > 0 {
                    return delegate.textViewShouldChangeText(textView.text)
                } else {
                    return true
                }
            } else {
                return true
            }
        }
        return true
        
    }
    

    
    
}
