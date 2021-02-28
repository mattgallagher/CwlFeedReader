// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "CwlFeedReaderLib",
	platforms: [.iOS(.v14), .macOS(.v11)],
	products: [
		.library(
			name: "CwlFeedReaderLib",
			targets: ["Model", "Toolbox", "ViewToolbox"]
		),
	],
	targets: [
		.target(
			name: "Model",
			dependencies: ["Toolbox"]
		),
		.target(
			name: "Toolbox",
			dependencies: []
		),
		.target(
			name: "ViewToolbox",
			dependencies: ["Toolbox"]
		),
		.testTarget(
			name: "ModelTests",
			dependencies: ["Model", "Toolbox"]
		)
	]
)
