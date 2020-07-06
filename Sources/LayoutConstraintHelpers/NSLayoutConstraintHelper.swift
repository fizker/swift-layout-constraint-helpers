#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

public protocol NSLayoutConstraintHelper {
	associatedtype View
}

#if canImport(UIKit)
extension UIView: NSLayoutConstraintHelper {
	public typealias View = UIView
}
#elseif canImport(AppKit)
extension NSView: NSLayoutConstraintHelper {
	public typealias View = NSView
}
#endif

extension NSLayoutConstraintHelper {
	public func constraints(for size: CGSize) -> [NSLayoutConstraint] {
		return [
			constraint(linking: .width, to: size.width),
			constraint(linking: .height, to: size.height),
		]
	}

	public func constraintLinkingWidthAndHeight(proportionalTo size: CGSize) -> NSLayoutConstraint {
		return constraintLinking(width: size.width, height: size.height)
	}

	public func constraintLinking(width: CGFloat, height: CGFloat) -> NSLayoutConstraint {
		return constraintLinkingWidthAndHeight(factor: width / height)
	}

	public func constraintLinkingWidthAndHeight(factor: CGFloat) -> NSLayoutConstraint {
		return NSLayoutConstraint(
			item: self, attribute: .width,
			relatedBy: .equal,
			toItem: self, attribute: .height,
			multiplier: factor,
			constant: 0
		)
	}

	public func constraint(
		linking attribute: NSLayoutConstraint.Attribute,
		to constant: CGFloat,
		relation: NSLayoutConstraint.Relation = .equal,
		multiplier: CGFloat = 1
	) -> NSLayoutConstraint
	{
		return NSLayoutConstraint(
			item: self, attribute: attribute,
			relatedBy: relation,
			toItem: nil, attribute: attribute,
			multiplier: multiplier, constant: constant
		)
	}

	public func constraint(
		linking attribute: NSLayoutConstraint.Attribute,
		to otherAttribute: NSLayoutConstraint.Attribute,
		of view: View,
		relation: NSLayoutConstraint.Relation = .equal,
		multiplier: CGFloat = 1,
		constant: CGFloat = 0
	) -> NSLayoutConstraint
	{
		return NSLayoutConstraint(
			item: self, attribute: attribute,
			relatedBy: relation,
			toItem: view, attribute: otherAttribute,
			multiplier: multiplier, constant: constant
		)
	}

	public func constraint(
		linking attribute: NSLayoutConstraint.Attribute,
		to view: View,
		relation: NSLayoutConstraint.Relation = .equal,
		multiplier: CGFloat = 1,
		constant: CGFloat = 0
	) -> NSLayoutConstraint
	{
		return constraint(
			linking: attribute,
			to: attribute, of: view,
			relation: relation,
			multiplier: multiplier,
			constant: constant
		)
	}
}
