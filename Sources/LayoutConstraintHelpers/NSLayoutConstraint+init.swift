#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

public extension NSLayoutConstraint {
	#if canImport(UIKit)
	typealias View = UIView
	#elseif canImport(AppKit)
	typealias View = NSView
	#endif

	convenience init(
		setting attribute: NSLayoutConstraint.Attribute,
		of view: View,
		to constant: CGFloat,
		relation: NSLayoutConstraint.Relation = .equal,
		multiplier: CGFloat = 1
	) {
		self.init(
			item: view, attribute: attribute,
			relatedBy: relation,
			toItem: nil, attribute: attribute,
			multiplier: multiplier, constant: constant
		)
	}

	convenience init(
		linking attribute: Attribute,
		of view: View,
		to otherAttribute: Attribute,
		of otherView: View,
		relation: Relation = .equal,
		multiplier: CGFloat = 1,
		constant: CGFloat = 0
	) {
		self.init(
			item: view, attribute: attribute,
			relatedBy: relation,
			toItem: otherView, attribute: otherAttribute,
			multiplier: multiplier, constant: constant
		)
	}

	convenience init(
		for attribute: Attribute,
		of view: View,
		matching otherView: View,
		relation: Relation = .equal,
		multiplier: CGFloat = 1,
		constant: CGFloat = 0
	) {
		self.init(
			item: view, attribute: attribute,
			relatedBy: relation,
			toItem: otherView, attribute: attribute,
			multiplier: multiplier, constant: constant
		)
	}
}
