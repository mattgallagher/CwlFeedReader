import Combine
import Foundation
import Toolbox

public struct Feed: Codable {
	public let items: [Article]
}

public struct Article: Codable {
	public let url: URL
	public let title: String
	public let content: String

	enum CodingKeys: String, CodingKey {
		case url, title, content = "content_html"
	}
}

public class Model: ObservableObject {
	@Published public private(set) var feed: Feed?
	@Published public var error: IdentifiableError?
	@Published public private(set) var isReadStatuses: [URL: Bool]
	
	var task: AnyCancellable?
	let services: Services
	public init(services: Services) {
		self.services = services
		self.isReadStatuses = services.keyValueService[key: "isReadStatuses", type: [URL: Bool].self] ?? [:]
		reload()
	}
	
	public func setIsRead(_ value: Bool, url: URL) {
		var statuses = isReadStatuses
		statuses[url] = value
		isReadStatuses = statuses
		services.keyValueService[key: "isReadStatuses", type: [URL: Bool].self] = isReadStatuses
	}
	
	public func reload() {
		let request = URLRequest(url: URL(string: "https://www.cocoawithlove.com/feed.json")!)
		task = services.networkService.fetchData(with: request) { data, response, error in
			do {
				if let error = error { throw error }
				let feed = try JSONDecoder().decode(Feed.self, from: data ?? Data())
				DispatchQueue.main.async { self.feed = feed }
			} catch {
				DispatchQueue.main.async { self.error = IdentifiableError(underlying: error) }
			}
		}
	}
}
