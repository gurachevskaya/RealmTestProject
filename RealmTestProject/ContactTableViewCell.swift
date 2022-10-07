//
//  ContactTableViewCell.swift
//  RealmTestProject
//
//  Created by Karina gurachevskaya on 7.10.22.
//

import UIKit

class ContactTableViewCell: UITableViewCell {
    
    static let reuseID = "ContactTableViewCell"

    private let userNameLabel = UILabel()
    private let phoneNumberLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupWith(contact: Contact) {
        userNameLabel.text = "Name: \(contact.name)"
        phoneNumberLabel.text = "Phone: \(contact.phone)"
    }
    
    private func setupUI() {
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        phoneNumberLabel.translatesAutoresizingMaskIntoConstraints = false
       
        contentView.addSubview(userNameLabel)
        contentView.addSubview(phoneNumberLabel)
     
        NSLayoutConstraint.activate([
            userNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 10),
            userNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            userNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            phoneNumberLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 10),
            phoneNumberLabel.leadingAnchor.constraint(equalTo: userNameLabel.leadingAnchor),
            phoneNumberLabel.trailingAnchor.constraint(equalTo: userNameLabel.trailingAnchor),
            phoneNumberLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
        ])
    }
}