import Foundation
import UIKit
import CoreLocation

class CustomerListViewModel {

    private let customerDataFetcher: CustomerDataFetcher
    private let officeLocation = CLLocation(latitude: 53.339428, longitude: -6.257664)
    let alertTitle = "Coming Soon!"
    
    init(customerDataFetcher: CustomerDataFetcher) {
        self.customerDataFetcher = customerDataFetcher
    }

    var customersWithinHundredKm: [CustomerDataContainerViewModel] {
        var customerWithinHundredKm = [CustomerDataContainerViewModel]()
        for customer in customerDataFetcher.customers {
            let distanceFromOffice = calculateDistance(latitude: customer.latitude,
                                                       longitude: customer.longitude)
            if distanceFromOffice <= 100 {
                let cellViewModel = CustomerDataContainerViewModel(userId: customer.userId,
                                                                   name: customer.name,
                                                                   distance: String(distanceFromOffice))
                customerWithinHundredKm.append(cellViewModel)
            }
        }
        return customerWithinHundredKm.sorted { $0.userId < $1.userId }
    }
    
    private func calculateDistance(latitude: String, longitude: String) -> Int {
        let customerLatitude = Double(latitude) ?? 0.0
        let customerLongitude = Double(longitude) ?? 0.0
        let customerLocation = CLLocation(latitude: customerLatitude, longitude: customerLongitude)
        let distanceFromOfficeInKms = officeLocation.distance(from: customerLocation)/1000.0
        return Int(distanceFromOfficeInKms.rounded())
    }

    func customerDataContainerViewModelFor(index: Int) -> CustomerDataContainerViewModel? {
        guard index >= 0 else { return nil }
        return !customersWithinHundredKm.isEmpty ? customersWithinHundredKm[index] : nil
    }

    var navigationItemTitle: String? {
        let customersCount = customersWithinHundredKm.count
        return !customersWithinHundredKm.isEmpty ? "\(customersCount) customers are within 100 km" : nil
    }
    
    func alertMessageForIndex(index: Int) -> String? {
         guard index >= 0 else { return nil }
         return !customersWithinHundredKm.isEmpty ? "Hey \(customersWithinHundredKm[index].name)! Food And Drinks are on us. You will be invited soon." : nil
    }
}
