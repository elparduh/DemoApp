import Foundation

class UserPaymentMethodsProviderData: ProvidesFakeDataProtocol {
    private var fakeData: FakeDataProtocol = FakeData()
    
    func providesUserPaymentMethods() -> UserPaymentMethodsResponse {
        fakeData.loadJson(with: "UserPaymentMethods")
    }
}
