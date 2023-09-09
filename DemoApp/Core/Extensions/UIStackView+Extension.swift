import Foundation
import UIKit

extension UIStackView {
    
    convenience init(arrangedSubviews views: [UIView],
                     spacing: CGFloat = .zero,
                     axis: NSLayoutConstraint.Axis = .horizontal,
                     alignment: UIStackView.Alignment = .fill,
                     margins: UIEdgeInsets = .zero) {
        self.init(arrangedSubviews: views)
        self.spacing = spacing
        self.axis = axis
        self.alignment = alignment
        isLayoutMarginsRelativeArrangement = (margins != .zero)
        layoutMargins = margins
    }
    
    func addArrangedSubviews(_ views: [UIView]) {
        views.forEach { addArrangedSubview($0) }
    }
    
    func insertSubview(_ view: UIView, above subview: UIView) {
        guard let index = arrangedSubviews.firstIndex(of: subview) else {
            fatalError("Subview: \(subview) not found in arranged subviews")
        }
        insertArrangedSubview(view, at: index)
    }
    
    func insertSubview(_ view: UIView, below subview: UIView) {
        guard let index = arrangedSubviews.firstIndex(of: subview) else {
            fatalError("Subview: \(subview) not found in arranged subviews")
        }
        insertArrangedSubview(view, at: index + 1)
    }
    
    func removeAllArrangedSubviews() {
        arrangedSubviews.forEach {
            $0.removeFromSuperview()
        }
    }
    
    func enableLayoutMarginsRelativeArrangement() {
        isLayoutMarginsRelativeArrangement = true
    }
    
    func configureLayoutMargins(top: CGFloat = .point0,
                                left: CGFloat = .point0,
                                bottom: CGFloat = .point0,
                                right: CGFloat = .point0) {
        enableLayoutMarginsRelativeArrangement()
        layoutMargins = UIEdgeInsets(top: top,
                                     left: left,
                                     bottom: bottom,
                                     right: right)
    }
    
    func configureLayoutMargins(constant: CGFloat = .point0) {
        configureLayoutMargins(top: constant,
                               left: constant,
                               bottom: constant,
                               right: constant)
    }
}


