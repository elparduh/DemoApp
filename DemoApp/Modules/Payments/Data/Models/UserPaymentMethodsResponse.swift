import Foundation

struct UserPaymentMethodsResponse : Codable {
    let data : DataClass?

    enum CodingKeys: String, CodingKey {

        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(DataClass.self, forKey: .data)
    }
}

struct DataClass: Codable {
    let userPaymentMethods : UserPaymentMethods?

    enum CodingKeys: String, CodingKey {

        case userPaymentMethods = "userPaymentMethods"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        userPaymentMethods = try values.decodeIfPresent(UserPaymentMethods.self, forKey: .userPaymentMethods)
    }
}

struct UserPaymentMethods: Codable {
    let activeGateways : [ActiveGateways]?
    let edges : [Edges]?

    enum CodingKeys: String, CodingKey {

        case activeGateways = "activeGateways"
        case edges = "edges"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        activeGateways = try values.decodeIfPresent([ActiveGateways].self, forKey: .activeGateways)
        edges = try values.decodeIfPresent([Edges].self, forKey: .edges)
    }
}

struct ActiveGateways : Codable {
    let gateway : String?
    let description : String?
    let providers : [Providers]?
    let sortOrder : Int?
    let fullWidth : Bool?

    enum CodingKeys: String, CodingKey {

        case gateway = "gateway"
        case description = "description"
        case providers = "providers"
        case sortOrder = "sortOrder"
        case fullWidth = "fullWidth"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        gateway = try values.decodeIfPresent(String.self, forKey: .gateway)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        providers = try values.decodeIfPresent([Providers].self, forKey: .providers)
        sortOrder = try values.decodeIfPresent(Int.self, forKey: .sortOrder)
        fullWidth = try values.decodeIfPresent(Bool.self, forKey: .fullWidth)
    }
}

struct Providers : Codable {
    let name : String?
    let iconUrl : String?

    enum CodingKeys: String, CodingKey {

        case name = "name"
        case iconUrl = "iconUrl"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        iconUrl = try values.decodeIfPresent(String.self, forKey: .iconUrl)
    }

}

struct Edges : Codable {
    let node : Node?

    enum CodingKeys: String, CodingKey {

        case node = "node"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        node = try values.decodeIfPresent(Node.self, forKey: .node)
    }
}

struct Node : Codable {
    let id : String?
    let tokenId : String?
    let reference : String?
    let brand : String?
    let iconUrl : String?
    let expirationMonth : String?
    let expirationYear : String?
    let lastDigits : String?
    let isDefault : String?
    let gateway : String?
    let requireCvv : Bool?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case tokenId = "tokenId"
        case reference = "reference"
        case brand = "brand"
        case iconUrl = "iconUrl"
        case expirationMonth = "expirationMonth"
        case expirationYear = "expirationYear"
        case lastDigits = "lastDigits"
        case isDefault = "isDefault"
        case gateway = "gateway"
        case requireCvv = "requireCvv"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        tokenId = try values.decodeIfPresent(String.self, forKey: .tokenId)
        reference = try values.decodeIfPresent(String.self, forKey: .reference)
        brand = try values.decodeIfPresent(String.self, forKey: .brand)
        iconUrl = try values.decodeIfPresent(String.self, forKey: .iconUrl)
        expirationMonth = try values.decodeIfPresent(String.self, forKey: .expirationMonth)
        expirationYear = try values.decodeIfPresent(String.self, forKey: .expirationYear)
        lastDigits = try values.decodeIfPresent(String.self, forKey: .lastDigits)
        isDefault = try values.decodeIfPresent(String.self, forKey: .isDefault)
        gateway = try values.decodeIfPresent(String.self, forKey: .gateway)
        requireCvv = try values.decodeIfPresent(Bool.self, forKey: .requireCvv)
    }
}
