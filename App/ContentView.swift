import SwiftUI

struct ContentView: View {
	let articles = ["one", "two", "three"]
	var body: some View {
		NavigationView {
			List(articles, id: \.self) { article in
				NavigationLink(destination: Text(article)) {
					Text(article)
				}
			}
			Color.clear
		}
		.navigationViewStyle(DoubleColumnNavigationViewStyle())
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
