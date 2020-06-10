//
// Autogenerated by gaxb at 04:09:47 PM on 03/27/15
//

import UIKit

public class ActivityIndicatorView: ActivityIndicatorViewBase {
    lazy public var activityIndicator = UIActivityIndicatorView()
    override open var view: UIView {
        get {
            return activityIndicator
        }
        set {
            if let newValue = newValue as? UIActivityIndicatorView {
                activityIndicator = newValue
            }
        }
    }

    open override func gaxbPrepare() {
        super.gaxbPrepare()

        if let startAnimating = startAnimating {
            NotificationCenter.`default`.addObserver(self,
                                                     selector: #selector(ActivityIndicatorView.startAnimating(_:)),
                                                     name: NSNotification.Name(rawValue: startAnimating), object: nil)
        }
        if let stopAnimating = stopAnimating {
            NotificationCenter.`default`.addObserver(self,
                                                     selector: #selector(ActivityIndicatorView.stopAnimating(_:)),
                                                     name: NSNotification.Name(rawValue: stopAnimating), object: nil)
        }
        if let hidesWhenStopped = hidesWhenStopped {
            activityIndicator.hidesWhenStopped = hidesWhenStopped
        }

        #if os(iOS)
        if let activityIndicatorViewStyle = activityIndicatorViewStyle {
            activityIndicator.style = .fromPlanetUIActivityIndicatorViewStyle(activityIndicatorViewStyle)
        }
        #endif
        if let color = color {
            activityIndicator.color = color
        }
    }

    @objc func startAnimating(_ note: Foundation.Notification) {
        activityIndicator.startAnimating()
    }

    @objc func stopAnimating(_ note: Foundation.Notification) {
        activityIndicator.stopAnimating()
    }
}
