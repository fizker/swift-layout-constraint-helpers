import XCTest
import LayoutConstraintHelpers

final class PublicAPITests: XCTestCase {
	func inits() {
		#if canImport(UIKit)
		let view = UIView()
		#elseif canImport(AppKit)
		let view = NSView()
		#endif

		_ = NSLayoutConstraint(setting: .width, of: view, to: 5)
		_ = NSLayoutConstraint(setting: .width, of: view, to: 5, relation: .equal)
		_ = NSLayoutConstraint(setting: .width, of: view, to: 5, multiplier: 1)
		_ = NSLayoutConstraint(setting: .width, of: view, to: 5, relation: .equal, multiplier: 1)

		_ = NSLayoutConstraint(for: .width, of: view, matching: view)
		_ = NSLayoutConstraint(for: .width, of: view, matching: view, relation: .equal)
		_ = NSLayoutConstraint(for: .width, of: view, matching: view, multiplier: 1)
		_ = NSLayoutConstraint(for: .width, of: view, matching: view, relation: .equal, multiplier: 1)
		_ = NSLayoutConstraint(for: .width, of: view, matching: view, relation: .equal, constant: 0)
		_ = NSLayoutConstraint(for: .width, of: view, matching: view, multiplier: 1, constant: 0)
		_ = NSLayoutConstraint(for: .width, of: view, matching: view, relation: .equal, multiplier: 1, constant: 0)

		_ = NSLayoutConstraint(linking: .width, of: view, to: .height, of: view)
		_ = NSLayoutConstraint(linking: .width, of: view, to: .height, of: view, constant: 0)
		_ = NSLayoutConstraint(linking: .width, of: view, to: .height, of: view, multiplier: 1)
		_ = NSLayoutConstraint(linking: .width, of: view, to: .height, of: view, relation: .equal)
		_ = NSLayoutConstraint(linking: .width, of: view, to: .height, of: view, relation: .equal, constant: 0)
		_ = NSLayoutConstraint(linking: .width, of: view, to: .height, of: view, relation: .equal, multiplier: 1)
		_ = NSLayoutConstraint(linking: .width, of: view, to: .height, of: view, multiplier: 1, constant: 0)
		_ = NSLayoutConstraint(linking: .width, of: view, to: .height, of: view, relation: .equal, multiplier: 1, constant: 0)
	}
	func viewExtensions() {
		#if canImport(UIKit)
		let view = UIView()
		#elseif canImport(AppKit)
		let view = NSView()
		#endif

		let size = CGSize(width: 1, height: 2)

		view.addConstraints(view.constraints(for: size))
		view.addConstraints([
			view.constraintForAspectRatio(size),
			view.constraintForAspectRatio(width: 1, height: 2),

			view.constraint(setting: .width, to: 5),
			view.constraint(setting: .width, to: 5, relation: .equal),
			view.constraint(setting: .width, to: 5, multiplier: 1),
			view.constraint(setting: .width, to: 5, relation: .equal, multiplier: 1),

			view.constraint(for: .width, matching: view),
			view.constraint(for: .width, matching: view, relation: .equal),
			view.constraint(for: .width, matching: view, multiplier: 1),
			view.constraint(for: .width, matching: view, relation: .equal, multiplier: 1),
			view.constraint(for: .width, matching: view, relation: .equal, constant: 0),
			view.constraint(for: .width, matching: view, multiplier: 1, constant: 0),
			view.constraint(for: .width, matching: view, relation: .equal, multiplier: 1, constant: 0),

			view.constraint(linking: .width, to: .height, of: view),
			view.constraint(linking: .width, to: .height, of: view, constant: 0),
			view.constraint(linking: .width, to: .height, of: view, multiplier: 1),
			view.constraint(linking: .width, to: .height, of: view, relation: .equal),
			view.constraint(linking: .width, to: .height, of: view, relation: .equal, constant: 0),
			view.constraint(linking: .width, to: .height, of: view, relation: .equal, multiplier: 1),
			view.constraint(linking: .width, to: .height, of: view, multiplier: 1, constant: 0),
			view.constraint(linking: .width, to: .height, of: view, relation: .equal, multiplier: 1, constant: 0),
		])
	}

	static var allTests = [
		("inits", inits),
		("viewExtensions", viewExtensions),
	]
}
