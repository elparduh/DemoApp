import Foundation

extension URL {

    public init(safeString string: String) {
        guard
            let decodedString = string.removingPercentEncoding,
            let encodedString = decodedString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
            let instance = URL(string: encodedString)
        else {
            fatalError("Unconstructable URL: \(string)")
        }
        self = instance
    }
    
    func replaceQueryItemValue(_ name: String, value: Any?) -> URL {
        guard
            let value = value,
            !"\(value)".isEmpty,
            var urlComponents = URLComponents(string: absoluteString)
        else { return self }
        
        urlComponents.queryItems = urlComponents.queryItems?.filter { $0.name != name } ?? []
        urlComponents.queryItems?.append(URLQueryItem(name: name, value: "\(value)"))
        return urlComponents.url ?? self
    }
    
    var getQueryParameters: [String: String]? {
        guard
            let components = URLComponents(url: self, resolvingAgainstBaseURL: true),
            let queryItems = components.queryItems else { return nil }
        return queryItems.reduce(into: [String: String]()) { (result, item) in
            result[item.name] = item.value?.removingPercentEncoding
        }
    }
}

extension Array where Element == URLQueryItem {
    
    func getParameterValue(paramName: String) -> String? {
        return first(where: { $0.name == paramName })?.value
    }
}
