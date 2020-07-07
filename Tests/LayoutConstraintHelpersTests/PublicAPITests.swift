import XCTest
import LayoutConstraintHelpers

final class PublicAPITests: XCTestCase {
	func testExample() {
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
		("testExample", testExample),
	]
}
