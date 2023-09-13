import UIKit

class CheckoutPaymentCollectionViewRow {
    
    var cellAttributesList = [UICollectionViewLayoutAttributes]()
    var interitemSpacing = CGFloat.zero
    
    var rowWidth: CGFloat {
        cellAttributesList.reduce(.zero, { result, cellAttribute -> CGFloat in
            result + cellAttribute.frame.width
        }) + CGFloat(cellAttributesList.count - .one) * interitemSpacing
    }
    
    init(interitemSpacing: CGFloat) {
        self.interitemSpacing = interitemSpacing
    }
    
    func add(cellAttribute: UICollectionViewLayoutAttributes) {
        cellAttributesList.append(cellAttribute)
    }
    
    func centerLayout() {
        var offsetX: CGFloat = .point16
        for cellAttribute in cellAttributesList {
            cellAttribute.frame.origin.x = offsetX
            offsetX += cellAttribute.frame.width + interitemSpacing
        }
    }
}
