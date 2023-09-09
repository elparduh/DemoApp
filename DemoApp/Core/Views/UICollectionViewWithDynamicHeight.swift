import Foundation
import UIKit

class UICollectionViewWithDynamicHeight: UICollectionView {
    
    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return contentSize
    }
    
    override var contentSize: CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
    
    override func reloadData() {
        super.reloadData()
        invalidateIntrinsicContentSize()
    }
}
