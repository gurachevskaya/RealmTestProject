//
//  Contact.swift
//  RealmTestProject
//
//  Created by Karina gurachevskaya on 23.09.22.
//

import Foundation
import RealmSwift

final class Contact: Object {
    @Persisted var fullName = ""
    @Persisted var phone = ""
    @Persisted var email = ""
    @Persisted var age: Int?
    
    static func create(
        withName name: String,
        phone: String,
        email: String,
        age: Int?
    ) -> Contact {
        let contact = Contact()
        contact.fullName = name
        contact.phone = phone
        contact.email = email
        contact.age = age
        
        return contact
    }
}
