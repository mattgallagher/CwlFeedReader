import SwiftUI

struct ContentView: View {
	@ObservedObject var model: Model
	
	var body: some View {
		NavigationView {
			List(model.feed?.items ?? [], id: \.url) { row in
				NavigationLink(destination: Text(row.content)) {
					Text(row.title)
				}
			}
			Color.clear
		}
		.navigationViewStyle(DoubleColumnNavigationViewStyle())
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView(model: Model())
	}
}
