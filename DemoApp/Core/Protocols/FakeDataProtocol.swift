import Foundation

protocol FakeDataProtocol {
    func loadJson<T: Codable>(with filePath: String) -> T
    func localizeCopy(with key: String, and fileCopy: String) -> String
}
