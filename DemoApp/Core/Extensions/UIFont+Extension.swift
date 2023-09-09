import Foundation
import UIKit

extension UIFont {

    static func titleLight(with size: FontSize) -> UIFont {
        return self.init(name: "AvenirNext-Light", size: size.rawValue)!
    }

    static func titleRegular(with size: FontSize) -> UIFont {
        return self.init(name: "AvenirNext-Regular", size: size.rawValue)!
    }

    static func titleMedium(with size: FontSize = .font17) -> UIFont {
        return self.init(name: "AvenirNext-Medium", size: size.rawValue)!
    }

    static func titleBold(with size: FontSize) -> UIFont {
        return self.init(name: "AvenirNext-Bold", size: size.rawValue)!
    }

    static func bodyLight(with size: FontSize = FontSize.font17) -> UIFont {
        return self.init(name: "SFProText-Light", size: size.rawValue)!
    }

    static func bodyRegular(with size: FontSize = FontSize.font17) -> UIFont {
        return self.init(name: "SFProText-Regular", size: size.rawValue)!
    }

    static func bodyMedium(with size: FontSize = FontSize.font17) -> UIFont {
        return self.init(name: "SFProText-Medium", size: size.rawValue)!
    }

    static func bodySemibold(with size: FontSize = FontSize.font17) -> UIFont {
        return self.init(name: "SFProText-Semibold", size: size.rawValue)!
    }

    static func bodyBold(with size: FontSize = FontSize.font17) -> UIFont {
        return self.init(name: "SFProText-Bold", size: size.rawValue)!
    }
    
    static func sohneBreitRegular(with size: FontSize = FontSize.font17) -> UIFont {
        .init(name: "SohneBreit-Fett", size: size.rawValue)!
    }
    
    static func sohneSchmalRegular(with size: FontSize = FontSize.font17) -> UIFont {
        .init(name: "SohneSchmal-Fett", size: size.rawValue)!
    }
}

