//
//  ViewController.swift
//  RealmTestProject
//
//  Created by Karina gurachevskaya on 23.09.22.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
    
    private var contacts: [Contact] = []
    private var token: NotificationToken?
    
    private lazy var addButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ContactTableViewCell.self, forCellReuseIdentifier: ContactTableViewCell.reuseID)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
        configRealm()
        getContacts()
    }
    
    private func config() {
        addButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(addButton)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            addButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            addButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            addButton.heightAnchor.constraint(equalToConstant: 50),
        
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.topAnchor.constraint(equalTo: addButton.bottomAnchor)
        ])
    }
    
    private func configRealm() {
        let config = Realm.Configuration(
            schemaVersion: 3
        )
        Realm.Configuration.defaultConfiguration = config
    }
    
    @objc
    private func addButtonTapped() {
        let alertController = UIAlertController(title: "Add New Contact", message: "", preferredStyle: .alert)
        
        alertController.addTextField { textField in
            textField.placeholder = "Enter First Name"
        }
        alertController.addTextField { textField in
            textField.placeholder = "Enter Phone number"
            textField.keyboardType = .phonePad
        }
        alertController.addTextField { textField in
            textField.placeholder = "Enter Email"
            textField.keyboardType = .emailAddress
        }
        alertController.addTextField { textField in
            textField.placeholder = "Enter Age"
            textField.keyboardType = .numberPad
        }
        
        let saveAction = UIAlertAction(title: "Save", style: .default, handler: { alert in
            let nameTextField = alertController.textFields?[0]
            let phoneTextField = alertController.textFields?[1]
            let emailTextField = alertController.textFields?[2]
            let ageTextField = alertController.textFields?[3]
            
            self.addContact(
                name: nameTextField?.text ?? "",
                phone: phoneTextField?.text ?? "",
                email: emailTextField?.text ?? "",
                age: ageTextField?.text ?? ""
            )
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .default)
    
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    private func addContact(name: String, phone: String, email: String, age: String) {
        let contact = Contact.create(withName: name, phone: phone, email: email, age: age)
        
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(contact)
            }
        } catch let error {
            print(error.localizedDescription)
        }
        
        updateContacts()
    }
    
    private func updateContacts() {
        getContacts()
        tableView.reloadData()
    }
    
    private func getContacts() {
        do {
            let realm = try Realm()
            let results = realm.objects(Contact.self)
                .sorted(by: { $0.fullName < $1.fullName })
            self.contacts = results
        } catch let error {
            print(error.localizedDescription)
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ContactTableViewCell.reuseID, for: indexPath) as? ContactTableViewCell else {
            return UITableViewCell()
        }
        
        let contact = contacts[indexPath.row]
        cell.setupWith(contact: contact)
        
        return cell
    }
}


