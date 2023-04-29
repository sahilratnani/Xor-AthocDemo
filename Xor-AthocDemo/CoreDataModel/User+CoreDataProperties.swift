//
//  User+CoreDataProperties.swift
//  Xor-AthocDemo
//
//  Created by Sahil Ratnani on 29/04/23.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var contactType: Int16
    @NSManaged public var contact: String?

    var contactTypeEnum: ContactType? {
        return ContactType(rawValue: Int(contactType))
    }
}

extension User : Identifiable {

}
