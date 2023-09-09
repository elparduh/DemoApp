import UIKit

class HeaderCollectionReusableView: UICollectionReusableView, ReusableView {
            
    private let titleLabel = UILabel()
    private var titleLabelLeadingConstraint = NSLayoutConstraint()
    private var titleLabelTrailingConstraint = NSLayoutConstraint()
    private var titleLabelTopConstraint = NSLayoutConstraint()
    private var titleLabelBottomConstraint = NSLayoutConstraint()
    var insets: UIEdgeInsets {
        get { self.insets }
        set {
            updateTitleLabelInsets(insets: newValue)
        }
    }
                
    override init(frame: CGRect) {
        super.init(frame: .zero)
        addSubviews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addSubviews()
        addConstraints()
    }
    
    func bind(_ title: String?) {
        titleLabel.text = title
    }
    
    private func updateTitleLabelInsets(insets: UIEdgeInsets) {
        titleLabelTopConstraint.constant = insets.top
        titleLabelLeadingConstraint.constant = insets.left
        titleLabelBottomConstraint.constant = insets.bottom
        titleLabelTrailingConstraint.constant = insets.right
    }
}

extension HeaderCollectionReusableView: CustomViewBuildable {
    
    func addSubviews() {
        addSubview(titleLabel)
    }
    
    func addConstraints() {
        configureTitleLabel()
    }
    
    private func configureTitleLabel() {
        titleLabel.disableAutoresizingMaskIntoConstraints()
        titleLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        titleLabelTopConstraint = titleLabel.topAnchor.constraint(equalTo: topAnchor)
        titleLabelLeadingConstraint = titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .point20)
        titleLabelBottomConstraint = titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        titleLabelTrailingConstraint = titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -.point20)
        
        NSLayoutConstraint.activate([
            titleLabelTopConstraint,
            titleLabelLeadingConstraint,
            titleLabelBottomConstraint,
            titleLabelTrailingConstraint
        ])
    }
}

