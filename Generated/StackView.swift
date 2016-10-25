//
// Autogenerated by gaxb at 12:32:45 PM on 08/30/16
//

import UIKit

public class StackView: StackViewBase {
    @available(iOS 9.0, *)
    lazy public var stackView = UIStackView(frame: CGRect.zero)
    
    override public var view: UIView {
        get {
            if #available(iOS 9.0, *) {
                return stackView
            } else {
                print("Warning: UIStackView is only available on iOS 9 and above")
                return self.view
            }
        }
        set {
            if #available(iOS 9.0, *) {
                if newValue is UIStackView {
                    stackView = newValue as! UIStackView
                }
            }
        }
    }

    public override func gaxbPrepare() {
        super.gaxbPrepare()

        guard #available(iOS 9.0, *) else { return }
        if let alignment = alignment {
            stackView.alignment = UIStackViewAlignment(alignment)
        }
        if let axis = axis {
            stackView.axis = UILayoutConstraintAxis(axis)
        }
        if let baselineRelativeArrangement = baselineRelativeArrangement {
            stackView.isBaselineRelativeArrangement = baselineRelativeArrangement
        }
        if let distribution = distribution {
            stackView.distribution = UIStackViewDistribution(distribution)
        }
        if let layoutMarginsRelativeArrangement = layoutMarginsRelativeArrangement {
            stackView.isLayoutMarginsRelativeArrangement = layoutMarginsRelativeArrangement
        }
        if let spacing = spacing {
            stackView.spacing = CGFloat(spacing)
        }
    }
    
    override internal func addSubview(_ child: UIView) {
        if #available(iOS 9.0, *) {
            stackView.addArrangedSubview(child)
        } else {
            view.addSubview(child)
        }
    }

}

@available(iOS 9.0, *)
extension UILayoutConstraintAxis {
    init(_ planetSwiftEnum: PlanetUI.LayoutConstraintAxis) {
        switch planetSwiftEnum {
        case .horizontal:
            self = .horizontal
        case .vertical:
            self = .vertical
        }
    }
}

@available(iOS 9.0, *)
extension UIStackViewAlignment {
    init(_ planetSwiftEnum: PlanetUI.StackViewAlignment) {
        switch planetSwiftEnum {
        case .fill:
            self = .fill
        case .center:
            self = .center
        case .fistBaseline:
            self = .firstBaseline
        case .lastBaseline:
            self = .lastBaseline
        case .leading:
            self = .leading
        case .trailing:
            self = .trailing
        case .bottom:
            self = UIStackViewAlignment.bottom
        case .top:
            self = UIStackViewAlignment.top
        }
    }
}

@available(iOS 9.0, *)
extension UIStackViewDistribution {
    init(_ planetSwiftEnum: PlanetUI.StackViewDistribution) {
        switch planetSwiftEnum {
        case .fill:
            self = .fill
        case .fillEqually:
            self = .fillEqually
        case .fillProportionally:
            self = .fillProportionally
        case .equalCentering:
            self = .equalCentering
        case .equalSpacing:
            self = .equalSpacing
        }
    }
}