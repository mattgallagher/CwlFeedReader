import Model
import SwiftUI

struct ContentView: View {
	@ObservedObject var model: Model
	
	var body: some View {
		NavigationView {
			ListView(model: model)
			
			Color.clear
		}
		.navigationViewStyle(DoubleColumnNavigationViewStyle())
		.alert(item: $model.error) { error in
			Alert(title: Text(verbatim: error.localizedDescription))
		}
	}
}

#if DEBUG
import MockServiceImplementations
struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView(model: Model(services: Services.mock))
	}
}
#endif
