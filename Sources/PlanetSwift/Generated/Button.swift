//
// Autogenerated by gaxb at 11:23:55 PM on 01/11/15
//

// swiftlint:disable function_body_length
// swiftlint:disable cyclomatic_complexity
// swiftlint:disable line_length

import UIKit

public class Button: ButtonBase {

    lazy public var button: PlanetButton = self.makeButton()
    override public var control: UIControl? {
        get {
            return button
        }
        set {
            if let newValue = newValue as? PlanetButton {
                button = newValue
            }
        }
    }

    public func updateBackgroundColor(_ color: UIColor?, forstate state: UIControl.State) {
        switch state {
        case .normal: button.backgroundColor = color
        case .selected: button.backgroundColorSelected = color
        case .highlighted: button.backgroundColorHighlighted = color
        case .disabled: button.backgroundColorDisabled = color
        case [.selected, .highlighted]: button.backgroundColorSelectedHighlighted = color
        default: break
        }
    }

    public func updateTitle(_ text: String?, forState state: UIControl.State = .normal) {
        button.setTitle(text.map { NSLocalizedString($0, comment: "") }, for: state)
    }

    public func makeButton() -> PlanetButton {
        if let type = type {
            return PlanetButton(type: UIButton.ButtonType(withPlanetButtonType: type))
        }
        return PlanetButton()
    }

