import Combine
import Foundation
import Model

extension URLSessionDataTask: Cancellable {}

extension URLSession: NetworkService {
	public func fetchData(with request: URLRequest, handler: @escaping (Data?, URLResponse?, Error?) -> Void) -> AnyCancellable {
		let task = dataTask(with: request, completionHandler: handler)
		task.resume()
		return AnyCancellable(task)
	}
}
