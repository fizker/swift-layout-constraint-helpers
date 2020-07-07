#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

public extension NSLayoutConstraint {
	#if canImport(UIKit)
	typealias View = UIView

	// This normalises to AppKit variant and to the other properties (Attribute, Relation)
	typealias Priority = UILayoutPriority

	#elseif canImport(AppKit)
	typealias View = NSView
	#endif

	convenience init(
		setting attribute: Attribute,
		of view: View,
		to constant: CGFloat,
		relation: Relation = .equal,
		multiplier: CGFloat = 1,
		priority: Priority = .required,
		isActive: Bool = true
	) {
		self.init(
			item: view, attribute: attribute,
			relatedBy: relation,
			toItem: nil, attribute: attribute,
			multiplier: multiplier, constant: constant
		)
		self.priority = priority
		self.isActive = isActive
	}

	convenience init(
		linking attribute: Attribute,
		of view: View,
		to otherAttribute: Attribute,
		of otherView: View,
		relation: Relation = .equal,
		multiplier: CGFloat = 1,
		constant: CGFloat = 0,
		priority: Priority = .required,
		isActive: Bool = true
	) {
		self.init(
			item: view, attribute: attribute,
			relatedBy: relation,
			toItem: otherView, attribute: otherAttribute,
			multiplier: multiplier, constant: constant
		)
		self.priority = priority
		self.isActive = isActive
	}

	convenience init(
		for attribute: Attribute,
		of view: View,
		matching otherView: View,
		relation: Relation = .equal,
		multiplier: CGFloat = 1,
		constant: CGFloat = 0,
		priority: Priority = .required,
		isActive: Bool = true
	) {
		self.init(
			linking: attribute, of: view,
			to: attribute, of: otherView,
			relation: relation,
			multiplier: multiplier, constant: constant,
			priority: priority, isActive: isActive
		)
	}
}
