import Foundation
import Model

extension Services {
	public init() {
		self.init(networkService: URLSession.shared, keyValueService: UserDefaults.standard)
	}
}
