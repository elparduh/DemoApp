import Foundation

class CheckoutPaymentPresenter: Presenter {
    internal typealias UI = CheckoutPaymentUI
    weak var ui: UI?
    
    init(ui: CheckoutPaymentUI) {
        self.ui = ui
    }
    
    func getUserPaymentMethods() {
        let fakeDataProvider: ProvidesFakeDataProtocol = UserPaymentMethodsProviderData()
        let fakeDataResponse: UserPaymentMethodsResponse = fakeDataProvider.providesUserPaymentMethods()
        let paymentMethodsUi: [PaymentMethodsUi] = fakeDataResponse.data?.userPaymentMethods?.asPaymentMethodsUi() ?? []
        ui?.displaypaymentMethods(paymentMethodsUi)
    }
    
    func paymentMethodSelected() {
        ui?.enableNextButton()
    }
}

protocol CheckoutPaymentUI: UI {
    func enableNextButton()
    func disableNextButton()
    func displaypaymentMethods(_ paymentMethodsUi: [PaymentMethodsUi])
}
