import Model
import SwiftUI
import ViewToolbox

struct DetailView: View {
	@ObservedObject var model: Model
	let article: Article
	
	var isRead: Bool { model.isReadStatuses[article.url] ?? false }
	
	var body: some View {
		WebView(content: .string(article.content))
			.navigationTitle(Text(article.title))
			.navigationBarItems(
				trailing:
					Button {
						model.setIsRead(!isRead, url: article.url)
					} label: {
						Text(isRead ? "Mark as unread" : "Mark as read")
					}
			)
			.navigationBarTitleDisplayModeIfAvailable(.inline)
			.onAppear { model.setIsRead(true, url: article.url) }
	}
}

#if DEBUG
struct DetailView_Previews: PreviewProvider {
	static var previews: some View {
		let model = Model()
		DetailView(model: model, article: model.feed!.items.first!)
	}
}
#endif
