import UIKit

class CheckoutPaymentViewController: UIViewController {
    
    let scrollView = UIScrollView()
    let mainStackView = UIStackView()
    let savedCollectionView = UICollectionViewWithDynamicHeight(frame: .zero,
                                                                collectionViewLayout: UICollectionViewFlowLayout())
    let onlineCollectionView = UICollectionViewWithDynamicHeight(frame: .zero,
                                                                 collectionViewLayout: UICollectionViewFlowLayout())
    let manualCollectionView = UICollectionViewWithDynamicHeight(frame: .zero,
                                                                 collectionViewLayout: UICollectionViewFlowLayout())
    let buttonContainerView = UIView()
    let nextButton = UIButton()
    
    lazy var presenter: CheckoutPaymentPresenter = CheckoutPaymentPresenter(ui: self)
    
    override func loadView() {
        view = UIView()
        addSubviews(toMainView: view)
        addConstraints(toMainView: view)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension CheckoutPaymentViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == savedCollectionView {
            return .three
        } else if collectionView == onlineCollectionView {
            return .four
        } else {
            return .one
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        let headerCell: HeaderCollectionReusableView = collectionView.dequeueReusableSuplementary(elementKind: kind,
                                                                                                  for: indexPath)
        headerCell.insets = UIEdgeInsets(top: .zero, left: .point16, bottom:.zero, right: .point16)
        
        if collectionView == savedCollectionView {
            headerCell.bind(.localizedString(key: "My cards"))
        } else if collectionView == onlineCollectionView {
            headerCell.bind(.localizedString(key: "Pay online"))
        } else {
            headerCell.bind(.localizedString(key: "Pay on delivery"))
        }
        return headerCell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == savedCollectionView {
            return configureSavedViewCell(collectionView, indexPath)
        } else if collectionView == onlineCollectionView {
            return configureOnlineViewCell(collectionView, indexPath)
        } else {
            return configureManualViewCell(collectionView, indexPath)
        }
    }
    
    // TODO: Add data from the new query https://justo.atlassian.net/browse/TU-931
    private func configureSavedViewCell(_ collectionView: UICollectionView, _ indexPath: IndexPath) -> UICollectionViewCell {
        let paymentViewCell: PaymentViewCell = collectionView.dequeueReusableCell(for: indexPath)
        paymentViewCell.bind("adyen", "0000 - VISA")
        return paymentViewCell
    }
    
    private func configureOnlineViewCell(_ collectionView: UICollectionView, _ indexPath: IndexPath) -> UICollectionViewCell {
        let paymentGatewayViewCell: PaymentGatewayViewCell = collectionView.dequeueReusableCell(for: indexPath)
        var imageUrls: [String] = []
        var title : String = .empty
        if  indexPath.row == 0 || indexPath.row == 1 {
            imageUrls = ["applePay","adyen","mercadopago","pix"]
            title = "Tarjeta de crédito o débito"
        } else {
            imageUrls = ["paypalBlue"]
            title = "Paypal"
        }
        paymentGatewayViewCell.bind(imageUrls, title)
        return paymentGatewayViewCell
    }
    
    private func configureManualViewCell(_ collectionView: UICollectionView, _ indexPath: IndexPath) -> UICollectionViewCell {
        let paymentViewCell: PaymentViewCell = collectionView.dequeueReusableCell(for: indexPath)
        paymentViewCell.bind("cash", "Tarjeta de crédito, débito, vales de despensa y efectivo.")
        return paymentViewCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.paymentMethodSelected()
        if collectionView == savedCollectionView {
            onlineCollectionView.deselectAllItems()
            manualCollectionView.deselectAllItems()
        } else if collectionView == onlineCollectionView {
            savedCollectionView.deselectAllItems()
            manualCollectionView.deselectAllItems()
        } else {
            savedCollectionView.deselectAllItems()
            onlineCollectionView.deselectAllItems()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(width: collectionView.frame.width, height: .point20)
    }
}

extension CheckoutPaymentViewController: CheckoutPaymentUI {
    
    func enableNextButton() {
        nextButton.enabled()
    }
    
    func disableNextButton() {
        nextButton.disabled()
    }
}

