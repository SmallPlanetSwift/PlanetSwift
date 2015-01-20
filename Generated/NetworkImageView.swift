//
// Autogenerated by gaxb at 02:43:47 PM on 01/20/15
//

public class NetworkImageView: NetworkImageViewBase {
	
	public var networkImageView = PlanetNetworkImageView()
	override public var imageView : UIImageView {
		get {
			return networkImageView
		}
		set {
			if newValue is PlanetNetworkImageView {
				networkImageView = newValue as PlanetNetworkImageView
			}
		}
	}
	
	public override func setImageWithPath(path:String) {
		
		if let url = NSURL(string: path) {
			
			let placeholder = UIImage(named: path)
			networkImageView.setImage(url, placeholder: placeholder)
		}
		else {
			super.setImageWithPath(path)
		}
	}
	
	/*
	public func setImageWithBundlePath(bundlePath:String) {
	if let img: UIImage = UIImage(named: String(bundlePath: bundlePath)) {
	imageView.image = img
	}
	}
*/
	
}
