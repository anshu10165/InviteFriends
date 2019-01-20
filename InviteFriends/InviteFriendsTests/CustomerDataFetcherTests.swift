import XCTest
@testable import InviteFriends

class CustomerDataFetcherTests: XCTestCase {
    
    private static let resource = "customersDistanceLessThan100kms"
    private let testBundleFilePath = Bundle(for: CustomerDataFetcherTests.self).path(forResource: resource, ofType: "json")
    
    func testCustomerListEmptyForNilFilePath() {
        let customerDataFetcher = CustomerDataFetcher(filePath: nil)
        XCTAssertTrue(customerDataFetcher.customers.isEmpty)
    }
    
    func testCustomerListNonEmptyForValidFilePath() {
        let customerDataFetcher = CustomerDataFetcher(filePath: testBundleFilePath)
        let expectedCustomersList = customerList()
        XCTAssertTrue(customerDataFetcher.customers == expectedCustomersList)
    }
    
    private func customerList() -> [Customers] {
        let customer1 = Customers(latitude: "53.2451022", userId: 11, name: "Ian Kehoe", longitude: "-6.238335")
        let customer2 = Customers(latitude: "53.1302756", userId: 5, name: "Nora Dempsey", longitude: "-6.2397222")
        let customer3 = Customers(latitude: "53.008769", userId: 4, name: "Richard Finnegan", longitude: "-6.1056711")
        let customer4 = Customers(latitude: "52.966", userId: 15, name: "Michael Ahearn", longitude: "-6.463")
        let customer5 = Customers(latitude: "54.180238", userId: 17, name: "Patricia Cahill", longitude: "-5.920898")
        return [customer1, customer2, customer3, customer4, customer5]
    }
}
