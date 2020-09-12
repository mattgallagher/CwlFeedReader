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
	@Published var error: IdentifiableError?
	@Published var isReadStatuses: [URL: Bool]
	
	var task: URLSessionDataTask?
	init() {
		self.isReadStatuses = UserDefaults.standard.data(forKey: "isReadStatuses")
			.flatMap { try? JSONDecoder().decode([URL: Bool].self, from: $0) } ?? [:]
		reload()
	}
	
	func setIsRead(_ value: Bool, url: URL) {
		var statuses = isReadStatuses
		statuses[url] = value
		isReadStatuses = statuses
		UserDefaults.standard.set(try? JSONEncoder().encode(isReadStatuses), forKey: "isReadStatuses")
	}
	
	func reload() {
		let request = URLRequest(url: URL(string: "https://www.cocoawithlove.com/feed.json")!)
		task = URLSession.shared.dataTask(with: request) { data, response, error in
			do {
				if let error = error { throw error }
				let feed = try JSONDecoder().decode(Feed.self, from: data ?? Data())
				DispatchQueue.main.async { self.feed = feed }
			} catch {
				DispatchQueue.main.async { self.error = IdentifiableError(underlying: error) }
			}
		}
		task?.resume()
	}
}
