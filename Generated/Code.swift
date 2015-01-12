//
// Autogenerated by gaxb at 10:50:37 PM on 01/09/15
//

public class Code: CodeBase {
    public var codeObject: NSObject?
    
    public override func gaxbInit() {
        super.gaxbInit()
        
        let appName = NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleName") as String
        if className != nil {
            let fqClassName = appName + "." + className!
            let classType = NSClassFromString(fqClassName) as NSObject.Type?
            if let object = classType?() as NSObject? {
                codeObject = object
                for notification in self.notifications {
                    if let selector = notification.selector {
                        NSNotificationCenter.defaultCenter().addObserver(codeObject!, selector: selector, name: notification.name, object: scope())
                    }
                }
            }
        }
    }
    
    deinit {
        if codeObject != nil {
            for notification in self.notifications {
                NSNotificationCenter.defaultCenter().removeObserver(codeObject!, name: notification.name, object: scope())
            }
        }
    }
    
}
