import Foundation
import UIKit

extension UILabel {
    
    func setStyle(with font: UIFont = .bodyRegular(),
                  color: UIColor = .black,
                  spacing: CGFloat = Constants.defaultLetterSpacing) {
        self.font = font
        self.textColor = color
        self.attributedText = NSAttributedString(string: self.text.orDefaultString(), attributes: [NSAttributedString.Key.kern: spacing])
    }
    
    func strikeThroughText() {
        let strikethroughString =  NSMutableAttributedString(string: self.text.orDefaultString())
        strikethroughString.addAttribute(NSAttributedString.Key.strikethroughStyle,
                                         value: Int.one,
                                         range: NSMakeRange(.zero, strikethroughString.length))
        self.attributedText = strikethroughString
    }
    
    func resetAttributedText() {
        let string = attributedText?.string
        self.attributedText = nil
        self.text = string
    }
    
    func setBadgeStyle(with badgeValue: Int) {
        self.frame = CGRect(x: Constants.badgeLabelOriginX, y: Constants.badgeLabelOriginY, width: Constants.badgeLabelWidthHeight, height: Constants.badgeLabelWidthHeight)
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.borderWidth = Constants.badgeLabelBorderWidth
        self.layer.cornerRadius = self.bounds.size.height / Constants.badgeLabelBorderWidth
        self.textAlignment = .center
        self.layer.masksToBounds = true
        self.font = .bodyRegular(with: .font11)
        self.textColor = .white
        self.backgroundColor = .brickRed
        self.text = String(badgeValue)
    }
    
    func setToastStyle(with message: String, isSuccesStyle: Bool) {
        self.backgroundColor = isSuccesStyle ? .darkBlueGreen20Solid : .brickRed20Solid
        self.textColor = isSuccesStyle ? .darkBlueGreen : .brickRed
        self.font = .bodyRegular(with: .font15)
        self.textAlignment = .center
        self.numberOfLines = .zero
        self.text = .localizeString(for: message)
        self.alpha = Constants.fullAlpha
        self.layer.cornerRadius = .point8
        self.clipsToBounds = true
    }
    
    func setHtmlText(_ htmlText: String, font: UIFont? = nil) {
        let fontName = font?.fontName ?? "-apple-system"
        let fontSize = font?.pointSize ?? .zero
        let styledText = """
        <span style=\"font-family: '\(fontName)', 'SFProText-Bold'; font-size: \(fontSize)\">
            \(htmlText)
        </span>
        """
        guard let data = styledText.data(using: .unicode, allowLossyConversion: true) else { return }
        
        do {
            let documentType = NSAttributedString.DocumentType.html
            let characterEncoding = String.Encoding.utf8
            let attributedText = try NSAttributedString(data: data,
                                                        options: [
                                                            .documentType: documentType,
                                                            .characterEncoding: characterEncoding.rawValue
                                                        ],
                                                        documentAttributes: nil)
            self.attributedText = attributedText
        } catch {
            print("Couldn't set html text: \(error)")
        }
    }
    
    func setLineSpacing(_ lineHeightMultiple: CGFloat) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = lineHeightMultiple
        let attributedString: NSMutableAttributedString
        if let attributedText = self.attributedText {
            attributedString = NSMutableAttributedString(attributedString: attributedText)
        } else {
            attributedString = NSMutableAttributedString(string: self.text.orDefaultString())
        }
        attributedString.addAttribute(.paragraphStyle,
                                      value: paragraphStyle,
                                      range: NSMakeRange(.zero, attributedString.length))
        self.attributedText = attributedString
    }
    
    static func getHeightForLabel(text: String, font: UIFont, width: CGFloat, height: CGFloat) -> CGFloat {
        let label = UILabel(frame: CGRect(x: .zero, y: .zero, width: width, height: height))
        label.numberOfLines = .zero
        label.font = font
        label.text = text
        label.sizeToFit()
        return label.frame.height
    }
    
    var numberOfVisibleLines: Int {
        guard let attributedText = attributedText else { return .zero }
        let textStorage = NSTextStorage(attributedString: attributedText)
        let layoutManager = NSLayoutManager()
        textStorage.addLayoutManager(layoutManager)
        let textContainer = NSTextContainer(size: bounds.size)
        textContainer.lineFragmentPadding = .zero
        textContainer.lineBreakMode = lineBreakMode
        layoutManager.addTextContainer(textContainer)
        
        let numberOfGlyphs = layoutManager.numberOfGlyphs
        var numberOfLines = Int.zero
        var index = Int.zero
        var lineRange = NSMakeRange(.zero, .one)
        
        while index < numberOfGlyphs {
            layoutManager.lineFragmentRect(forGlyphAt: index, effectiveRange: &lineRange)
            index = NSMaxRange(lineRange)
            numberOfLines += .one
        }
        return numberOfLines
    }
}
