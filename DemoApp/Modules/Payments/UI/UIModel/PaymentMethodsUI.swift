import Foundation

struct PaymentMethodsUi {
    let title: String
    let type: PaymentMethodTypeUi
    let paymentMethods: [PaymentMethodUi]
    
    init(title: String = .empty,
         type: PaymentMethodTypeUi = .defaultValue,
         paymentMethods: [PaymentMethodUi] = []) {
        self.title = title
        self.type = type
        self.paymentMethods = paymentMethods
    }
}

enum PaymentMethodTypeUi {
    static let defaultValue: PaymentMethodTypeUi = .unknown
    case saved, gateway, unknown
}

struct PaymentMethodUi {
    let savedPaymentMethod: SavedPaymentMethodUi
    let gatewayPaymentMethod: GatewayPaymentMethodUi
    let selected: Bool
    
    init(savedPaymentMethod: SavedPaymentMethodUi = SavedPaymentMethodUi(),
         gatewayPaymentMethod: GatewayPaymentMethodUi = GatewayPaymentMethodUi(),
         selected: Bool = false) {
        self.savedPaymentMethod = savedPaymentMethod
        self.gatewayPaymentMethod = gatewayPaymentMethod
        self.selected = selected
    }
}

struct SavedPaymentMethodUi {
    let title: String
    let image: String
    let isDefault: Bool
    
    init(title: String = .empty,
         image: String = .empty,
         isDefault: Bool = false) {
        self.title = title
        self.image = image
        self.isDefault = isDefault
    }
}

enum GatewayTypeUi: String {
    static let defaultValue: GatewayTypeUi = .unknown
    case adyen = "ADYEN"
    case vouchers = "VOUCHERS"
    case paypal = "PAYPAL"
    case mercadoPago = "MERCADO_PAGO"
    case applePay = "APPLE_PAY"
    case manual = "MANUAL"
    case addCard = "ADD_CARD"
    case addVoucher = "ADD_VOUCHER"
    case unknown
}

struct GatewayPaymentMethodUi {
    let title: String
    let images: [String]
    let fullWidth: Bool
    let gatewayTypeUi: GatewayTypeUi
    
    init(title: String = .empty,
         images: [String] = [],
         fullWidth: Bool = false,
         gatewayTypeUi: GatewayTypeUi = .defaultValue) {
        self.title = title
        self.images = images
        self.fullWidth = fullWidth
        self.gatewayTypeUi = gatewayTypeUi
    }
}
