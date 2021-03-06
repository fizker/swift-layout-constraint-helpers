#if canImport(UIKit)
import UIKit
#endif
#if canImport(AppKit)
import AppKit
#endif

/// Protocol for easily putting the helpers on other types. The logic is implemented as extension methods for this
/// protocol, so any object can conform to it, as long as NSLayoutConstraint can work with that base type.
///
/// The library already adds support for UIView and NSView like so
/// ```
/// #if canImport(UIKit)
/// extension UIView: NSLayoutConstraintHelper {
///   public typealias View = UIView
/// }
/// #endif
/// #if canImport(AppKit)
/// extension NSView: NSLayoutConstraintHelper {
///   public typealias View = NSView
/// }
/// #endif
/// ```
public protocol NSLayoutConstraintHelper {
	associatedtype View
}

#if canImport(UIKit)
extension UIView: NSLayoutConstraintHelper {
	public typealias View = UIView
}

extension UILayoutGuide: NSLayoutConstraintHelper {
	public typealias View = UIView
}
#endif
#if canImport(AppKit)
extension NSView: NSLayoutConstraintHelper {
	public typealias View = NSView
}
#endif

extension NSLayoutConstraintHelper {
	/// Creates constraints for enforcing width and height to match the size in the given `CGSize`.
	/// - Parameter size: `CGSize` describing the wanted width and height.
	/// - Parameter priority: The priority of the constraint. Defaults to `.required`.
	/// - Returns: The necessary constraints to represent both width and height.
	public func constraints(for size: CGSize, priority: NSLayoutConstraint.Priority = .required) -> [NSLayoutConstraint] {
		return [
			constraint(setting: .width, to: size.width, priority: priority),
			constraint(setting: .height, to: size.height, priority: priority),
		]
	}

	/// Returns a constraint that enforces the same aspect ratio as the given `CGSize`.
	///
	/// To constrain to a 4:3 aspect ratio, call with
	/// ```
	/// let aspectRatio4_3 = CGSize(width: 4, height: 3)
	/// let constraint = constraintForAspectRatio(aspectRatio4_3)
	/// ```
	/// - Parameter size: A `CGSize` with the wanted aspect ratio.
	/// - Parameter priority: The priority of the constraint. Defaults to `.required`.
	/// - Returns: An `NSLayoutConstraint` enforcing the aspect ratio.
	public func constraintForAspectRatio(_ size: CGSize, priority: NSLayoutConstraint.Priority = .required) -> NSLayoutConstraint {
		return constraintForAspectRatio(width: size.width, height: size.height, priority: priority)
	}

	/// Returns a constraint that enforces the same aspect ratio as the given `CGSize`.
	///
	/// To constrain to a 4:3 aspect ratio, call with
	/// ```
	/// let constraint = constraintForAspectRatio(width: 4, height: 3)
	/// ```
	///
	/// - Parameter width: The width aspect of the aspect ratio.
	/// - Parameter height: The height aspect of the aspect ratio.
	/// - Parameter priority: The priority of the constraint. Defaults to `.required`.
	/// - Returns: An `NSLayoutConstraint` enforcing the aspect ratio.
	public func constraintForAspectRatio(
		width: CGFloat,
		height: CGFloat,
		priority: NSLayoutConstraint.Priority = .required
	) -> NSLayoutConstraint {
		let factor = width / height

		let c = NSLayoutConstraint(
			item: self, attribute: .width,
			relatedBy: .equal,
			toItem: self, attribute: .height,
			multiplier: factor,
			constant: 0
		)
		c.priority = priority
		return c
	}

	/// Creates an `NSLayoutConstraint` that binds an attribute on this view to a constant value.
	///
	/// - Parameter attribute: The primary attribute for the constraint.
	/// - Parameter constant: The constant value.
	/// - Parameter relation: The relation for the value. Defaults to `.equal`.
	/// - Parameter multiplier: The multiplier for the value. Defaults to `1.0`.
	/// - Parameter priority: The priority of the constraint. Defaults to `.required`.
	/// - Returns: An `NSLayoutConstraint` matching the given criteria.
	public func constraint(
		setting attribute: NSLayoutConstraint.Attribute,
		to constant: CGFloat,
		relation: NSLayoutConstraint.Relation = .equal,
		multiplier: CGFloat = 1,
		priority: NSLayoutConstraint.Priority = .required
	) -> NSLayoutConstraint
	{
		let c = NSLayoutConstraint(
			item: self, attribute: attribute,
			relatedBy: relation,
			toItem: nil, attribute: attribute,
			multiplier: multiplier, constant: constant
		)
		c.priority = priority
		return c
	}

