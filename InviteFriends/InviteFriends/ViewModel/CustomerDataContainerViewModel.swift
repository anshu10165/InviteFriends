import Foundation

class CustomerDataContainerViewModel: Equatable {

    let userId: Int
    let name: String
    private let distance: String

    init(userId: Int, name: String, distance: String) {
        self.userId = userId
        self.name = name
        self.distance = distance
    }

    var userIdLabel: String {
        return "UserID: \(userId)"
    }

    var distanceFromOffice: String {
        return "\(distance) km away!"
    }
    
    static func == (lhs: CustomerDataContainerViewModel, rhs: CustomerDataContainerViewModel) -> Bool {
        return lhs.name == rhs.name &&
            lhs.userId == rhs.userId &&
            lhs.distance == rhs.distance
    }
}
