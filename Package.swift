// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "swift-layout-constraint-helpers",
	products: [
		// Products define the executables and libraries produced by a package, and make them visible to other packages.
		.library(
			name: "LayoutConstraintHelpers",
			targets: ["LayoutConstraintHelpers"]
		),
	],
	dependencies: [
	],
	targets: [
		.target(
			name: "LayoutConstraintHelpers",
			dependencies: []
		),
		.testTarget(
			name: "LayoutConstraintHelpersTests",
			dependencies: ["LayoutConstraintHelpers"]
		),
	]
)
