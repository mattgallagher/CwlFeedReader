import Foundation

public struct IdentifiableError: Error, Identifiable {
	public let underlying: Error
	public init(underlying: Error) {
		self.underlying = underlying
	}
	
	public var id: String {
		localizedDescription
	}
	
	public var localizedDescription: String {
		underlying.localizedDescription
	}
}