	/// Creates an `NSLayoutConstraint` between the given attribute of this view and the specified attributes of the specified view.
	///
	/// - Parameter attribute: The attribute of the current view.
	/// - Parameter otherAttribute: The attribute of the other view.
	/// - Parameter view: The other view.
	/// - Parameter relation: The relation for the value. Defaults to `.equal`.
	/// - Parameter multiplier: The multiplier for the value. Defaults to `1.0`.
	/// - Parameter constant: The constant value for the constraint. Defaults to `0`.
	/// - Parameter priority: The priority of the constraint. Defaults to `.required`.
	/// - Returns: An `NSLayoutConstraint` matching the given criteria.
	public func constraint(
		linking attribute: NSLayoutConstraint.Attribute,
		to otherAttribute: NSLayoutConstraint.Attribute,
		of view: View,
		relation: NSLayoutConstraint.Relation = .equal,
		multiplier: CGFloat = 1,
		constant: CGFloat = 0,
		priority: NSLayoutConstraint.Priority = .required
	) -> NSLayoutConstraint
	{
		let c = NSLayoutConstraint(
			item: self, attribute: attribute,
			relatedBy: relation,
			toItem: view, attribute: otherAttribute,
			multiplier: multiplier, constant: constant
		)
		c.priority = priority
		return c
	}

	/// Creates an `NSLayoutConstraint` between the given attribute of this view and the specified view.
	///
	/// - Parameter attribute: The attribute in question.
	/// - Parameter view: The other view.
	/// - Parameter relation: The relation for the value. Defaults to `.equal`.
	/// - Parameter multiplier: The multiplier for the value. Defaults to `1.0`.
	/// - Parameter constant: The constant value for the constraint. Defaults to `0`.
	/// - Parameter priority: The priority of the constraint. Defaults to `.required`.
	/// - Returns: An `NSLayoutConstraint` matching the given criteria.
	public func constraint(
		for attribute: NSLayoutConstraint.Attribute,
		matching view: View,
		relation: NSLayoutConstraint.Relation = .equal,
		multiplier: CGFloat = 1,
		constant: CGFloat = 0,
		priority: NSLayoutConstraint.Priority = .required
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

#if canImport(UIKit)
@available(iOS 9.0, *)
extension NSLayoutConstraintHelper {
	/// Creates an `NSLayoutConstraint` between the given attribute of this view and the specified attributes of the specified view.
	///
	/// - Parameter attribute: The attribute of the current view.
	/// - Parameter otherAttribute: The attribute of the other view.
	/// - Parameter layoutGuide: The other layout guide.
	/// - Parameter relation: The relation for the value. Defaults to `.equal`.
	/// - Parameter multiplier: The multiplier for the value. Defaults to `1.0`.
	/// - Parameter constant: The constant value for the constraint. Defaults to `0`.
	/// - Parameter priority: The priority of the constraint. Defaults to `.required`.
	/// - Returns: An `NSLayoutConstraint` matching the given criteria.
	public func constraint(
		linking attribute: NSLayoutConstraint.Attribute,
		to otherAttribute: NSLayoutConstraint.Attribute,
		of layoutGuide: UILayoutGuide,
		relation: NSLayoutConstraint.Relation = .equal,
		multiplier: CGFloat = 1,
		constant: CGFloat = 0,
		priority: NSLayoutConstraint.Priority = .required,
		isActive: Bool = true
	) -> NSLayoutConstraint
	{
		let c = NSLayoutConstraint(
			item: self, attribute: attribute,
			relatedBy: relation,
			toItem: layoutGuide, attribute: otherAttribute,
			multiplier: multiplier, constant: constant
		)
		c.priority = priority
		c.isActive = isActive
		return c
	}

	/// Creates an `NSLayoutConstraint` between the given attribute of this view and the specified view.
	///
	/// - Parameter attribute: The attribute in question.
	/// - Parameter layoutGuide: The other layout guide.
	/// - Parameter relation: The relation for the value. Defaults to `.equal`.
	/// - Parameter multiplier: The multiplier for the value. Defaults to `1.0`.
	/// - Parameter constant: The constant value for the constraint. Defaults to `0`.
	/// - Parameter priority: The priority of the constraint. Defaults to `.required`.
	/// - Returns: An `NSLayoutConstraint` matching the given criteria.
	public func constraint(
		for attribute: NSLayoutConstraint.Attribute,
		matching layoutGuide: UILayoutGuide,
		relation: NSLayoutConstraint.Relation = .equal,
		multiplier: CGFloat = 1,
		constant: CGFloat = 0,
		priority: NSLayoutConstraint.Priority = .required
	) -> NSLayoutConstraint
	{
		return constraint(
			linking: attribute,
			to: attribute, of: layoutGuide,
			relation: relation,
			multiplier: multiplier,
			constant: constant
		)
	}
}
#endif
