//
// Autogenerated by gaxb at 03:15:42 PM on 01/14/15
//

import UIKit

public class ImageView: ImageViewBase {
	lazy public var imageView = UIImageView()
	override public var view: UIView {
        get {
            return imageView
        }
        set {
            if newValue is UIImageView {
                imageView = newValue as! UIImageView
            }
        }
    }
    
    public override func gaxbPrepare() {
        super.gaxbPrepare()
		
        if image != nil {
			setImageWithBundlePath(image!)
        }
    }
	
	public func setImageWithBundlePath(bundlePath:String) {
		setImageWithPath(String(bundlePath: bundlePath))
	}
	
	public func setImageWithPath(path:String) {
		if let img: UIImage = UIImage(named: path) {
			imageView.image = img
		}
	}
	
}
