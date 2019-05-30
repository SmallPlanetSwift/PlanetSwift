//
// Autogenerated by gaxb at 11:45:55 AM on 01/14/15
//

import UIKit

private let Constraint_parentKeyword = "parent"

public class Constraint: ConstraintBase {

	internal(set) public var constraints = [NSLayoutConstraint]()
    public var constraint: NSLayoutConstraint? { return constraints.first }

	//MARK: - enum conversion

	public class func layoutAttributeFromEnum(_ attribute:PlanetUI.LayoutAttribute) -> NSLayoutAttribute {

		switch(attribute) {
		case .left:
			return .left
		case .right:
			return .right
		case .top:
			return .top
		case .bottom:
			return .bottom
		case .leading:
			return .leading
		case .trailing:
			return .trailing
		case .width:
			return .width
		case .height:
			return .height
		case .centerX:
			return .centerX
		case .centerY:
			return .centerY
		case .baseline:
			return .lastBaseline
        case .firstBaseline:
            return .firstBaseline
        case .lastBaseline:
            return .lastBaseline
		default:
			return .notAnAttribute
		}
	}

	public class func layoutRelationFromEnum(_ relation:PlanetUI.LayoutRelation) -> NSLayoutRelation {

		switch(relation) {
		case .lessThanOrEqual:
			return .lessThanOrEqual
		case .greaterThanOrEqual:
			return .greaterThanOrEqual
		default:
			return .equal
		}
	}

	//MARK: - convenience view accessors

	internal func firstView() -> UIView? {
		if let item = self.firstItem {
			if item == Constraint_parentKeyword {

				// avoid an infinite loop if both are looking for super view
				if let secondItem = secondItem, secondItem == Constraint_parentKeyword {
					return nil
				}
				return secondView()?.superview
			} else {
                if let itemView = (scope() as? Object)?.objectForId(item) as? View {
					return itemView.view
				}
			}
		}
		return nil
	}

	internal func secondView() -> UIView? {
		if let item = self.secondItem {
			if item == Constraint_parentKeyword {

				// avoid an infinite loop if both are looking for super view
				if let firstItem = firstItem, firstItem == Constraint_parentKeyword {
					return nil
				}
				return firstView()?.superview
			}
			else {
                if let itemView = (scope() as? Object)?.objectForId(item) as? View {
					return itemView.view
				}
			}
		}
		return nil
	}

	//MARK: - loading

	public override func gaxbDidPrepare() {
		super.gaxbDidPrepare()

        guard constraint == nil else { return }

        if let first = firstView() {
            let second = secondView()

            constraints = makeConstraints()
            if constraints.count == 1 {
                constraint?.identifier = id
            }

            first.translatesAutoresizingMaskIntoConstraints = false
            second?.translatesAutoresizingMaskIntoConstraints = false

            constraints.forEach { $0.priority = UILayoutPriority(rawValue: priority) }

            // attempt to figure out which view to add the constraint to, iOS will crash if we pick the wrong one
            if let second = second, first.isDescendant(of: second) {
                second.addConstraints(constraints)
            } else {
                first.superview?.addConstraints(constraints)
            }
        } else {
            print("Unable to create Constratint: firstItem not found")
        }
	}

    public func makeConstraints() -> [NSLayoutConstraint] {
        guard let first = firstView() else { return [] }
        let second = secondView()
        
        switch ruleSet {
        case .fillSuperview:
            let superview = first.superview
            return [NSLayoutConstraint(item: first, toItem: superview, equalAttribute: .top),
                NSLayoutConstraint(item: first, toItem: superview, equalAttribute: .right),
                NSLayoutConstraint(item: first, toItem: superview, equalAttribute: .bottom),
                NSLayoutConstraint(item: first, toItem: superview, equalAttribute: .left)]
        case .equalSize:
            return [NSLayoutConstraint(item: first, toItem: second, equalAttribute: .width),
                NSLayoutConstraint(item: first, toItem: second, equalAttribute: .height)]
        case .equalCenter:
            return [NSLayoutConstraint(item:first, toItem: second, equalAttribute: .centerX),
                NSLayoutConstraint(item:first, toItem: second, equalAttribute: .centerY)]
        case .square:
            return [NSLayoutConstraint(item: first, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: CGFloat(constant)),
                NSLayoutConstraint(item: first, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: CGFloat(constant))]
        default:
            let firstLayoutAttribute = Constraint.layoutAttributeFromEnum(firstAttribute)
            if firstLayoutAttribute == .notAnAttribute {
                assertionFailure("First layout attribute invalid: \(firstAttribute)")
            }
            let secondLayoutAttribute = Constraint.layoutAttributeFromEnum(secondAttribute)
            return [NSLayoutConstraint(item: first,
                                       attribute: firstLayoutAttribute,
                                       relatedBy: Constraint.layoutRelationFromEnum(relation),
                                       toItem: second,
                                       attribute: secondLayoutAttribute,
                                       multiplier: CGFloat(multiplier),
                                       constant: CGFloat(constant))]
        }
    }
}

extension NSLayoutConstraint {
    public convenience init(item: UIView, toItem: UIView?, equalAttribute attribute: NSLayoutAttribute) {
        self.init(item: item, attribute: attribute, relatedBy:.equal, toItem:toItem, attribute: attribute, multiplier: 1, constant: 0)
    }
}
