import Foundation
import UIKit

extension UIView {
    var isVisible: Bool {
        get { return alpha != .zero }
        set { alpha = newValue ? .one : .zero }
    }
    
    func visible() {
        isVisible = true
    }
    
    func invisible() {
        isVisible = false
    }

    func show() {
        self.isHidden = false
    }

    func hide() {
        self.isHidden = true
    }
    
    func showOrHide(_ visible: Bool) {
        self.isHidden = visible ? false : true
    }
        
    func roundedStyle(cornerRadius: CGFloat = Constants.defaultCornerRadius,
                      borderWidth: CGFloat = Constants.defaultValue,
                      borderColor: UIColor = .white,
                      backgroundColor: UIColor = .white) {
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
        self.layer.backgroundColor = backgroundColor.cgColor
    }

    func pinToEdges(superView: UIView) {
        self.disableAutoresizingMaskIntoConstraints()
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superView.topAnchor),
            leadingAnchor.constraint(equalTo: superView.leadingAnchor),
            trailingAnchor.constraint(equalTo: superView.trailingAnchor),
            bottomAnchor.constraint(equalTo: superView.bottomAnchor)
        ])
    }
    
    func pinToEdges(layoutGuide: UILayoutGuide,
                    top: CGFloat = .point0,
                    bottom: CGFloat = .point0,
                    leading: CGFloat = .point0,
                    trailing: CGFloat = .point0) {
        disableAutoresizingMaskIntoConstraints()
        
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: layoutGuide.topAnchor, constant: top),
            leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor, constant: leading),
            trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor, constant: -trailing),
            bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor, constant: -bottom)
        ])
    }
    
    func pinToEdges(superView: UIView,
                    topConstant: CGFloat = .point0,
                    leadingConstant: CGFloat = .point0,
                    trailingConstant: CGFloat = .point0,
                    bottomConstant: CGFloat = .point0) {
        disableAutoresizingMaskIntoConstraints()
        
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superView.topAnchor, constant: topConstant),
            leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: leadingConstant),
            trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: -trailingConstant),
            bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: -bottomConstant)
        ])
    }
    
    func pinToEdges(superView: UIView, constant: CGFloat) {
        pinToEdges(superView: superView,
                   topConstant: constant,
                   leadingConstant: constant,
                   trailingConstant: constant,
                   bottomConstant: constant)
    }
    
    func disableAutoresizingMaskIntoConstraints() { translatesAutoresizingMaskIntoConstraints = false
    }
    
    func addShadow(shadowColor: UIColor = .clear,
                   shadowOpacity: Float = .zero,
                   shadowOffset: CGSize = .zero,
                   shadowRadius: CGFloat = .zero,
                   shadowPath: CGPath? = nil,
                   shouldRasterize: Bool = false) {
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOpacity = shadowOpacity
        layer.shadowOffset = shadowOffset
        layer.shadowRadius = shadowRadius
        layer.shadowPath = shadowPath
        layer.shouldRasterize = shouldRasterize
    }
    
    func defaultShadowStyle(color: UIColor = .white,
                            opacity: CGFloat = .point1,
                            offset: CGSize = CGSize(width: .zero, height: -.point6),
                            radius: CGFloat = .point16) {
        layer.masksToBounds = false
        addShadow(shadowColor: color,
                  shadowOpacity: Float(opacity),
                  shadowOffset: offset,
                  shadowRadius: radius)
    }
    
    func addSwipeGesture(_ target: Any?,
                         action: Selector,
                         direction: UISwipeGestureRecognizer.Direction) {
        let swipeGesture = UISwipeGestureRecognizer(target: target,
                                                    action: action)
        swipeGesture.direction = direction
        addGestureRecognizer(swipeGesture)
    }
        
    func findParentController() -> UIViewController? {
        if let nextResponder = next as? UIViewController {
            return nextResponder
        } else if let nextResponder = next as? UIView {
            return nextResponder.findParentController()
        } else {
            return nil
        }
    }
    
    func rotate(degrees: CGFloat = .pi) {
        transform = transform.rotated(by: degrees)
    }
    
    func enableUserInteraction() {
        isUserInteractionEnabled = true
    }
    
    func addTapGestureAndEnableUserInteraction(_ tapGestureRecognizer: UITapGestureRecognizer) {
        enableUserInteraction()
        addGestureRecognizer(tapGestureRecognizer)
    }
}

