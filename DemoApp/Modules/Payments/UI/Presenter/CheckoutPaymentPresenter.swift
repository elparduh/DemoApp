import Foundation

class CheckoutPaymentPresenter: Presenter {
    internal typealias UI = CheckoutPaymentUI
    weak var ui: UI?
    
    init(ui: CheckoutPaymentUI) {
        self.ui = ui
    }
    
    func paymentMethodSelected() {
        ui?.enableNextButton()
    }
}

protocol CheckoutPaymentUI: UI {
    func enableNextButton()
    func disableNextButton()
}
