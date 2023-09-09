import Foundation
import UIKit

protocol Presenter {
    associatedtype UI
    var ui: UI? { get set }
}

protocol UI: AnyObject {}

protocol LoadingUI: UI {
    
    func showLoader()
    func showLoader(withBackground: Bool)
    func hideLoader()
}

extension LoadingUI {
    
    func showLoader() {}
    func showLoader(withBackground: Bool) {}
}
