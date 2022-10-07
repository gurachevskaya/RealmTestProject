//
//  Contact.swift
//  RealmTestProject
//
//  Created by Karina gurachevskaya on 23.09.22.
//

import Foundation
import RealmSwift

class Contact: Object {
    @objc dynamic var fullName = ""
    @objc dynamic var phone = ""
    @objc dynamic var email = ""
    @objc dynamic var age = ""

    static func create(
        withName name: String,
        phone: String,
        email: String,
        age: String
    ) -> Contact {
        let contact = Contact()
        contact.fullName = name
        contact.phone = phone
        contact.email = email
        contact.age = age
        
        return contact
    }
}
