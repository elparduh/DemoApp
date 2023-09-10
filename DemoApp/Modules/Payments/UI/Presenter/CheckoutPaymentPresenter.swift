import Foundation

class CheckoutPaymentPresenter: Presenter {
    internal typealias UI = CheckoutPaymentUI
    weak var ui: UI?
    let fakeDataResponse: UserPaymentMethodsResponse
    
    init(ui: CheckoutPaymentUI,
         fakeDataResponse: UserPaymentMethodsResponse) {
        self.ui = ui
        self.fakeDataResponse = fakeDataResponse
    }
    
    func paymentMethodSelected() {
        ui?.enableNextButton()
    }
}

protocol CheckoutPaymentUI: UI {
    func enableNextButton()
    func disableNextButton()
}
