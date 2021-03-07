import Combine
import Foundation

public protocol NetworkService {
	func fetchData(with: URLRequest, handler: @escaping (Data?, URLResponse?, Error?) -> Void) -> AnyCancellable
}

public protocol KeyValueService: class {
	subscript<C: Codable>(key key: String, type type: C.Type) -> C? { get set }
}

public struct Services {
	public init(networkService: NetworkService, keyValueService: KeyValueService) {
		self.networkService = networkService
		self.keyValueService = keyValueService
	}
	
	let networkService: NetworkService
	let keyValueService: KeyValueService
}
