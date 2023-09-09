import UIKit
import SDWebImage

extension UIImageView {
    
    func bindImage(string: String) {
        image = UIImage(named: string)
    }
    
    func bindImage(uiImage: UIImage) {
        image = uiImage
    }
    
    func bindImageWithColor(uiImage: UIImage, color: UIColor = .black) {
        image = uiImage.withRenderingMode(.alwaysTemplate)
        tintColor = color
    }
    
    func bindImage(systemName: String, color: UIColor = .black,
                   font: UIFont = UIFont.systemFont(ofSize: 17, weight: .regular)) {
        let symbolConfiguration = UIImage.SymbolConfiguration(font: font)
        self.image = UIImage(systemName: systemName, withConfiguration: symbolConfiguration)
        self.tintColor = color
    }
    
    func load(with stringURL: String, placeholderImage: UIImage? = nil) {
        if !stringURL.isEmpty {
            sd_setImage(with: stringURL.toURL(), placeholderImage: placeholderImage)
        }
    }
    
    func bindImageWithColor(string: String, color: UIColor? = .black) {
        let asset = UIImage(named: string)
        if let image = asset?.withRenderingMode(.alwaysTemplate) {
            self.image = image
            self.tintColor = color
        } else {
            self.image = asset
        }
    }
    
    func loadWithAspectRatio(_ stringURL: String) {
        guard !stringURL.isEmpty else { return }
        sd_setImage(with: stringURL.toURL()) { [weak self] image, _, _, _ in
            guard let self = self, let size = image?.size else { return }
            let aspectRatio = size.width / size.height
            self.widthAnchor.constraint(equalTo: self.heightAnchor,
                                        multiplier: aspectRatio).activate()
        }
    }
}


