import Foundation
import UIKit

class CustomerDataContainerView: UITableViewCell {
    
    private var viewModel: CustomerDataContainerViewModel?
    
    private let customerDataContainerView: UIView = {
        let dataContainerView = UIView()
        dataContainerView.translatesAutoresizingMaskIntoConstraints = false
        dataContainerView.layer.cornerRadius = 2.0
        dataContainerView.layer.borderColor = UIColor.darkGray.cgColor
        dataContainerView.layer.borderWidth = 0.1
        dataContainerView.backgroundColor = UIColor.white
        return dataContainerView
    }()
    
    private let customerNameLabel: UILabel = {
        let customerNameLabel = UILabel()
        customerNameLabel.translatesAutoresizingMaskIntoConstraints = false
        customerNameLabel.font = UIFont.boldSystemFont(ofSize: 17.0)
        customerNameLabel.textColor = UIColor.darkGray
        return customerNameLabel
    }()
    
    private let customerDistanceLabel: UILabel = {
        let customerDistanceLabel = UILabel()
        customerDistanceLabel.font = UIFont.boldSystemFont(ofSize: 17.0)
        customerDistanceLabel.textColor = UIColor.darkGray
        customerDistanceLabel.translatesAutoresizingMaskIntoConstraints = false
        return customerDistanceLabel
    }()
    
    private let customerUserIdLabel: UILabel = {
        let customerUserIdLabel = UILabel()
        customerUserIdLabel.font = UIFont.boldSystemFont(ofSize: 17.0)
        customerUserIdLabel.textColor = UIColor.darkGray
        customerUserIdLabel.translatesAutoresizingMaskIntoConstraints = false
        return customerUserIdLabel
    }()
    
    private let invitationIconView: UIImageView = {
        let image = UIImage(named: "invitationIcon")
        let invitationIconView = UIImageView(image: image)
        invitationIconView.contentMode = .scaleAspectFit
        invitationIconView.translatesAutoresizingMaskIntoConstraints = false
        invitationIconView.heightAnchor.constraint(equalToConstant: 35.0).isActive = true
        invitationIconView.widthAnchor.constraint(equalToConstant: 35.0).isActive = true
        return invitationIconView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .clear
        setUpCustomerDataContainerView()
        setUpConstraints()
    }
    
    private func setUpCustomerDataContainerView() {
        customerDataContainerView.addSubview(customerNameLabel)
        customerDataContainerView.addSubview(customerUserIdLabel)
        customerDataContainerView.addSubview(customerDistanceLabel)
        customerDataContainerView.addSubview(invitationIconView)
        self.contentView.addSubview(customerDataContainerView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateWithViewModel(cellViewModel: CustomerDataContainerViewModel?) {
        self.viewModel = cellViewModel
        guard let viewModel = self.viewModel else { return }
        customerNameLabel.text = viewModel.name
        customerDistanceLabel.text = viewModel.distanceFromOffice
        customerUserIdLabel.text = viewModel.userIdLabel
    }
    
    private func setUpConstraints() {
        var constraints = [NSLayoutConstraint]()
        constraints.append(customerDataContainerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8.0))
        constraints.append(customerDataContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24.0))
        constraints.append(customerDataContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24.0))
        constraints.append(customerDataContainerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8.0))
        constraints.append(customerNameLabel.topAnchor.constraint(equalTo: customerDataContainerView.topAnchor, constant: 8.0))
        constraints.append(customerNameLabel.leadingAnchor.constraint(equalTo: customerDataContainerView.leadingAnchor, constant: 16.0))
        constraints.append(customerDistanceLabel.topAnchor.constraint(equalTo: customerDataContainerView.topAnchor, constant: 8.0))
        constraints.append(customerDistanceLabel.trailingAnchor.constraint(equalTo: customerDataContainerView.trailingAnchor, constant: -16.0))
        constraints.append(customerUserIdLabel.topAnchor.constraint(equalTo: customerNameLabel.bottomAnchor, constant: 16.0))
        constraints.append(customerUserIdLabel.leadingAnchor.constraint(equalTo: customerDataContainerView.leadingAnchor, constant: 16.0))
        constraints.append(invitationIconView.topAnchor.constraint(equalTo: customerDistanceLabel.bottomAnchor, constant: 8.0))
        constraints.append(invitationIconView.trailingAnchor.constraint(equalTo: customerDataContainerView.trailingAnchor, constant: -16.0))
        NSLayoutConstraint.activate(constraints)
    }
}
