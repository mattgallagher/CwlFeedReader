import Model
import XCTest

class ModelTests: XCTestCase {
	let feedFirstURL = URL(string: "https://www.cocoawithlove.com/blog/swiftui-natural-pattern.html")!
	
	func testInit() {
		// Given clean state
		UserDefaults.standard.removeObject(forKey: "isReadStatuses")
		
		// When we init the model
		let model = Model()
		
		// Then all values should be `nil`
		XCTAssertNil(model.isReadStatuses[feedFirstURL])
		XCTAssertNil(model.feed)
		XCTAssertNil(model.error)
	}
	
	func testReload() {
		// Given a newly inited model and an expectation that stops on the second feed value
		let model = Model()
		let secondValue = expectation(description: "feed should emit 2 values.")
		let cancellable = model.$feed
			.dropFirst()
			.sink { _ in secondValue.fulfill() }
		
		// When the automatically invoked `reload()` completes
		wait(for: [secondValue], timeout: 30.0)
		cancellable.cancel()
		
		// Then first feed URL should be SwiftUI natural pattern
		XCTAssertEqual(model.feed?.items.map(\.url).first, feedFirstURL)
	}
	
	func testSetIsRead() {
		// Given a clean model and an expectation that stops when we've saved 3 isReadStatuses values
		UserDefaults.standard.removeObject(forKey: "isReadStatuses")
		let model = Model()
		var isReadStatuses = [[URL: Bool]]()
		let cancellable = model.$isReadStatuses
			.prefix(3)
			.sink { isReadStatuses.append($0) }
		
		// When we call setIsRead a couple times
		model.setIsRead(true, url: feedFirstURL)
		model.setIsRead(false, url: feedFirstURL)
		cancellable.cancel()
		
		// Then we see the expected changes in the `isReadStatuses` value
		XCTAssertEqual(
			isReadStatuses,
			[[:], [feedFirstURL: true], [feedFirstURL: false]]
		)
	}
}
