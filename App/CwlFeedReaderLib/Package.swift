// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "CwlFeedReaderLib",
	platforms: [.iOS(.v14), .macOS(.v11)],
	products: [
		.library(
			name: "CwlFeedReaderLib",
			targets: ["Model", "ServiceImplementations", "Toolbox", "ViewToolbox"]
		),
		.library(
			name: "MockServiceImplementations",
			targets: ["MockServiceImplementations"]
		)
	],
	targets: [
		.target(
			name: "MockServiceImplementations",
			dependencies: ["Model", "Toolbox"],
			resources: [.process("Fixtures")]
		),
		.target(
			name: "Model",
			dependencies: ["Toolbox"]
		),
		.target(
			name: "ServiceImplementations",
			dependencies: ["Model", "Toolbox"]
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
			dependencies: ["MockServiceImplementations", "Model", "Toolbox"]
		)
	]
)
