//
//  CoreDataStack.swift
//  TripPlanner
//
//  Created by Leslie Kim on 11/4/15.
//  Copyright © 2015 Leslie Kim. All rights reserved.
//

// SOURCES: http://purelywebdesign.co.uk/tutorial/add-coredata-to-an-exiting-swift-2-0-project/
//          http://craig24.com/2014/12/how-to-add-core-data-to-an-existing-swift-project-in-xcode/
//          https://gist.github.com/Ben-G/54f363482303b984574b

import Foundation
import CoreData

enum CoreDataStackType {
    case InMemory, SQLite
}

class CoreDataStack {
    private(set) var managedObjectContext: NSManagedObjectContext
    private var storeCoordinator: NSPersistentStoreCoordinator!
    private var stackType: CoreDataStackType
    
    // Directory app uses to store the Core Data store file - this code uses a directory named
    // "com.lesliekimm.TripPlanner" in the application's documents Application Support directory
    lazy var applicationDocumentsDirectory: NSURL = {
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory,
                                                                   inDomains: .UserDomainMask)
        return urls[urls.count - 1]
    }()
    
    init(stackType: CoreDataStackType) {
        self.stackType = stackType
        
        let modelURL = NSBundle.mainBundle().URLForResource("TripPlanner", withExtension: "momd")!
        let model = NSManagedObjectModel(contentsOfURL: modelURL)
        storeCoordinator = NSPersistentStoreCoordinator(managedObjectModel: model!)
        
        managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = storeCoordinator
        
        self.setupPersistentStore()
    }
    
    private func setupPersistentStore() {
        let failureReason = "There was an error creating or loading the application's saved data."
        do {
            switch (stackType) {
            case .InMemory:
                try storeCoordinator.addPersistentStoreWithType(NSInMemoryStoreType, configuration: nil, URL: nil, options: nil)
            case .SQLite:
                let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("SingleViewCoreData.sqlite")
                try storeCoordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil)
            }
        }
        catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason
            
            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this implementation with code to handle the error appropriately
            // abort() causes the application to generate a crash log and terminate
            // This function should not be used in a shipping app, although it may be useful during dev
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
    }
    
    func save() {
        if !managedObjectContext.hasChanges {
            return
        }
        
        managedObjectContext.performBlockAndWait { () -> Void in
            // Catch-all clause necessary, due to bug in Swift 2
            // See: https://openradar.appspot.com/21669303
            do {
                try self.managedObjectContext.save()
            }
            catch let error as NSError {
                assertionFailure("Error saving context: \(error), \(error.userInfo)")
            }
            catch {
                assertionFailure("Undefined error")
            }
        }
    }
}