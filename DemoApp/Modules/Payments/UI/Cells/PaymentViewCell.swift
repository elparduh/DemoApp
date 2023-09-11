import Foundation
import UIKit

class PaymentViewCell: UICollectionViewCell, ReusableView  {
    
    private let shadowView = UIView()
    private let mainView = UIView()
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let selectionIcon = UIImageView()
    
    override var isSelected: Bool {
        willSet {
            setSelected(selected: newValue)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addSubviews()
        addConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureShadowStyle()
    }
    
    func bind(_ image: String, _ title: String) {
        imageView.load(with: image)
        titleLabel.text = title
    }
    
    private func setSelected(selected: Bool) {
        selectionIcon.showOrHide(selected)
    }
}

extension PaymentViewCell: CustomViewBuildable {
    
    func addSubviews() {
        addSubview(shadowView)
        addSubview(mainView)
        mainView.addSubview(imageView)
        mainView.addSubview(titleLabel)
        mainView.addSubview(selectionIcon)
    }
    
    func addConstraints() {
        configureShadowView()
        configureMainView()
        configureImageView()
        configureTitleLabel()
        configureSelectedIcon()
    }
    
    private func configureShadowView() {
        shadowView.pinToEdges(superView: self)
        shadowView.backgroundColor = .white85
        shadowView.layer.cornerRadius = .point8
    }
    
    private func configureMainView() {
        mainView.pinToEdges(superView: self)
        mainView.backgroundColor = .white
        mainView.layer.cornerRadius = .point8
    }
    
    private func configureImageView() {
        imageView.disableAutoresizingMaskIntoConstraints()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: .point16),
            imageView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: .point16),
            imageView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -.point16),
            imageView.heightAnchor.constraint(equalToConstant: .point24),
            imageView.widthAnchor.constraint(equalToConstant: .point34)
        ])
    }
    
    private func configureTitleLabel() {
        titleLabel.disableAutoresizingMaskIntoConstraints()
        titleLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        titleLabel.numberOfLines = .two
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: .point8),
            titleLabel.trailingAnchor.constraint(equalTo: selectionIcon.leadingAnchor, constant: -.point8),
            titleLabel.centerYAnchor.constraint(equalTo: imageView.centerYAnchor)
        ])
    }
    
    private func configureSelectedIcon() {
        selectionIcon.disableAutoresizingMaskIntoConstraints()
        selectionIcon.contentMode = .scaleAspectFit
        selectionIcon.bindImage(string: "selected")
        selectionIcon.hide()
        
        NSLayoutConstraint.activate([
            selectionIcon.heightAnchor.constraint(equalToConstant: .point15),
            selectionIcon.widthAnchor.constraint(equalToConstant: .point15),
            selectionIcon.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            selectionIcon.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -.point16)
        ])
    }
    
    private func configureShadowStyle() {
        let shadowOpacity: Float = Float(.point0_8)
        let shadowOffset = CGSize(width: .zero, height: .point6)
        let shadowPath = UIBezierPath(rect: self.bounds).cgPath
        shadowView.addShadow(shadowColor: .black,
                             shadowOpacity: shadowOpacity,
                             shadowOffset: shadowOffset,
                             shadowRadius: .point8,
                             shadowPath: shadowPath,
                             shouldRasterize: true)
    }
}


