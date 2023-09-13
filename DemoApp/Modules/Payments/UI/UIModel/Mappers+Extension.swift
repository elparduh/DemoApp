import Foundation

extension UserPaymentMethods {
    
    func asPaymentMethodsUi() -> [PaymentMethodsUi] {
        var paymentMethodsUi: [PaymentMethodsUi] = []
        let savedPaymentMethodsUi: PaymentMethodsUi = edges?.asSavedPaymentMethodsUi() ?? PaymentMethodsUi()
        let onlinePaymentMethodsUi: PaymentMethodsUi = activeGateways?.asOnlinePaymentMethodsUi() ?? PaymentMethodsUi()
        let manualPaymentMethodsUi: PaymentMethodsUi = activeGateways?.asManualPaymentMethodsUi() ?? PaymentMethodsUi()
        paymentMethodsUi.append(savedPaymentMethodsUi)
        paymentMethodsUi.append(onlinePaymentMethodsUi)
        paymentMethodsUi.append(manualPaymentMethodsUi)
        return paymentMethodsUi
    }
}

extension Array where Element == Edges {
    
    func asSavedPaymentMethodsUi() -> PaymentMethodsUi {
        let paymentMethodUi: [PaymentMethodUi] = self.compactMap { edges in
            PaymentMethodUi(savedPaymentMethod: SavedPaymentMethodUi(title: "\(edges.node?.lastDigits ?? .empty) \(edges.node?.brand ?? .empty)",
                                                                     image: edges.node?.iconUrl ?? .empty,
                                                                     isDefault: edges.node?.isDefault ?? false))
        }
        return PaymentMethodsUi(title: .localizedString(key: "My cards"),type: .saved, paymentMethods: paymentMethodUi)
    }
}

extension Array where Element == ActiveGateways {
    
    func asOnlinePaymentMethodsUi() -> PaymentMethodsUi {
        let paymentMethodUi: [PaymentMethodUi] = self.compactMap { activeGateways in
            guard !activeGateways.isManualGateway() else { return nil }
            return PaymentMethodUi(gatewayPaymentMethod: GatewayPaymentMethodUi(title: activeGateways.description ?? .empty,
                                                                         images: activeGateways.asImages(),
                                                                         fullWidth: activeGateways.fullWidth ?? false,
                                                                         gatewayTypeUi:activeGateways.gatewayTypeUi()))
        }
        return PaymentMethodsUi(title: .localizedString(key: "Pay online"),type: .gateway, paymentMethods: paymentMethodUi)
    }
    
    func asManualPaymentMethodsUi() -> PaymentMethodsUi {
        let paymentMethodUi: [PaymentMethodUi] = self.compactMap { activeGateways in
            guard activeGateways.isManualGateway() else { return nil }
            return PaymentMethodUi(gatewayPaymentMethod: GatewayPaymentMethodUi(title: activeGateways.description ?? .empty,
                                                                         images: activeGateways.asImages(),
                                                                         fullWidth: activeGateways.fullWidth ?? false,
                                                                         gatewayTypeUi:activeGateways.gatewayTypeUi()))
        }
        return PaymentMethodsUi(title: .localizedString(key: "Pay on delivery"),type: .gateway, paymentMethods: paymentMethodUi)
    }
}

extension ActiveGateways {
    
    func asImages() -> [String] {
        providers?.compactMap{ providers in
            providers.iconUrl
        } ?? []
    }
    
    func gatewayTypeUi() -> GatewayTypeUi {
        let value: String = gateway ?? .empty
        return GatewayTypeUi(rawValue: value) ?? .defaultValue
    }
    
    func isManualGateway() -> Bool {
        gatewayTypeUi() == .manual
    }
}
// UI
extension Array where Element == PaymentMethodsUi {
    
    func getTitlePaymentMethodUi(_ section: Int) -> String {
        self[section].title
    }
    
    func sectionCount(_ section: Int) -> Int {
        self[section].paymentMethods.count
    }
    
    func getPaymentMethodUi(_ section: Int, row: Int) -> PaymentMethodUi {
        self[section].paymentMethods[row]
    }
    
    func isSavedPaymentMethods(_ section: Int) -> Bool {
        self[section].type == .saved
    }
}

extension PaymentMethodUi {
    
    func isManualPaymentMethod() -> Bool {
        gatewayPaymentMethod.gatewayTypeUi == .manual
    }
    
    func isFullWidth() -> Bool {
        gatewayPaymentMethod.fullWidth
    }
}

extension GatewayPaymentMethodUi {
    
    func isNotSelectedGatewayPayment() -> Bool {
        isAdyen() || isVoucher()
    }
    
    func isAdyen() -> Bool {
        gatewayTypeUi == .adyen
    }
    
    func isVoucher() -> Bool {
        gatewayTypeUi == .vouchers
    }
}
