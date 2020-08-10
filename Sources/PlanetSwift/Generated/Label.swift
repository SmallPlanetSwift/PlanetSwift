//
// Autogenerated by gaxb at 02:35:55 PM on 12/17/14
//

import UIKit

// to find and dump localizable strings in a project, set _findLoclaizable to true
// and after using the app for a suitable period of time, run Label.printLocalizable()
// to get a dump of content ready for pasting into a .strings file
private let _findLocalizable = false
private var _localizable = Set<String>()

public class Label: LabelBase {

    lazy public var label: PlanetLabel = PlanetLabel()
    override open var view: UIView {
        get {
            return label
        }
        set {
            if let newValue = newValue as? PlanetLabel {
                label = newValue
            }
        }
    }

    open override func gaxbPrepare() {
        super.gaxbPrepare()
        let paragraphStyle = NSMutableParagraphStyle()

		if let lineSpacing = lineSpacing {
            paragraphStyle.lineSpacing = CGFloat(lineSpacing)
        }
        if let minimumLineHeight = minimumLineHeight {
            paragraphStyle.minimumLineHeight = CGFloat(minimumLineHeight)
        }
        if let maximumLineHeight = maximumLineHeight {
            paragraphStyle.maximumLineHeight = CGFloat(maximumLineHeight)
		}
        if let textColor = textColor {
            label.textColor = textColor
        }
        if let adjustsFontSizeToFitWidth = adjustsFontSizeToFitWidth {
            label.adjustsFontSizeToFitWidth = adjustsFontSizeToFitWidth
        }
        label.minimumScaleFactor = CGFloat(minimumScaleFactor)
        if let numberOfLines = numberOfLines {
            label.numberOfLines = numberOfLines
        }
        if let fontName = fontName {
            #if os(iOS)
                label.font = UIFont(name: fontName, size: UIFont.systemFontSize)
            #else
                label.font = UIFont(name: fontName, size: 18)
            #endif
        }
        if let fontSize = fontSize {
            label.font = label.font.withSize(CGFloat(fontSize))
        }

		//attributes that are sensitive to the existence (or non-existence) of _paragraphStyle
		if let textAlignment = textAlignment {
            paragraphStyle.alignment = NSTextAlignment.fromPlanetUITextAlignment(textAlignment)
			label.textAlignment = NSTextAlignment.fromPlanetUITextAlignment(textAlignment)
		}
		if let lineBreakMode = lineBreakMode {
            paragraphStyle.lineBreakMode = NSLineBreakMode.fromPlanetUILineBreakMode(lineBreakMode)
			label.lineBreakMode = NSLineBreakMode.fromPlanetUILineBreakMode(lineBreakMode)
		}

        let localizedText = text.map { NSLocalizedString($0, comment: "") } ?? ""
        checkUnlocalized(text, localized: localizedText)

        let attributedString = NSMutableAttributedString(string: localizedText)
        let attributes = [NSAttributedString.Key.paragraphStyle: paragraphStyle]
        attributedString.setAttributes(attributes, range: NSRange(location: 0, length: attributedString.length))
        label.attributedText = attributedString
    }

    public func updateText(_ newText: String?) {
        text = newText
        gaxbPrepare()
    }

    func checkUnlocalized(_ text: String?, localized: String) {
        guard let text = text, text.count > 0 && _findLocalizable else { return }
        guard text == localized else { return }
        let output = "\"\(text)\" = \"\(localized)\";"
        _localizable.insert(output)
    }

    public class func printLocalizable() {
        guard _findLocalizable else { return }
        print("//--------- localizable strings start --------")
        print(Array(_localizable).joined(separator: "\n"))
        print("//---------- localizable strings end ---------")
    }
}