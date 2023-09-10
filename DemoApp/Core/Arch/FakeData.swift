import Foundation

class FakeData: FakeDataProtocol {
    
    func loadJson<T>(with filePath: String) -> T where T : Decodable, T : Encodable {
        if let path = Bundle.main.path(forResource: filePath, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                return try JSONDecoder().decode(T.self, from: data)
            } catch {
                preconditionFailure("Something went wrong \(error)")
            }
        } else {
            preconditionFailure("File path not found")
        }
    }
    
    func localizeCopy(with key: String, and fileCopy: String) -> String {
        return key.localized(with: fileCopy)
    }
}
