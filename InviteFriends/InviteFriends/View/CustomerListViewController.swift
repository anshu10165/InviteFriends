import UIKit
import CoreLocation

class CustomerListViewController: UIViewController {
    
    private let viewModel: CustomerListViewModel
    private let cellReusableIdentifier: String = "cellIdentifier"
    
    private lazy var customerListView: UITableView = {
        let tableView  = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height), style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.groupTableViewBackground
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = 96.0
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        return tableView
    }()
    
    init(viewModel: CustomerListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.viewModel = CustomerListViewModel(customerDataFetcher: CustomerDataFetcher(filePath: nil))
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
        customerListView.register(CustomerDataContainerView.self, forCellReuseIdentifier: cellReusableIdentifier)
        self.view.addSubview(customerListView)
    }
    
    private func setUpNavigationBar() {
        self.navigationItem.title = viewModel.navigationItemTitle
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white,
                                   NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18.0)]
        self.navigationController?.navigationBar.titleTextAttributes = titleTextAttributes
        self.navigationController?.navigationBar.barTintColor = UIColor.red
    }
}

extension CustomerListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.customersWithinHundredKm.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var customerDataContainerView: CustomerDataContainerView
        customerDataContainerView = tableView.dequeueReusableCell(withIdentifier: cellReusableIdentifier, for: indexPath) as! CustomerDataContainerView
        let customerDataContainerViewModel = viewModel.customerDataContainerViewModelFor(index: indexPath.row)
        customerDataContainerView = CustomerDataContainerView(style: .default, reuseIdentifier: cellReusableIdentifier)
        customerDataContainerView.updateWithViewModel(cellViewModel: customerDataContainerViewModel)
        return customerDataContainerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let message = viewModel.alertMessageForIndex(index: indexPath.row)
        let alertTitle = viewModel.alertTitle
        DispatchQueue.main.async {
            let alertViewController = UIAlertController(title: alertTitle,
                                                        message: message,
                                                        preferredStyle: .alert)
            let closeAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertViewController.addAction(closeAction)
            self.navigationController?.present(alertViewController, animated: true)
        }
    }
}
