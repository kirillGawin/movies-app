//
//  CoreDataStack.swift
//  MoviesApp
//
//  Created by gawin on 30/12/2025.
//

import CoreData

final class CoreDataStack {
    
    static let shared = CoreDataStack()
    
    let container: NSPersistentContainer
    
    private init() {
        container = NSPersistentContainer(name: "MoviesApp")
        container.loadPersistentStores { _, error in
            if let error {
                fatalError("CoreData error: \(error)")
            }
        }
    }
    var context: NSManagedObjectContext {
        container.viewContext
    }
    
    func save() {
        if context.hasChanges {
            try? context.save()
        }
    }
}
