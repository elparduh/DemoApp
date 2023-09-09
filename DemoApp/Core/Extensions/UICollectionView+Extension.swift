import Foundation
import UIKit

extension UICollectionView {
    
    var layout: UICollectionViewFlowLayout? {
        return collectionViewLayout as? UICollectionViewFlowLayout
    }
    
    var width: Double {
        frame.size.width
    }
    
    func register<T: UICollectionViewCell>(_: T.Type) where T: ReusableView {
        register(T.self, forCellWithReuseIdentifier: T.reuseIdentifier)
    }
    
    func registerNib<T: UICollectionViewCell>(_: T.Type) where T: ReusableView {
        register(T.nib, forCellWithReuseIdentifier: T.reuseIdentifier)
    }
    
    func registerSupplementary<T: UICollectionReusableView>(_: T.Type, elementKind: String = UICollectionView.elementKindSectionHeader) where T: ReusableView {
        register(T.self, forSupplementaryViewOfKind: elementKind, withReuseIdentifier: T.reuseIdentifier)
    }
    
    func registerNibSupplementary<T: UICollectionReusableView>(_: T.Type, elementKind: String = UICollectionView.elementKindSectionHeader) where T: ReusableView {
        register(T.nib, forSupplementaryViewOfKind: elementKind, withReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeueReusableSuplementary<T: UICollectionReusableView>(elementKind: String = UICollectionView.elementKindSectionHeader, for indexPath: IndexPath) -> T where T: ReusableView {
        guard let cell = dequeueReusableSupplementaryView(ofKind: elementKind, withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue suplementary view with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T where T: ReusableView {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }
    
    func setRefreshControl(action: Selector, target: Any) {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(target, action: action, for: .valueChanged)
        self.refreshControl = refreshControl
    }
    
    func reloadDataAndScrollToTop() {
        reloadData()
        setContentOffset(CGPoint.zero, animated: false)
    }

    class Constants {
        static let firstPosition: Int = 1
    }
    
    func insertRows(at indexPaths: [IndexPath], completion: ((Bool) -> Void)? = nil) {
        performBatchUpdates({
            insertItems(at: indexPaths)
        }, completion: completion)
    }
    
    func reloadSection(section: IndexSet, completion: ((Bool) -> Void)? = nil) {
        performBatchUpdates({
            reloadSections(section)
        }, completion: completion)
    }
    
    func selectItem(on indexPath: IndexPath?, animated: Bool = false, scrollPosition: ScrollPosition = []) {
        selectItem(at: indexPath, animated: animated, scrollPosition: scrollPosition)
    }
    
    func selectItem(at index: Int = .zero, animated: Bool = false, scrollPosition: ScrollPosition = []) {
        selectItem(on: IndexPath(row: index, section: .zero), animated: animated, scrollPosition: scrollPosition)
    }
    
    func selectFirstItem() {
        selectItem(on: IndexPath(item: .zero, section: .zero))
    }
    
    func deselectAllItems() {
        indexPathsForSelectedItems?.forEach { indexPathForSelectedItem in
            if let cell = cellForItem(at: indexPathForSelectedItem) {
                cell.isSelected = false
            }
            deselectItem(at: indexPathForSelectedItem, animated: false)
        }
    }
    
    func reloadSectionAndSelectItem(section: IndexSet, selectedItems: [IndexPath]? ) {
        UIView.performWithoutAnimation {
            reloadSection(section: section, completion: { [weak self] _ in
                selectedItems?.forEach { indexPath in self?.selectItem(on: indexPath) }
            })
        }
    }
    
    func reloadFirstSection() {
        reloadSections(IndexSet(integer: .zero))
    }
    
    func getCell<T: UICollectionViewCell>(_: T.Type, _ indexPath: IndexPath) -> T where T: ReusableView {
        guard let cell =  cellForItem(at: indexPath) as? T else {
            fatalError("Could not cellForItem view with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }
    
    func scrollToTop() {
        guard numberOfItems(inSection: .zero) != .zero else { return }
        let indexPath = IndexPath(item: .zero, section: .zero)
        scrollToItem(at: indexPath, at: .top, animated: false)
    }
    
    func appendItems(_ oldCount: Int, _ newCount: Int) {
        var indexPaths: [IndexPath] = []
        for index in oldCount ..< newCount {
            indexPaths.append(IndexPath(item: index, section: .zero))
        }
        insertRows(at: indexPaths)
    }
    
    func shouldEndRefreshing() {
        guard let refreshControl = refreshControl, refreshControl.isRefreshing else { return }
        refreshControl.endRefreshing()
    }
    
    func withVerticalScroll() {
        layout?.scrollDirection = .vertical
    }
    
    func configureLayoutMargins(top: CGFloat = .point0,
                                left: CGFloat = .point0,
                                bottom: CGFloat = .point0,
                                right: CGFloat = .point0) {
        layout?.sectionInset = UIEdgeInsets(top: top,
                                            left: left,
                                            bottom: bottom,
                                            right: right)
    }
}

