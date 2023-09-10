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
        let _ : PaymentMethodsUi = fakeDataResponse.data?.userPaymentMethods?.edges?.asSavedPaymentMethodsUi() ?? PaymentMethodsUi()
        let _ : [ActiveGateways]? = fakeDataResponse.data?.userPaymentMethods?.activeGateways
    }
}

protocol CheckoutPaymentUI: UI {
    func enableNextButton()
    func disableNextButton()
}
