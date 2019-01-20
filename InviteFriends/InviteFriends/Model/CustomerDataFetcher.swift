import Foundation

class CustomerDataFetcher {
    
    private let filePath: String?

    var customers: [Customers] {
        do {
            guard let filePath = self.filePath else { return [] }
            let jsonData = try Data(contentsOf: URL(fileURLWithPath: filePath))
            let decoder = JSONDecoder()
            let customersData = try decoder.decode([Customers].self, from: jsonData)
            return customersData
        } catch {
            print(error)
        }
        return []
    }
    
    init(filePath: String? = nil) {
        self.filePath = filePath
    }
}
