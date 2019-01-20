import XCTest
@testable import InviteFriends

class CustomerDataContainerViewModelTests: XCTestCase {
    
    func testuserName() {
        let viewModel = CustomerDataContainerViewModel(userId: 4, name: "Richard", distance: "45")
        XCTAssertEqual(viewModel.name, "Richard")
    }

    func testUserId() {
        let viewModel = CustomerDataContainerViewModel(userId: 4, name: "Richard", distance: "45")
        XCTAssertEqual(viewModel.userIdLabel, "UserID: 4")
    }

    func testDistanceFromOffice() {
        let viewModel = CustomerDataContainerViewModel(userId: 4, name: "Richard", distance: "45")
        XCTAssertEqual(viewModel.distanceFromOffice, "45 km away!")
    }
}
