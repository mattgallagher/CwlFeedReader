import Combine
import Foundation
import Model

public extension Services {
	static var mock: Services {
		return Services(networkService: MockNetworkService(), keyValueService: MockKeyValueService())
	}
}

class MockNetworkService: NetworkService {
	func fetchData(with request: URLRequest, handler: @escaping (Data?, URLResponse?, Error?) -> Void) -> AnyCancellable {
		guard let method = request.httpMethod, let url = request.url else {
			handler(nil, nil, URLError(.badURL))
			return AnyCancellable {}
		}
		
		switch "\(method) \(url.absoluteString)" {
		case "GET https://www.cocoawithlove.com/feed.json": handler(mockFixture(name: "feed.json"), .successResponse(url), nil)
		default: handler(nil, .notFoundResponse(url), URLError(.fileDoesNotExist))
		}
		
		return AnyCancellable {}
	}
}

private extension URLResponse {
	static func successResponse(_ url: URL) -> URLResponse {
		HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)!
	}
	
	static func notFoundResponse(_ url: URL) -> URLResponse {
		HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)!
	}
}

class MockKeyValueService: KeyValueService {
	var content: [String: Data] = [:]
	subscript<C: Codable>(key key: String, type type: C.Type) -> C? {
		get {
			content[key].flatMap { try? JSONDecoder().decode(C.self, from: $0) }
		}
		set {
			if let value = newValue, let data = try? JSONEncoder().encode(value) {
				content[key] = data
			} else {
				content.removeValue(forKey: key)
			}
		}
	}
}
