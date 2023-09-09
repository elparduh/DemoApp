import Foundation
import UIKit

extension UIButton {

    func roundedStyle(title: String = .empty,
                      backgroundColor: UIColor = .white,
                      cornerRadius: CGFloat = Constants.defaultButtonCornerRadius,
                      font: UIFont = UIFont.systemFont(ofSize: 17, weight: .semibold),
                      fontColor: UIColor = .black,
                      fontSpacing: CGFloat = Constants.buttonLetterSpacing,
                      borderWidth: CGFloat = .zero,
                      borderColor: UIColor = .white) {
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
        self.backgroundColor = backgroundColor
        self.setAttributedTitle(.attributed(string: title, with: font, color: fontColor, spacing: fontSpacing), for: .normal)
    }
    
    func defaultStyle(title: String, titleColor: UIColor = .black, font: UIFont = UIFont.bodySemibold(), fontSpacing: CGFloat = Constants.buttonLetterSpacing, backgroundColor: UIColor = .white) {
        self.backgroundColor = backgroundColor
        self.setAttributedTitle(String.localizeString(for: title)
            .asAttributedText(
                with: font,
                color: titleColor,
                spacing: fontSpacing), for: .normal)
    }
    
    func setNavigationButtonStyle(image: String, target: Any, action: Selector) {
        self.frame = CGRect(x: Constants.defaultValue, y: Constants.defaultValue, width: Constants.badgeButtonWidth, height: Constants.badgeButtonHeight)
        self.setBackgroundImage(UIImage(named: image), for: .normal)
        self.addTarget(target, action: action, for: .touchUpInside)
    }
    
    func withBadgeStyle(asset: String, badgeValue: Int) {
        frame = CGRect(x: .zero,
                       y: .zero,
                       width: Constants.badgeButtonWidth,
                       height: Constants.badgeButtonHeight)
        setBackgroundImage(UIImage(named: asset), for: .normal)
        
        if badgeValue != .zero {
            let badgeValueLabel = UILabel()
            badgeValueLabel.setBadgeStyle(with: badgeValue)
            addSubview(badgeValueLabel)
        }
    }
    
    func enabled(backgroundColor: UIColor = .yellowCream, textColor: UIColor? = nil) {
        isEnabled = true
        setStatusColor(backgroundColor, isEnabled, textColor: textColor)
    }
    
    func disabled(backgroundColor: UIColor = .lightGray) {
        isEnabled = false
        setStatusColor(backgroundColor, isEnabled)
    }
    
    func enableOrDisable(_ isEnabled: Bool) {
        isEnabled ? enabled() : disabled()
    }
    
    func isEnabled(enabled: Bool,
                   _ backgroundColor: UIColor = .yellowCream,
                   _ font: UIFont = UIFont.systemFont(ofSize: 17, weight: .semibold)) {
        isEnabled = enabled
        setStatusColor(backgroundColor, isEnabled, font)
    }
    
    func defaultAlertStyle(title: String? = nil,
                           enabled: Bool,
                           backgroundColor: UIColor = .clear,
                           font: UIFont = .bodyRegular(with: .font16)) {
        isEnabled = enabled
        setTitle(title ?? titleLabel?.text, for: .normal)
        setStatusColor(backgroundColor, enabled, font)
    }
    
    private func setStatusColor(_ newBackgroundColor: UIColor,
                                _ isEnabled: Bool = false,
                                _ font: UIFont = UIFont.systemFont(ofSize: 17, weight: .semibold),
                                textColor: UIColor? = nil) {
        if let text = titleLabel?.text {
            backgroundColor = newBackgroundColor
            let defaultTextColor: UIColor = isEnabled ? .black : .tinyGray
            let textColor: UIColor = textColor ?? defaultTextColor
            setAttributedTitle(.attributed(string: text,
                                           with: font,
                                           color: textColor), for: .normal)
        } else {
            self.backgroundColor = backgroundColor
            setTitleColor(.black, for: .normal)
        }
    }
        
    func setAttributtedTitle(title: String, font: UIFont = UIFont.systemFont(ofSize: 17, weight: .semibold),
                             fontColor: UIColor = .black,
                             fontSpacing: CGFloat = Constants.buttonLetterSpacing) {
        self.setAttributedTitle(String.localizeString(for: title).asAttributedText(with: font, color: fontColor, spacing: fontSpacing), for: .normal)
    }
    
    func setTitleWithAttributedRange(title: String,
                                     titleFont: UIFont = UIFont.systemFont(ofSize: 17, weight: .semibold),
                                     color: UIColor = .black,
                                     range: String,
                                     rangeFont: UIFont = .bodyBold()) {
        let attributedTitle: NSAttributedString = .attributed(string: title, with: titleFont, color: color)
        let mutableAttributedTitle = NSMutableAttributedString(attributedString: attributedTitle)
        let attributedRange = (mutableAttributedTitle.string as NSString).range(of: range)
        mutableAttributedTitle.setAttributes([NSAttributedString.Key.foregroundColor: color,
                                              NSAttributedString.Key.font: rangeFont], range: attributedRange)
        self.setAttributedTitle(mutableAttributedTitle, for: .normal)
    }
    
    func autoshrinkFontSize() {
        self.titleLabel?.numberOfLines = .one
        self.titleLabel?.adjustsFontSizeToFitWidth = true
        self.titleLabel?.lineBreakMode = .byClipping
    }
    
    func setImageWithColor(_ named: String, color: UIColor? = .black, state: UIControl.State = .normal) {
        let asset = UIImage(named: named)
        if let image = asset?.withRenderingMode(.alwaysTemplate) {
            setImage(image, for: state)
            self.tintColor = color
        } else {
            setImage(asset, for: state)
        }
    }
    
    func setImageForState(assetName: String, for state: UIControl.State = .normal ) {
        let image = UIImage(named: assetName)
        setImage(image, for: state)
    }
    
    func setImageWithColor(systemName: String, color: UIColor = .black, state: UIControl.State = .normal) {
        let symbolConfiguration = UIImage.SymbolConfiguration(font: titleLabel?.font ?? .bodyRegular())
        let systemImage = UIImage(systemName: systemName, withConfiguration: symbolConfiguration)
        let systemImageWithColor = systemImage?.withTintColor(color, renderingMode: .alwaysOriginal)
        setImage(systemImageWithColor, for: state)
    }
}
