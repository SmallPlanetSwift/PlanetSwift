//
// Autogenerated by gaxb at 01:38:55 PM on 01/20/15
//

import UIKit

public class TextField: TextFieldBase {
    lazy public var textField = UITextField()
    lazy private var textFieldDelegate = TextFieldHelper()

    override public var control: UIControl? {
        get {
            if textField.delegate == nil {
                textField.delegate = textFieldDelegate
            }
            return textField
        }
        set {
            if let newValue = newValue as? UITextField {
                textField = newValue
            }
        }
    }

    public override func gaxbPrepare() {
        super.gaxbPrepare()

        textFieldDelegate.textDelegate = self
		
        textField.text = text
        textField.placeholder = placeholder.map{NSLocalizedString($0, comment: "")} ?? ""
        if let fontName = fontName {
            #if os(iOS)
                textField.font = UIFont(name: fontName, size: UIFont.systemFontSize)
            #else
                textField.font = UIFont(name: fontName, size: 18)
            #endif
        }
        if let fontSize = fontSize, textField.font != nil {
            textField.font = textField.font!.withSize(CGFloat(fontSize))
        }
        textField.textColor = textColor
        if let textAlignment = textAlignment {
            textField.textAlignment = NSTextAlignment(withPlanetTextAlignment: textAlignment)
        }
        if let adjustsFontSizeToFitWidth = adjustsFontSizeToFitWidth {
            textField.adjustsFontSizeToFitWidth = adjustsFontSizeToFitWidth
        }
        if let borderStyle = borderStyle {
            textField.borderStyle = UITextBorderStyle(withPlanetTextBorderStyle: borderStyle)
        }
		if let secureTextEntry = secureTextEntry {
			textField.isSecureTextEntry = secureTextEntry
		}
		if let clearButtonMode = clearButtonMode {
            textField.clearButtonMode = UITextFieldViewMode(withPlanetTextFieldViewMode:clearButtonMode)
		}
		if let clearsOnBeginEditing = clearsOnBeginEditing {
			textField.clearsOnBeginEditing = clearsOnBeginEditing
		}
		if let returnKeyType = returnKeyType {
            textField.returnKeyType = UIReturnKeyType(withPlanetReturnKeyType:returnKeyType)
		}
		if let keyboardType = keyboardType {
            textField.keyboardType = UIKeyboardType(withPlanetKeyboardType:keyboardType)
		}
		if let autocapitalizationType = autocapitalizationType {
			textField.autocapitalizationType = UITextAutocapitalizationType(withPlanetTextAutocapitalizationType:autocapitalizationType)
		}
		if let autocorrectionType = autocorrectionType {
			textField.autocorrectionType = UITextAutocorrectionType(withPlanetTextAutocorrectionType:autocorrectionType)
		}
		if let spellCheckingType = spellCheckingType {
			textField.spellCheckingType = UITextSpellCheckingType(withPlanetTextSpellCheckingType:spellCheckingType)
		}
		
        textField.minimumFontSize = CGFloat(minimumFontSize)
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        guard let onBeginEditing = onBeginEditing else { return }
        doNotification(onBeginEditing)
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let onEndEditing = onEndEditing else { return }
        doNotification(onEndEditing)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let onReturnPressed = onReturnPressed {
            doNotification(onReturnPressed)
        }
        return true
    }

    func doNotification(_ note: String) {
        let (scopeObject, name) = self.parseNotification(note)
        if let name = name {
            NotificationCenter.`default`.post(name: Foundation.Notification.Name(rawValue: name), object: scopeObject)
        }
    }
}

private class TextFieldHelper: NSObject, UITextFieldDelegate {
    weak var textDelegate: TextField?

    @objc func textFieldDidBeginEditing(_ textField: UITextField) {
        textDelegate?.textFieldDidBeginEditing(textField)
    }

    @objc func textFieldDidEndEditing(_ textField: UITextField) {
        textDelegate?.textFieldDidEndEditing(textField)
    }
    
    @objc func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard textDelegate != nil else { return true }
        return textDelegate!.textFieldShouldReturn(textField)
    }
}
