import Foundation
import UIKit

extension CheckoutPaymentViewController: ViewBuildable {
    
    func addSubviews(toMainView view: UIView) {
        view.addSubview(scrollView)
        view.addSubview(buttonContainerView)
        buttonContainerView.addSubview(nextButton)
        scrollView.addSubview(mainStackView)
        mainStackView.addArrangedSubviews([savedCollectionView,
                                           onlineCollectionView,
                                           manualCollectionView])
    }
    
    func addConstraints(toMainView view: UIView) {
        let layoutGuide = view.safeAreaLayoutGuide
        configureMainView()
        configureScrollView(layoutGuide)
        configureMainStackView()
        configureSavedCollectionView()
        configureOnlineCollectionView()
        configureManualCollectionView()
        configureButtonContainerView(layoutGuide)
        configureContinueButton()
    }
    
    private func configureMainView() {
        view.backgroundColor = .white
    }
    
    private func configureScrollView(_ layoutGuide: UILayoutGuide) {
        scrollView.pinToEdges(layoutGuide: layoutGuide, bottom: .point76)
        scrollView.showsVerticalScrollIndicator = false
    }
    
    private func configureMainStackView() {
        mainStackView.pinToEdges(superView: scrollView)
        mainStackView.axis = .vertical
        mainStackView.spacing = .point16
        
        mainStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).activate()
    }
    
    private func configureSavedCollectionView() {
        savedCollectionView.showsVerticalScrollIndicator = false
        savedCollectionView.isScrollEnabled = false
        savedCollectionView.delegate = self
        savedCollectionView.dataSource = self
        savedCollectionView.configureLayoutMargins(top: .point8, left: .point16, bottom: .point16, right: .point16)
        savedCollectionView.layout?.minimumLineSpacing = .point16
        savedCollectionView.registerSupplementary(HeaderCollectionReusableView.self)
        savedCollectionView.register(PaymentViewCell.self)
    }
    
    private func configureOnlineCollectionView() {
        onlineCollectionView.showsVerticalScrollIndicator = false
        onlineCollectionView.isScrollEnabled = false
        onlineCollectionView.delegate = self
        onlineCollectionView.dataSource = self
        onlineCollectionView.configureLayoutMargins(top: .point8, left: .point16, bottom: .point16, right: .point16)
        onlineCollectionView.layout?.minimumLineSpacing = .point16
        onlineCollectionView.registerSupplementary(HeaderCollectionReusableView.self)
        onlineCollectionView.register(PaymentGatewayViewCell.self)
    }
    
    private func configureManualCollectionView() {
        manualCollectionView.showsVerticalScrollIndicator = false
        manualCollectionView.isScrollEnabled = false
        manualCollectionView.delegate = self
        manualCollectionView.dataSource = self
        manualCollectionView.configureLayoutMargins(top: .point8, left: .point16, bottom: .point16, right: .point16)
        manualCollectionView.layout?.minimumLineSpacing = .point16
        manualCollectionView.registerSupplementary(HeaderCollectionReusableView.self)
        manualCollectionView.register(PaymentViewCell.self)
    }
    
    private func configureButtonContainerView(_ layoutGuide: UILayoutGuide) {
        buttonContainerView.disableAutoresizingMaskIntoConstraints()
        buttonContainerView.backgroundColor = .white90
        
        NSLayoutConstraint.activate([
            buttonContainerView.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor),
            buttonContainerView.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor),
            buttonContainerView.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor),
            buttonContainerView.heightAnchor.constraint(equalToConstant: .point76)
        ])
    }
    
    func configureContinueButton() {
        nextButton.pinToEdges(superView: buttonContainerView, constant: .point16)
        nextButton.roundedStyle(title: "Next Button", backgroundColor: .supernova)
        nextButton.disabled()
    }
}

extension CheckoutPaymentViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == savedCollectionView {
            return CGSize(width: savedCollectionView.frame.size.width - .point32, height: .point56)
        } else if collectionView == onlineCollectionView {
            return calculatePayOnlineCellSize(indexPath)
        } else {
            return CGSize(width: manualCollectionView.frame.size.width - .point32, height: .point56)
        }
    }
    
    private func calculatePayOnlineCellSize(_ indexPath: IndexPath) -> CGSize {
        if indexPath.row == 0 || indexPath.row == 1{
            return CGSize(width: onlineCollectionView.frame.size.width - .point32, height: 84)
        } else {
            let collectionViewWidth = onlineCollectionView.frame.size.width - (.point16 * .point2 + .point10)
            return CGSize(width: collectionViewWidth / 2, height: 84)
        }
    }
}
