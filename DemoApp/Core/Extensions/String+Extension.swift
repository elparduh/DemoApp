import Foundation

import Foundation
import UIKit

extension String {
    
    static let empty = ""
    static let whitespace = " "
    static let hyphenspace = " - "
    static let greaterThan = ">"
    static let ellipsis = " ... "
    static let zeroDigitsFormat = "%.0f"
    static let twoDigitsFormat = "%.2f"
    static let brZipCodeMask = "#####-###"
    static let mxZipCodeMask = "#####"
    static let cpfMask = "###.###.###-##"
    static let dniMask = "########"
    static let productEncodePrefix = "Product:"
    static let categoryEncodePrefix = "Category:"
    static let collectionEncodePrefix = "Collection:"
    static let orderEncodePrefix = "Order:"
    static let amountFormat = "%.2f"
    
    static func localizeString(for text: String, argument: String = .empty) -> String {
        return String.localizedStringWithFormat(NSLocalizedString(text, comment: .empty), argument)
    }
    
    // TODO: Unify String Extensions to Localize Strings https://justo.atlassian.net/browse/IOS-822
    static func localizedString(key: String, arguments: CVarArg...) -> String {
        let localizedString = NSLocalizedString(key, comment: .empty)
        return String(format: localizedString, arguments: arguments)
    }
        
    func asAttributedText(with font: UIFont = .bodyRegular(),
                          color: UIColor = .black,
                          spacing: CGFloat = Constants.defaultLetterSpacing) -> NSAttributedString {
        return NSAttributedString(string: self, attributes: [NSAttributedString.Key.font: font,
                                                             NSAttributedString.Key.foregroundColor: color,
                                                             NSAttributedString.Key.kern: spacing ])
    }
    
    func withAttributedRange(of stringToFormat: String,
                             font: UIFont = .bodyBold(),
                             color: UIColor = .black) -> NSAttributedString {
        let range = (self as NSString).range(of: stringToFormat)
        
        let attributedString = NSMutableAttributedString.init(string: self)
        attributedString.addAttributes([NSAttributedString.Key.foregroundColor: color,
                                        NSAttributedString.Key.font: font], range: range)
        
        return attributedString
    }
    
    var fromHtmlToText: NSAttributedString? {
        do {
            guard let data = data(using: String.Encoding.utf8) else {
                return nil
            }
            return try NSAttributedString(data: data,
                                          options: [.documentType: NSAttributedString.DocumentType.html,
                                                    .characterEncoding: String.Encoding.utf8.rawValue],
                                          documentAttributes: nil)
        } catch {
            return nil
        }
    }
    
    func formatByMask(pattern: String) -> String {
        let cleanDigits = components(separatedBy: .decimalDigits.inverted).joined()
        let numberCharacter: Character = "#"
        var result = String.empty
        var index = cleanDigits.startIndex
        for character in pattern where index < cleanDigits.endIndex {
            if character == numberCharacter {
                result.append(cleanDigits[index])
                index = cleanDigits.index(after: index)
            } else {
                result.append(character)
            }
        }
        return result
    }
    
    func replacingCharacteres(in range: NSRange, with string: String) -> String {
         return (self as NSString).replacingCharacters(in: range, with: string)
    }

    func toURL() -> URL {
        return URL.init(safeString: self)
    }

    func asDouble() -> Double {
        return Double(self) ?? .zero
    }
    
    func base64Encoded() -> String {
        Data(utf8).base64EncodedString()
    }
    
    func base64Decoded() -> String {
        guard let data = Data(base64Encoded: self) else { return .empty }
        return String(data: data, encoding: .utf8) ?? .empty
    }

    func asDigitDecode() -> String {
        return base64Decoded().filter { $0.isNumber }
    }
    
    func asData() -> Data {
        return self.data(using: .utf8)!
    }
    
    func toDictionary() -> [String:AnyObject] {
        guard let data = data(using: .utf8) else { return [:] }
        do {
            return try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String:AnyObject]
        } catch {
            return [:]
        }
    }
    
    func valueOrNil() -> String? {
        return isEmpty ? nil : self
    }
    
    func asHexColorOrDefault() -> UIColor {
        return UIColor(named: self) ?? .white
    }
    
    func getSize(font: UIFont = .bodyRegular()) -> CGSize {
        let attributes = [NSAttributedString.Key.font: font]
        return NSString(string: self).size(withAttributes: attributes)
    }
    
    func trim() -> String {
        trimmingCharacters(in: NSCharacterSet.whitespaces)
    }

    func asBase64Id(prefix: String) -> Self {
        guard !isEmpty else { return .empty }
        return "\(prefix)\(self)".base64Encoded()
    }
    
    func isNotEmpty() -> Bool {
        !trim().isEmpty
    }
    
    func localized(with table: String) -> String {
        let localized = NSLocalizedString(self,
                                          tableName: table,
                                          comment: "")
        return localized
    }
}

extension NSAttributedString {
    
    static func attributed(string: String,
                           with font: UIFont = .bodyRegular(),
                           color: UIColor = .black,
                           spacing: CGFloat = Constants.defaultLetterSpacing) -> NSAttributedString {
        return NSAttributedString(string: .localizeString(for: string), attributes: [NSAttributedString.Key.font: font,
                                                               NSAttributedString.Key.foregroundColor: color,
                                                               NSAttributedString.Key.kern: spacing ])
    }
}

extension Optional where Wrapped == String {

    func orDefaultString() -> String {
        return self ?? ""
    }
}

extension Optional where Wrapped == [String] {

    func orDefaultArray() -> [String] {
        return self ?? []
    }
}

