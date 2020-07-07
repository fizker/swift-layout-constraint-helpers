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

		_ = view.constraints(for: size)
		_ = view.constraintForAspectRatio(size)
		_ = view.constraintForAspectRatio(width: 1, height: 2)

		_ = view.constraint(linking: .width, to: 5)
		_ = view.constraint(linking: .width, to: 5, relation: .equal)
		_ = view.constraint(linking: .width, to: 5, multiplier: 1)
		_ = view.constraint(linking: .width, to: 5, relation: .equal, multiplier: 1)

		_ = view.constraint(linking: .width, to: .height, of: view)
		_ = view.constraint(linking: .width, to: .height, of: view, constant: 0)
		_ = view.constraint(linking: .width, to: .height, of: view, multiplier: 1)
		_ = view.constraint(linking: .width, to: .height, of: view, relation: .equal)
		_ = view.constraint(linking: .width, to: .height, of: view, relation: .equal, constant: 0)
		_ = view.constraint(linking: .width, to: .height, of: view, relation: .equal, multiplier: 1)
		_ = view.constraint(linking: .width, to: .height, of: view, multiplier: 1, constant: 0)
		_ = view.constraint(linking: .width, to: .height, of: view, relation: .equal, multiplier: 1, constant: 0)
	}

	static var allTests = [
		("testExample", testExample),
	]
}
