import SwiftUI

struct ListView: View {
	@ObservedObject var model: Model
	
	var body: some View {
		VStack {
			if let rows = model.feed?.items {
				List(rows, id: \.url) { row in
					NavigationLink(destination: DetailView(model: model, article: row)) {
						HStack {
							let isRead = model.isReadStatuses[row.url] ?? false 
							Image(systemName: isRead ? "checkmark.circle" : "circle")
							Text(row.title)
						}
					}
				}
			} else {
				List([0], id: \.self) { _ in Text("Loading") }
			}
			Button(action: model.reload) { Text("Reload feed") }.padding()
		}
		.navigationTitle(Text("Articles"))
		.navigationBarTitleDisplayModeIfAvailable(.inline)
	}
}

#if DEBUG
struct ListView_Previews: PreviewProvider {
	static var previews: some View {
		let model = Model()
		ListView(model: model)
	}
}
#endif
