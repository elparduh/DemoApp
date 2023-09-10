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
    
    func getUserPaymentMethods() {
        let fakeDataProvider: ProvidesFakeDataProtocol = UserPaymentMethodsProviderData()
        let fakeDataResponse: UserPaymentMethodsResponse = fakeDataProvider.providesUserPaymentMethods()
    }
}

protocol CheckoutPaymentUI: UI {
    func enableNextButton()
    func disableNextButton()
}
