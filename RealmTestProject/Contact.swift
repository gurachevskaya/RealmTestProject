//
//  Contact.swift
//  RealmTestProject
//
//  Created by Karina gurachevskaya on 23.09.22.
//

import Foundation
import RealmSwift

class Contact: Object {
    @objc dynamic var name = ""
    @objc dynamic var phone = ""

    static func create(withName name: String, phone: String) -> Contact {
        let contact = Contact()
        contact.name = name
        contact.phone = phone
        
        return contact
    }
}
