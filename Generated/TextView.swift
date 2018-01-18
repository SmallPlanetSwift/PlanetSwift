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
        print("tv gaxb")
		if let fontName = fontName {
            #if os(iOS)
                textView.font = UIFont(name: fontName, size: UIFont.systemFontSize())
            #else
                textView.font = UIFont(name: fontName, size: 18)
            #endif
		}
        if let fontSize = fontSize where textView.font != nil {
            textView.font = textView.font!.fontWithSize(CGFloat(fontSize))
        }
		if let textColor = textColor {
			textView.textColor = textColor
		}
		if let textAlignment = textAlignment {
			textView.textAlignment = NSTextAlignment.fromPlanetUITextAlignment(textAlignment)
		}
		if let selectable = selectable {
			textView.selectable = selectable
		}
        #if os(iOS)
            if let editable = editable {
                textView.editable = editable
            }
        #endif
        if let tintColor = tintColor {
            textView.tintColor = tintColor
        }
        
        // Keyboard ToolBar Related
        
        if leftButtonText != nil  || rightButtonText != nil {
            attachToolBar()
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
	
	func textViewDidEndEditing(textView: UITextView) {
		if onEndEditing != nil {
			doNotification(onEndEditing!)
		}
	}
    
    func textViewShouldChangeText(_ text: String) -> Bool {
        
        // Logic here to compute if there's a max count and if the text has exceeded it,
        // do not allow any more editing.
        
        if let maxCount = maxCount {
            if text.count > Int(maxCount)-1 {
                return false
            }
        }
        
        return true
    }
	
	func doNotification(_ note: String) {
		let (scopeObject, name) = self.parseNotification(note)
		if name != nil {
			NSNotificationCenter.defaultCenter().postNotificationName(name!, object: scopeObject)
		}
	}
    
    public func updateText(newText: String?) {
        text = newText
        gaxbPrepare()
    }
    
    // Tool Bar Related (Left/Right Button Related)
    
    func attachToolBar() {
        
        var barButtonItems : [UIBarButtonItem] = []
    
        textViewToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        if let leftButtonText = leftButtonText {
            let leftBarButton: UIBarButtonItem = UIBarButtonItem(title: leftButtonText, style: .done, target: self, action:#selector(leftButtonAction))
            
            if showMaxCount ?? false {
                leftBarButton.isEnabled = false
                leftBarButton.title = String(Int(maxCount!))
            }
            
            barButtonItems.append(leftBarButton)
            barButtonItems.append(flexSpace)
        }
        
        if let rightButtonText = rightButtonText {
            let rightBarButton: UIBarButtonItem = UIBarButtonItem(title: rightButtonText, style: .done, target: self, action:#selector(rightButtonAction))
            barButtonItems.append(rightBarButton)
        }
        
        textViewToolbar.items = barButtonItems
        textViewToolbar.sizeToFit()
        
        textView.inputAccessoryView = textViewToolbar
    }
    
// Toolbar Action Methods
    
    @objc func leftButtonAction() {
        
        if onLeftButton != nil {
            doNotification(onLeftButton!)
        }
        
    }
    
    @objc func rightButtonAction() {
        
        if onRightButton != nil {
            doNotification(onRightButton!)
        }
    }
    
    
    
// Toolbar Update Methods
    
    public func updateMaxCount(_ newMaxCount: Double?) {
        maxCount = newMaxCount
    }
    
    public func updateShowMaxCount(_ newShowMaxCount: Bool?) {
        showMaxCount = newShowMaxCount
    }
    
    public func updateLeftButtonText(_ newText: String?) {
    
        if let barButtonItems = textViewToolbar.items, let newText = newText {
            
            var updatedBarButtonItems : [UIBarButtonItem] = []
            let leftBarButton: UIBarButtonItem = UIBarButtonItem(title: newText, style: .done, target: self, action:#selector(leftButtonAction))
            
            if showMaxCount ?? false {
                leftBarButton.isEnabled = false
            } else {
                leftBarButton.isEnabled = true
            }
            
            updatedBarButtonItems.append(leftBarButton)
            updatedBarButtonItems.append(barButtonItems[1])
            updatedBarButtonItems.append(barButtonItems[2])
            
            textViewToolbar.items = updatedBarButtonItems
            textViewToolbar.sizeToFit()
            
            // gaxbPrepare()
        }
    }
    
    public func updateRightButtonText(_ newText: String?) {
        
        if let barButtonItems = textViewToolbar.items, let newText = newText {
            
            var updatedBarButtonItems : [UIBarButtonItem] = []
            let rightBarButton: UIBarButtonItem = UIBarButtonItem(title: newText, style: .done, target: self, action:#selector(rightButtonAction))
            
            updatedBarButtonItems.append(barButtonItems[0])
            updatedBarButtonItems.append(barButtonItems[1])
            updatedBarButtonItems.append(rightBarButton)
            
            textViewToolbar.items = updatedBarButtonItems
            textViewToolbar.sizeToFit()
            
            // gaxbPrepare()
        }
    }
    
}

private class TextViewDelegateHelper : NSObject, UITextViewDelegate {
	
	weak var delegate:TextView?
	
	@objc func textViewDidChange(textView: UITextView) {
		
		if delegate != nil {
			delegate?.textViewDidChange(textView)
		}
	}
	
	@objc func textViewDidEndEditing(textView: UITextView) {
		
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
