//
//  ADDataStore.swift
//  Xor-AthocDemo
//
//  Created by Sahil Ratnani on 29/04/23.
//

import Foundation
import CoreData

class ADDataStore {
    private static let coredataStack = CoreDataStack.sharedInstance

    private static var moc: NSManagedObjectContext {
        coredataStack.persistentContainer.viewContext
    }

    private init() { }

    class func createNewManagedObject<T>(type: T.Type) -> T? where T: NSManagedObject {
        let object = NSEntityDescription.insertNewObject(forEntityName: T.entity().name ?? "", into: moc) as? T
        return object
    }

    class func save() {
        do {
            try moc.save()
        } catch {
            fatalError("Failure to save context: \(error)")
        }
    }

    class func createUser(contactType: Int, contact: String?) -> User? {
        let user = createNewManagedObject(type: User.self)
        user?.contactType = Int16(contactType)
        user?.contact = contact
        return user
    }

    class func getUser() -> User? {
        do {
            let fetchedUsers = try moc.fetch(User.fetchRequest()) as? [User]
            if fetchedUsers?.count ?? 0 > 1 {
                assertionFailure("Multiple users got registered")
            }
            return fetchedUsers?.first
        } catch {
            assertionFailure("Failed to fetch employees: \(error)")
            return nil
        }
    }
}
