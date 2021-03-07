import Model
import ServiceImplementations
import SwiftUI

@main
struct CwlFeedReaderApp: App {
	@StateObject var model = Model(services: Services())
	var body: some Scene {
		WindowGroup {
			ContentView(model: model)
		}
	}
}
