import Foundation

func mockFixture(name: String) -> Data {
	 guard
		  let mockFixturesURL = Bundle.module.url(forResource: name, withExtension: nil),
		  let data = try? Data(contentsOf: mockFixturesURL)
	 else {
		  fatalError("Mock fixture \(name) not found.")
	 }
	 return data
}