    open override func gaxbPrepare() {
        super.gaxbPrepare()

        if onTouchUp != nil {
            button.addTarget(self, action: #selector(Button.buttonOnTouchUp(_:)), for: .touchUpInside)
        }
        if onTouchDown != nil {
            button.addTarget(self, action: #selector(Button.buttonOnTouchDown(_:)), for: .touchDown)
        }
        button.tintColor = tintColor

        updateTitle(title, forState: UIControl.State())
        updateTitle(titleHighlighted, forState: .highlighted)
        updateTitle(titleSelected, forState: .selected)
        updateTitle(titleSelectedHighlighted, forState: [.selected, .highlighted])
        updateTitle(titleDisabled, forState: .disabled)

        button.setTitleColor(titleFontColor, for: UIControl.State())
        button.setTitleColor(titleFontColorHighlighted, for: .highlighted)
        button.setTitleColor(titleFontColorSelected, for: .selected)
        button.setTitleColor(titleFontColorSelectedHighlighted, for: [.selected, .highlighted])
        button.setTitleColor(titleFontColorDisabled, for: .disabled)

        if let titleFont = titleFont {
            #if os(iOS)
                button.titleLabel?.font = UIFont(name: titleFont, size: UIFont.systemFontSize)
            #else
                button.titleLabel?.font = UIFont(name: titleFont, size: 18)
            #endif
        }
        if let titleFontSize = titleFontSize {
            button.titleLabel?.font = button.titleLabel?.font.withSize(CGFloat(titleFontSize))
        }

        if let backgroundImage = backgroundImage {
            let img = UIImage(gaxbString: backgroundImage)
            button.setBackgroundImage(img, for: UIControl.State())
        }
        if let backgroundImageHighlighted = backgroundImageHighlighted {
            let img = UIImage(gaxbString: backgroundImageHighlighted)
            button.setBackgroundImage(img, for: .highlighted)
        }
        if let backgroundImageSelected = backgroundImageSelected {
            let img = UIImage(gaxbString: backgroundImageSelected)
            button.setBackgroundImage(img, for: .selected)
        }
        if let backgroundImageSelectedHighlighted = backgroundImageSelectedHighlighted {
            let img = UIImage(gaxbString: backgroundImageSelectedHighlighted)
            button.setBackgroundImage(img, for: [.selected, .highlighted])
        }
        if let backgroundImageDisabled = backgroundImageDisabled {
            let img = UIImage(gaxbString: backgroundImageDisabled)
            button.setBackgroundImage(img, for: .disabled)
        }

        if let image = image {
            let img = UIImage(gaxbString: image)
            button.setImage(img, for: UIControl.State())
        }
        if let imageHighlighted = imageHighlighted {
            let img = UIImage(gaxbString: imageHighlighted)
            button.setImage(img, for: .highlighted)
        }
        if let imageSelected = imageSelected {
            let img = UIImage(gaxbString: imageSelected)
            button.setImage(img, for: .selected)
        }
        if let imageSelectedHighlighted = imageSelectedHighlighted {
            let img = UIImage(gaxbString: imageSelectedHighlighted)
            button.setImage(img, for: [.selected, .highlighted])
        }
        if let imageDisabled = imageDisabled {
            let img = UIImage(gaxbString: imageDisabled)
            button.setImage(img, for: .disabled)
        }

        if let imageSet = imageSet {
            let pathLength = imageSet.count
            let extensionLength = imageSet.components(separatedBy: ".").last?.count ?? 0
            let insertPosition = pathLength - extensionLength - ( extensionLength > 0 ? 1 : 0 )

            let baseName = String(imageSet[..<imageSet.index(imageSet.startIndex, offsetBy: insertPosition)])
            let suffix = String(imageSet[imageSet.index(imageSet.startIndex, offsetBy: insertPosition)...])

            let normalPath = baseName + "_normal" + suffix
            let highlightedPath = baseName + "_highlighted" + suffix
            let selectedPath = baseName + "_selected" + suffix
            let selectedHighlightedPath = baseName + "_selected_highlighted" + suffix
            let disabledPath = baseName + "_disabled" + suffix

            var img = UIImage(contentsOfFile: String(bundlePath: normalPath)) ?? UIImage(contentsOfFile: String(bundlePath: imageSet))
            button.setImage(img, for: UIControl.State())
            img = UIImage(contentsOfFile: String(bundlePath: highlightedPath))
            button.setImage(img, for: .highlighted)
            img = UIImage(contentsOfFile: String(bundlePath: selectedPath))
            button.setImage(img, for: .selected)
            img = UIImage(contentsOfFile: String(bundlePath: selectedHighlightedPath))
            button.setImage(img, for: [.selected, .highlighted])
            img = UIImage(contentsOfFile: String(bundlePath: disabledPath))
            button.setImage(img, for: .disabled)
        }

        if let backgroundImageSet = backgroundImageSet {
            let pathLength = backgroundImageSet.count
            let extensionLength = backgroundImageSet.components(separatedBy: ".").last?.count ?? 0
            let insertPosition = pathLength - extensionLength - (extensionLength > 0 ? 1 : 0)

            let baseName = String(backgroundImageSet[..<backgroundImageSet.index(backgroundImageSet.startIndex, offsetBy: insertPosition)])
            let suffix = String(backgroundImageSet[backgroundImageSet.index(backgroundImageSet.startIndex, offsetBy: insertPosition)...])

            let normalPath = baseName + "_normal" + suffix
            let highlightedPath = baseName + "_highlighted" + suffix
            let selectedPath = baseName + "_selected" + suffix
            let selectedHighlightedPath = baseName + "_selected_highlighted" + suffix
            let disabledPath = baseName + "_disabled" + suffix

            var img = UIImage(contentsOfFile: String(bundlePath: normalPath)) ?? UIImage(contentsOfFile: String(bundlePath: backgroundImageSet))
            button.setBackgroundImage(img, for: UIControl.State())
            img = UIImage(contentsOfFile: String(bundlePath: highlightedPath))
            button.setBackgroundImage(img, for: .highlighted)
            img = UIImage(contentsOfFile: String(bundlePath: selectedPath))
            button.setBackgroundImage(img, for: .selected)
            img = UIImage(contentsOfFile: String(bundlePath: selectedHighlightedPath))
            button.setBackgroundImage(img, for: [.selected, .highlighted])
            img = UIImage(contentsOfFile: String(bundlePath: disabledPath))
            button.setBackgroundImage(img, for: .disabled)
        }

        button.backgroundColorNormal = backgroundColor
        button.backgroundColorHighlighted = backgroundColorHighlighted
        button.backgroundColorSelected = backgroundColorSelected
        button.backgroundColorSelectedHighlighted = backgroundColorSelectedHighlighted
        button.backgroundColorDisabled = backgroundColorDisabled

        button.isToggle = isToggle
        if let contentEdgeInsets = contentEdgeInsets {
            button.contentEdgeInsets = contentEdgeInsets
        }
        if let titleEdgeInsets = titleEdgeInsets {
            button.titleEdgeInsets = titleEdgeInsets
        }
        if let imageEdgeInsets = imageEdgeInsets {
            button.imageEdgeInsets = imageEdgeInsets
        }
    }

    @objc func buttonOnTouchUp(_ sender: UIButton) {
        guard onTouchUp != nil else { return }
        let (scopeObject, name) = parseNotification(onTouchUp)
        if let name = name {
            NotificationCenter.`default`.post(name: Foundation.Notification.Name(rawValue: name), object: scopeObject)
        }
    }

    @objc func buttonOnTouchDown(_ sender: UIButton) {
        guard onTouchDown != nil else { return }
        let (scopeObject, name) = parseNotification(onTouchDown)
        if let name = name {
            NotificationCenter.`default`.post(name: Foundation.Notification.Name(rawValue: name), object: scopeObject)
        }
    }
}
