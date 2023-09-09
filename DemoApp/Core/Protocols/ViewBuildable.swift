import Foundation
import UIKit

protocol ViewBuildable {
    func addSubviews(toMainView view: UIView)
    func addConstraints(toMainView view: UIView)
}

