import XCTest
@testable import InviteFriends
import Foundation

class CustomerListViewModelTests: XCTestCase {
    
    private static let customerFilePathLessThanHundredKm = "customersDistanceLessThan100kms"
    private let testBundleFilePathDataForLessThan100Kms = Bundle(for: CustomerListViewModelTests.self).path(forResource: customerFilePathLessThanHundredKm, ofType: "json")
    
    private static let customerFilePathMoreThanHundredKm = "customersDistanceMoreThan100kms"
    private let testBundleFilePathDataForMoreThan100Kms = Bundle(for: CustomerListViewModelTests.self).path(forResource: customerFilePathMoreThanHundredKm, ofType: "json")
    
    func testNavigationTitleNonNilForValidFilePath() {
        let customerDataFetcher = CustomerDataFetcher(filePath: testBundleFilePathDataForLessThan100Kms)
        let viewModel = CustomerListViewModel(customerDataFetcher: customerDataFetcher)
        XCTAssertNotNil(viewModel.navigationItemTitle)
        XCTAssertTrue(viewModel.navigationItemTitle!.contains("customers are within 100 km"))
    }
    
    func testNavigationTitleNilForInvalidFilePath() {
        let customerDataFetcher = CustomerDataFetcher(filePath: nil)
        let viewModel = CustomerListViewModel(customerDataFetcher: customerDataFetcher)
        XCTAssertNil(viewModel.navigationItemTitle)
    }
    
    func testCustomersDataWithin100KmComputedAreSortedByUserId() {
        let customerDataFetcher = CustomerDataFetcher(filePath: testBundleFilePathDataForLessThan100Kms)
        let viewModel = CustomerListViewModel(customerDataFetcher: customerDataFetcher)
        let expectedCustomerDataSortedByUserId = expectedCustomersSortedByUserID()
        let actualCustomerData = viewModel.customersWithinHundredKm
        XCTAssertTrue(actualCustomerData == expectedCustomerDataSortedByUserId)
    }
    
    func testCustomersDataEmptyForInvalidFilePathGiven() {
        let customerDataFetcher = CustomerDataFetcher(filePath: nil)
        let viewModel = CustomerListViewModel(customerDataFetcher: customerDataFetcher)
        XCTAssertTrue(viewModel.customersWithinHundredKm.isEmpty)
    }
    
    func testCustomersDataEmptyForValidFilePathHavingDistanceMoreThan100km() {
        let customerDataFetcher = CustomerDataFetcher(filePath: testBundleFilePathDataForMoreThan100Kms)
        let viewModel = CustomerListViewModel(customerDataFetcher: customerDataFetcher)
        XCTAssertTrue(viewModel.customersWithinHundredKm.isEmpty)
    }
    
    func testCustomersDataNotEmptyForValidFilePathHavingDistanceLessThan100km() {
        let customerDataFetcher = CustomerDataFetcher(filePath: testBundleFilePathDataForLessThan100Kms)
        let viewModel = CustomerListViewModel(customerDataFetcher: customerDataFetcher)
        XCTAssertFalse(viewModel.customersWithinHundredKm.isEmpty)
    }
    
    func testCustomersViewModelIsNonNilForResourceWithLessThan100KmsData() {
        let customerDataFetcher = CustomerDataFetcher(filePath: testBundleFilePathDataForLessThan100Kms)
        let viewModel = CustomerListViewModel(customerDataFetcher: customerDataFetcher)
        XCTAssertNotNil(viewModel.customerDataContainerViewModelFor(index: 0))
    }
    
    func testCustomersViewModelisNilForResourceWithMoreThan100KmsData() {
        let customerDataFetcher = CustomerDataFetcher(filePath: testBundleFilePathDataForMoreThan100Kms)
        let viewModel = CustomerListViewModel(customerDataFetcher: customerDataFetcher)
        XCTAssertNil(viewModel.customerDataContainerViewModelFor(index: 0))
    }
    
    func testCustomersViewModelIsNilForNegativeIndexAndForValidFilePath() {
        let customerDataFetcher = CustomerDataFetcher(filePath: testBundleFilePathDataForLessThan100Kms)
        let viewModel = CustomerListViewModel(customerDataFetcher: customerDataFetcher)
        XCTAssertNil(viewModel.customerDataContainerViewModelFor(index: -1))
    }
    
    func testCustomersViewModelIsNilForNegativeIndexAndForInValidFilePath() {
        let customerDataFetcher = CustomerDataFetcher(filePath: nil)
        let viewModel = CustomerListViewModel(customerDataFetcher: customerDataFetcher)
        XCTAssertNil(viewModel.customerDataContainerViewModelFor(index: -1))
    }
    
    func testAlertTitleShownWhenTappedOnCell() {
        let customerDataFetcher = CustomerDataFetcher(filePath: testBundleFilePathDataForLessThan100Kms)
        let viewModel = CustomerListViewModel(customerDataFetcher: customerDataFetcher)
        XCTAssertEqual(viewModel.alertTitle, "Coming Soon!")
    }
    
    func testAlertMessageStringForAnyValidIndex() {
        let customerDataFetcher = CustomerDataFetcher(filePath: testBundleFilePathDataForLessThan100Kms)
        let viewModel = CustomerListViewModel(customerDataFetcher: customerDataFetcher)
        let alertMessage = viewModel.alertMessageForIndex(index: 0)
        XCTAssertEqual(alertMessage, "Hey Richard Finnegan! Food And Drinks are on us. You will be invited soon.")
    }
    
    func testAlertMessageStringNilForNegativeIndex() {
        let customerDataFetcher = CustomerDataFetcher(filePath: testBundleFilePathDataForLessThan100Kms)
        let viewModel = CustomerListViewModel(customerDataFetcher: customerDataFetcher)
        let alertMessage = viewModel.alertMessageForIndex(index: -1)
        XCTAssertNil(alertMessage)
    }
    
    func testAlertMessageStringNilForInvalidFilePath() {
        let customerDataFetcher = CustomerDataFetcher(filePath: nil)
        let viewModel = CustomerListViewModel(customerDataFetcher: customerDataFetcher)
        let alertMessage = viewModel.alertMessageForIndex(index: 0)
        XCTAssertNil(alertMessage)
    }
    
    private func expectedCustomersSortedByUserID() -> [CustomerDataContainerViewModel] {
        let mockData1 = CustomerDataContainerViewModel(userId: 4, name: "Richard Finnegan", distance: "38")
        let mockData2 = CustomerDataContainerViewModel(userId: 5, name: "Nora Dempsey", distance: "23")
        let mockData3 = CustomerDataContainerViewModel(userId: 11, name: "Ian Kehoe", distance: "11")
        let mockData4 = CustomerDataContainerViewModel(userId: 15, name: "Michael Ahearn", distance: "44")
        let mockData5 = CustomerDataContainerViewModel(userId: 17, name: "Patricia Cahill", distance: "96")
        return [mockData1, mockData2, mockData3, mockData4, mockData5]
    }
}
