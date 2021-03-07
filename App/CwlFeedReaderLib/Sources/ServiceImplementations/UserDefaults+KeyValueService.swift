import Foundation
import Model

extension UserDefaults: KeyValueService {
	public subscript<C: Codable>(key key: String, type type: C.Type) -> C? {
		get {
			data(forKey: key).flatMap { try? JSONDecoder().decode(C.self, from: $0) }
		}
		set {
			set(try? JSONEncoder().encode(newValue), forKey: key)
		}
	}
}
