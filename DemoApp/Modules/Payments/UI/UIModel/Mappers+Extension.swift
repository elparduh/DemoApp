import Foundation

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
            PaymentMethodUi(gatewayPaymentMethod: GatewayPaymentMethodUi(title: activeGateways.description ?? .empty,
                                                                         images: activeGateways.asImages(),
                                                                         fullWidth: activeGateways.fullWidth ?? false,
                                                                         sortOrder: activeGateways.sortOrder ?? .zero,
                                                                         gatewayTypeUi:activeGateways.gatewayTypeUi()))
        }
        return PaymentMethodsUi(title: .localizedString(key: "Pay online"),type: .gateway, paymentMethods: paymentMethodUi)
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
}
