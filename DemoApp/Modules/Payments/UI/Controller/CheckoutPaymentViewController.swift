import UIKit

class CheckoutPaymentViewController: UIViewController {
    
    let scrollView = UIScrollView()
    let mainStackView = UIStackView()
    /*let savedCollectionView = UICollectionViewWithDynamicHeight(frame: .zero,
                                                                collectionViewLayout: UICollectionViewFlowLayout())
    let onlineCollectionView = UICollectionViewWithDynamicHeight(frame: .zero,
                                                                 collectionViewLayout: UICollectionViewFlowLayout())*/
    let paymentMethodsCollectionView = UICollectionViewWithDynamicHeight(frame: .zero,
                                                                 collectionViewLayout: UICollectionViewFlowLayout())
    let buttonContainerView = UIView()
    let nextButton = UIButton()
    var paymentMethodsUi: [PaymentMethodsUi] = []
    
    lazy var presenter: CheckoutPaymentPresenter = CheckoutPaymentPresenter(ui: self)
    
    override func loadView() {
        view = UIView()
        addSubviews(toMainView: view)
        addConstraints(toMainView: view)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.getUserPaymentMethods()
    }
}

extension CheckoutPaymentViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        paymentMethodsUi.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        let headerCell: HeaderCollectionReusableView = collectionView.dequeueReusableSuplementary(elementKind: kind,
                                                                                                  for: indexPath)
        headerCell.insets = UIEdgeInsets(top: .zero, left: .point16, bottom:.zero, right: .point16)
        headerCell.bind(paymentMethodsUi.getTitlePaymentMethodUi(indexPath.section))
        return headerCell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        paymentMethodsUi.sectionCount(section)
    }
    

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let paymentMethodUi = paymentMethodsUi.getPaymentMethodUi(indexPath.section, row: indexPath.row)
      
        if paymentMethodsUi.isSavedPaymentMethods(indexPath.section) {
            return configureSavedViewCell(collectionView, indexPath, paymentMethodUi.savedPaymentMethod)
        } else if !paymentMethodUi.isManualPaymentMethod() {
            return configureOnlineViewCell(collectionView, indexPath, paymentMethodUi.gatewayPaymentMethod)
        } else {
            return configureManualViewCell(collectionView, indexPath, paymentMethodUi)
        }
    }
    
    // TODO: Add data from the new query https://justo.atlassian.net/browse/TU-931
    private func configureSavedViewCell(_ collectionView: UICollectionView,
                                        _ indexPath: IndexPath,
                                        _ savedPaymentMethod: SavedPaymentMethodUi) -> UICollectionViewCell {
        let paymentViewCell: PaymentViewCell = collectionView.dequeueReusableCell(for: indexPath)
        paymentViewCell.bind(savedPaymentMethod.image, savedPaymentMethod.title)
        return paymentViewCell
    }
    
    private func configureOnlineViewCell(_ collectionView: UICollectionView,
                                         _ indexPath: IndexPath,
                                         _ gatewayPaymentMethod: GatewayPaymentMethodUi) -> UICollectionViewCell {
        let paymentGatewayViewCell: PaymentGatewayViewCell = collectionView.dequeueReusableCell(for: indexPath)
        paymentGatewayViewCell.bind(gatewayPaymentMethod.images, gatewayPaymentMethod.title)
        return paymentGatewayViewCell
    }
    
    private func configureManualViewCell(_ collectionView: UICollectionView,
                                         _ indexPath: IndexPath,
                                         _ paymentMethod: PaymentMethodUi) -> UICollectionViewCell {
        let paymentViewCell: PaymentViewCell = collectionView.dequeueReusableCell(for: indexPath)
        if paymentMethod.isManualPaymentMethod() {
            paymentViewCell.bind(paymentMethod.gatewayPaymentMethod.images.first ?? .empty, paymentMethod.gatewayPaymentMethod.title)
        }
        return paymentViewCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.paymentMethodSelected()
    }
}

extension CheckoutPaymentViewController: CheckoutPaymentUI {
    
    func displaypaymentMethods(_ paymentMethodsUi: [PaymentMethodsUi]) {
        self.paymentMethodsUi = paymentMethodsUi
        paymentMethodsCollectionView.reloadData()
    }
    
    func enableNextButton() {
        nextButton.enabled()
    }
    
    func disableNextButton() {
        nextButton.disabled()
    }
}

