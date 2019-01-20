import Foundation

struct Customers: Decodable, Equatable {
    let latitude: String
    let userId: Int
    let name: String
    let longitude: String
    
    enum CodingKeys: String, CodingKey {
        case userId = "user_id", latitude = "latitude", name = "name", longitude = "longitude"
    }
}
