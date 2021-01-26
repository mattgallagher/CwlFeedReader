import SwiftUI

@main
struct CwlFeedReaderApp: App {
	@StateObject var model = Model()
	var body: some Scene {
		WindowGroup {
			ContentView(model: model)
		}
	}
}
