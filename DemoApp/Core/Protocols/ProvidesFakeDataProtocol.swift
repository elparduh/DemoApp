import Foundation

protocol ProvidesFakeDataProtocol: AnyObject {
    func providesUserPaymentMethods() -> UserPaymentMethodsResponse
}
