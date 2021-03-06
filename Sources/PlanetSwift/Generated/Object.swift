//
// Autogenerated by gaxb at 10:39:28 AM on 12/12/14
//

// swiftlint:disable identifier_name
// swiftlint:disable force_cast

import UIKit

var styles: Object?

// workaround for inability to specify the XML load call inline here
private var attemptedStylesLoad = false
private var stylesLoadedWereLight = false

@dynamicMemberLookup
open class Object: ObjectBase {

    // MARK: - ID mappings

    private lazy var idMappings = [String: NSValue]()

    public func objectForId(_ identifier: String) -> Object? {
        if let value = idMappings[identifier] {

            // clean out this object if the weak reference was zeroed
            if value.nonretainedObjectValue == nil {
                idMappings.removeValue(forKey: identifier)
            }

            return value.nonretainedObjectValue as? Object
        }
        return nil
    }

    public func elementForId(_ identifier: String) -> GaxbElement? {
        return objectForId(identifier)
    }

    public func setObjectForId(_ identifier: String, object: Object) {
        idMappings[identifier] = NSValue(nonretainedObject: object)
    }

    public subscript<T>(dynamicMember member: String) -> T {
      return objectForId(member) as! T
    }

    // MARK: - scoping

    public func isScopeContainer() -> Bool {
        return false
    }

    public func scope() -> AnyObject? {
        if isScopeContainer() {
            return self
        }
        if let object = parent as? Object {
            return object.scope()
        }
        return nil
    }

    // MARK: - notification

    // notification strings are one of the following:
    //  LOCAL::handleSomething  (local scope)
    //  handleSomething (same as above, local scope)
    //  GLOBAL::handleSomething (global scope)
    public func parseNotification(_ scopedName: String?) -> (scope: AnyObject?, name: String? ) {
        var scopeObject: AnyObject?
        var name: String?

        if let components = scopedName?.components(separatedBy: "::") {
            switch components.count {
            case 1:
                scopeObject = self.scope()
                name = components[0]
            case 2:
                switch components[0] {
                case "GLOBAL":
                    scopeObject = nil
                case "LOCAL":
                    scopeObject = self.scope()
                default:
                    break
                }
                name = components[1]
            default:
                break
            }
        }
        return (scopeObject, name)
    }

    open override func gaxbPrepare() {
        super.gaxbPrepare()
        if let id = id, let scopeObj = scope() as? Object {
            scopeObj.setObjectForId(id, object: self)
        }
    }

    public func updateStyleId(_ newStyle: String?) {
        styleId = newStyle
        gaxbPrepare()
    }

    // MARK: - style handling

    public class func loadStylesFromString(_ string: String) {
        styles = PlanetUI.readFromString(string, prepare: false) as? Object
    }

    public class func loadStyles(_ file: URL) {
        styles = PlanetUI.readFromFile(file.absoluteString, prepare: false) as? Object
    }

    public class func loadStyles(_ bundlePath: String) {
        styles = PlanetUI.readFromFile(String(bundlePath: bundlePath), prepare: false) as? Object
    }

    public class func styleForId(_ _id: String) -> GaxbElement? {
		
		var stylesToLoadAreLight = true
		if #available(iOS 12.0, *), UIScreen.main.traitCollection.userInterfaceStyle == .dark {
			stylesToLoadAreLight = false
		}
		
        if (styles == nil && !attemptedStylesLoad) || stylesToLoadAreLight != stylesLoadedWereLight {
            attemptedStylesLoad = true
			
	        if #available(iOS 12.0, *), UIScreen.main.traitCollection.userInterfaceStyle == .dark {
                if let path = PlanetSwiftConfiguration.valueForKey(planetSwiftConfigurationDarkStylesheetPathKey) as? String {
					stylesLoadedWereLight = false
                    loadStyles(path)
                }
            }else{
                if let path = PlanetSwiftConfiguration.valueForKey(planetSwiftConfigurationLightStylesheetPathKey) as? String {
					stylesLoadedWereLight = true
                    loadStyles(path)
                }
            }
        }

        guard let styles = styles else { return nil }
        for child in styles.anys {
            if let childObject = child as? Object, childObject.styleId == _id {
                return childObject
            }
        }
        return nil
    }
}
