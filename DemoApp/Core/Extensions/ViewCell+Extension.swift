import Foundation
import UIKit

protocol ReusableView: AnyObject {
    static var reuseIdentifier: String { get }
    static var nib: UINib { get }
}

extension ReusableView where Self: UIView {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    static var nibName: String {
        return String(describing: self)
    }
    
    static var nib: UINib {
        let bundle = Bundle(for: self)
        return UINib(nibName: nibName, bundle: bundle)
    }
}
