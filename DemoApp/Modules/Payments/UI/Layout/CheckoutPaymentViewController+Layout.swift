import Foundation
import UIKit

extension CheckoutPaymentViewController: ViewBuildable {
    
    func addSubviews(toMainView view: UIView) {
        view.addSubview(scrollView)
        view.addSubview(buttonContainerView)
        buttonContainerView.addSubview(nextButton)
        scrollView.addSubview(mainStackView)
        mainStackView.addArrangedSubview(paymentMethodsCollectionView)
    }
    
    func addConstraints(toMainView view: UIView) {
        let layoutGuide = view.safeAreaLayoutGuide
        configureMainView()
        configureScrollView(layoutGuide)
        configureMainStackView()
        configurePaymentMethodsCollectionView()
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
        
        mainStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).activate()
    }
    
    private func configurePaymentMethodsCollectionView() {
        paymentMethodsCollectionView.collectionViewLayout = CheckoutPaymentFlowLayout(spacing: .point8)
        paymentMethodsCollectionView.showsVerticalScrollIndicator = false
        paymentMethodsCollectionView.isScrollEnabled = false
        paymentMethodsCollectionView.delegate = self
        paymentMethodsCollectionView.dataSource = self
        paymentMethodsCollectionView.registerSupplementary(HeaderCollectionReusableView.self)
        paymentMethodsCollectionView.register(PaymentViewCell.self)
        paymentMethodsCollectionView.register(PaymentGatewayViewCell.self)
        paymentMethodsCollectionView.contentInset = UIEdgeInsets(top: .zero,
                                                                 left: .zero,
                                                                 bottom: .point76,
                                                                 right: .zero)
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
        let paymentMethodUi = paymentMethodsUi.getPaymentMethodUi(indexPath.section, row: indexPath.row)
        
        if paymentMethodsUi.isSavedPaymentMethods(indexPath.section) {
            return CGSize(width: paymentMethodsCollectionView.frame.size.width - .point32, height: .point56)
        } else if !paymentMethodUi.isManualPaymentMethod() {
            return calculatePayOnlineCellSize(indexPath)
        } else {
            return CGSize(width: paymentMethodsCollectionView.frame.size.width - .point32, height: .point56)
        }
    }
    
    private func calculatePayOnlineCellSize(_ indexPath: IndexPath) -> CGSize {
        let paymentMethodUi = paymentMethodsUi.getPaymentMethodUi(indexPath.section, row: indexPath.row)
        
        if paymentMethodUi.isFullWidth() {
            return CGSize(width: paymentMethodsCollectionView.frame.size.width - .point32, height: 84)
        } else {
            let collectionViewWidth = paymentMethodsCollectionView.frame.size.width - (.point16 * .point2 + .point10)
            return CGSize(width: collectionViewWidth / 2, height: 84)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(width: collectionView.frame.width, height: .point20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: .point16, left: .point16, bottom: .point16, right: .point16)
    }
}
