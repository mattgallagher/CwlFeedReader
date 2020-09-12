import Foundation

struct Feed: Codable {
	let items: [Article]
}

struct Article: Codable {
	let url: URL
	let title: String
	let content: String

	enum CodingKeys: String, CodingKey {
		case url, title, content = "content_html"
	}
}

class Model: ObservableObject {
	@Published var feed: Feed?
	
	var task: URLSessionDataTask?
	init() {
		let request = URLRequest(url: URL(string: "https://www.cocoawithlove.com/feed.json")!)
		task = URLSession.shared.dataTask(with: request) { data, response, error in
			do {
				if let error = error { throw error }
				let feed = try JSONDecoder().decode(Feed.self, from: data ?? Data())
				DispatchQueue.main.async { self.feed = feed }
			} catch {}
		}
		task?.resume()
	}
}
