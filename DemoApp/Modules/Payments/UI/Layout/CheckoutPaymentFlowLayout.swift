import UIKit

class CheckoutPaymentFlowLayout: UICollectionViewFlowLayout {
    
    var interitemSpacing = CGFloat.zero
    
    init(spacing: CGFloat) {
        super.init()
        interitemSpacing = spacing
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let cellAttributesList = super.layoutAttributesForElements(in: rect) else { return nil }
        
        var rows = [CheckoutPaymentCollectionViewRow]()
        var currentRowY: CGFloat = -.point1
        
        for cellAttribute in cellAttributesList {
            if currentRowY != cellAttribute.frame.origin.y {
                currentRowY = cellAttribute.frame.origin.y
                rows.append(CheckoutPaymentCollectionViewRow(interitemSpacing: interitemSpacing))
            }
            rows.last?.add(cellAttribute: cellAttribute)
        }
        
        rows.forEach {
            $0.centerLayout()
        }
        
        return rows.flatMap { $0.cellAttributesList }
    }
}

