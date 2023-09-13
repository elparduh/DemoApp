import Foundation
import UIKit

class PaymentGatewayViewCell: UICollectionViewCell, ReusableView {
    
    private let shadowView = UIView()
    private let mainStackView = UIStackView()
    private let imageStackView = UIStackView()
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
    
    func bind(_ urls: [String], _ title: String) {
        titleLabel.text = title
        bindImages(urls)
    }
    
    private func bindImages(_ urls: [String]) {
        urls.forEach {
            imageStackView.addArrangedSubview(createImageView($0))
        }
    }
    
    private func setSelected(selected: Bool) {
        selectionIcon.showOrHide(selected)
    }
}

extension PaymentGatewayViewCell: CustomViewBuildable {
    
    func addSubviews() {
        addSubview(shadowView)
        addSubview(mainStackView)
        addSubview(selectionIcon)
        mainStackView.addArrangedSubviews([imageStackView,
                                           titleLabel])
    }
    
    func addConstraints() {
        configureContainerShadowView()
        configureMainStackView()
        configureImageStackView()
        configureTitleLabel()
        configureSelectedIcon()
    }
    
    private func configureContainerShadowView() {
        shadowView.pinToEdges(superView: self)
        shadowView.backgroundColor = .white85
        shadowView.layer.cornerRadius = .point8
    }
    
    private func configureMainStackView() {
        mainStackView.pinToEdges(superView: self)
        mainStackView.axis = .vertical
        mainStackView.spacing = .point8
        mainStackView.alignment = .center
        mainStackView.configureLayoutMargins(constant: .point16)
        mainStackView.backgroundColor = .white
        mainStackView.layer.cornerRadius = .point8
    }
    
    private func configureImageStackView() {
        imageStackView.spacing = .point20
        imageStackView.alignment = .center
    }
    
    private func configureTitleLabel() {
        titleLabel.disableAutoresizingMaskIntoConstraints()
        titleLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        titleLabel.textAlignment = .center
    }
    
    private func configureSelectedIcon() {
        selectionIcon.disableAutoresizingMaskIntoConstraints()
        selectionIcon.contentMode = .scaleAspectFit
        selectionIcon.bindImage(string: "selected")
        selectionIcon.hide()
        
        NSLayoutConstraint.activate([
            selectionIcon.heightAnchor.constraint(equalToConstant: .point15),
            selectionIcon.widthAnchor.constraint(equalToConstant: .point15),
            selectionIcon.centerYAnchor.constraint(equalTo: imageStackView.centerYAnchor),
            selectionIcon.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.point16)
        ])
    }
    
    private func configureShadowStyle() {
        let shadowOpacity: Float = Float(.point0_8)
        let shadowOffset = CGSize(width: .zero, height: .point6)
        let shadowPath = UIBezierPath(rect: bounds).cgPath
        shadowView.addShadow(shadowColor: .black,
                             shadowOpacity: shadowOpacity,
                             shadowOffset: shadowOffset,
                             shadowRadius: .point8,
                             shadowPath: shadowPath,
                             shouldRasterize: true)
    }
    
    private func createImageView(_ url: String) -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.load(with: url)
        imageView.widthAnchor.constraint(equalToConstant: .point34).activate()
        imageView.heightAnchor.constraint(equalToConstant: .point24).activate()
        return imageView
    }
}
