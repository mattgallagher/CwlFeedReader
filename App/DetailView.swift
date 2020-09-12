import SwiftUI

struct DetailView: View {
	let row: Article
	
	var body: some View {
		WebView(content: row.content)
			.navigationTitle(Text(row.title))
			.navigationBarTitleDisplayModeIfAvailable(.inline)
	}
}
