//
// Autogenerated by gaxb at 05:06:37 PM on 06/10/20
//

// swiftlint:disable superfluous_disable_command
// swiftlint:disable cyclomatic_complexity
// swiftlint:disable identifier_name
// swiftlint:disable force_cast
// swiftlint:disable type_body_length
// swiftlint:disable function_body_length
// swiftlint:disable line_length
// swiftlint:disable file_length

import UIKit

open class GestureRecognizerBase: Object {

	open func customCopyTo(_ other: GestureRecognizer) {
        // can be overriden by subclasses to provide custom copying
    }

    open override func copy() -> GaxbElement {
        let copied = super.copy() as! GestureRecognizer
        copied.view = view
        copied.cancelsTouchesInView = cancelsTouchesInView
        copied.delaysTouchesBegan = delaysTouchesBegan
        copied.delaysTouchesEnded = delaysTouchesEnded
        copied.onStateChange = onStateChange

		customCopyTo(copied)

        return copied
    }

	open override func visit(_ visitor: (GaxbElement) -> Void) {
        super.visit(visitor)

	}

    override open func setElement(_ element: GaxbElement, key: String) {
        super.setElement(element, key: key)
    }

    override  open func isKindOfClass(_ className: String) -> Bool {
        if className == "GestureRecognizer" {
            return true
        }
        return super.isKindOfClass(className)
    }

	open var view: String?

    func viewAsString() -> String {
        return view ?? ""
    }

    open func setView(_ value: String) {
        self.view = String(gaxbString: value)
    }

	open var cancelsTouchesInView: Bool?

    func cancelsTouchesInViewAsString() -> String {
        return cancelsTouchesInView!.toGaxbString()
    }

    open func setCancelsTouchesInView(_ value: String) {
        self.cancelsTouchesInView = value == "true"
    }

	open var delaysTouchesBegan: Bool?

    func delaysTouchesBeganAsString() -> String {
        return delaysTouchesBegan!.toGaxbString()
    }

    open func setDelaysTouchesBegan(_ value: String) {
        self.delaysTouchesBegan = value == "true"
    }

	open var delaysTouchesEnded: Bool?

    func delaysTouchesEndedAsString() -> String {
        return delaysTouchesEnded!.toGaxbString()
    }

    open func setDelaysTouchesEnded(_ value: String) {
        self.delaysTouchesEnded = value == "true"
    }

	open var onStateChange: String?

    func onStateChangeAsString() -> String {
        return onStateChange ?? ""
    }

    open func setOnStateChange(_ value: String) {
        self.onStateChange = String(gaxbString: value)
    }

    override open func setAttribute(_ value: String, key: String) {
        super.setAttribute(value, key: key)
        switch key {
        case "view":
            setView(value)
        case "cancelsTouchesInView":
            setCancelsTouchesInView(value)
        case "delaysTouchesBegan":
            setDelaysTouchesBegan(value)
        case "delaysTouchesEnded":
            setDelaysTouchesEnded(value)
        case "onStateChange":
            setOnStateChange(value)
        default:
            break
        }
    }

    override open func imprintAttributes(_ receiver: GaxbElement?) -> GaxbElement? {

	if let obj = receiver as? ObjectBase {
            if originalValues["view"] != nil && obj.originalValues["view"] == nil {
				obj.setAttribute(originalValues["view"]!, key: "view")
            }
            if originalValues["cancelsTouchesInView"] != nil && obj.originalValues["cancelsTouchesInView"] == nil {
				obj.setAttribute(originalValues["cancelsTouchesInView"]!, key: "cancelsTouchesInView")
            }
            if originalValues["delaysTouchesBegan"] != nil && obj.originalValues["delaysTouchesBegan"] == nil {
				obj.setAttribute(originalValues["delaysTouchesBegan"]!, key: "delaysTouchesBegan")
            }
            if originalValues["delaysTouchesEnded"] != nil && obj.originalValues["delaysTouchesEnded"] == nil {
				obj.setAttribute(originalValues["delaysTouchesEnded"]!, key: "delaysTouchesEnded")
            }
            if originalValues["onStateChange"] != nil && obj.originalValues["onStateChange"] == nil {
				obj.setAttribute(originalValues["onStateChange"]!, key: "onStateChange")
            }
       }
       return super.imprintAttributes(receiver)
    }

    override open func attributesXML(_ useOriginalValues: Bool) -> String {
        var xml = ""
        if useOriginalValues {
            for (key, value) in originalValues {
                xml += " \(key)='\(value)'"
            }
        } else {
            if view != nil {
                xml += " view='\(viewAsString())'"
            }
                if cancelsTouchesInView != nil {
                xml += " cancelsTouchesInView='\(cancelsTouchesInViewAsString())'"
            }
                if delaysTouchesBegan != nil {
                xml += " delaysTouchesBegan='\(delaysTouchesBeganAsString())'"
            }
                if delaysTouchesEnded != nil {
                xml += " delaysTouchesEnded='\(delaysTouchesEndedAsString())'"
            }
                if onStateChange != nil {
                xml += " onStateChange='\(onStateChangeAsString())'"
            }
            }
        xml += super.attributesXML(useOriginalValues)

        return xml
    }

    override open func sequencesXML(_ useOriginalValues: Bool) -> String {
        var xml = ""
        xml += super.sequencesXML(useOriginalValues)

        return xml
    }

    override open func toXML(_ useOriginalValues: Bool) -> String {
        var xml = "<GestureRecognizer"
        if parent == nil || parent?.xmlns != xmlns {
            xml += " xmlns='\(xmlns)'"
        }

        xml += attributesXML(useOriginalValues)

        let sXML = sequencesXML(useOriginalValues)
        xml += sXML == "" ? "/>": ">\(sXML)</GestureRecognizer>"
        return xml
    }

    override open func toXML() -> String {
        return toXML(false)
    }

    override open func description() -> String {
        return toXML()
    }

}
