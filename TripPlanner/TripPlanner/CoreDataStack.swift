//
//  CoreDataStack.swift
//  TripPlanner
//
//  Created by Leslie Kim on 11/4/15.
//  Copyright © 2015 Leslie Kim. All rights reserved.
//

// NOTE: http://purelywebdesign.co.uk/tutorial/add-coredata-to-an-exiting-swift-2-0-project/
// ^ used to update code from http://craig24.com/2014/12/how-to-add-core-data-to-an-existing-swift-project-in-xcode/

import Foundation
import CoreData

class CoreDataStack {
    // Directory the app uses to store the Core Data store file - this code uses a directory named
    // "com.xxxx.ProjectName" in app's docs Application Support directory
    lazy var applicationDocumentsDirectory: NSURL = {
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory,
                                                                   inDomains: .UserDomainMask)
        return urls[urls.count - 1]
    }()
    
    // Managed obj model for app - not an optional prop, it is a fatal error for app to not find & load model
    lazy var managedObjectModel: NSManagedObjectModel = {
        // String must be name of data model file
        let modelURL = NSBundle.mainBundle().URLForResource("TripPlanner", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()
    
    // Persistent store coordinator for app - creates & returns a coordinator after adding store for app to it
    // Optional prop b/c there are error conditions that can cause creation of store to fial
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("PROJECTNAME.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url,
                                                       options: nil)
        }
        catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason
            
            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately
            // abort() causes the application to generate a crash log and terminate
            // This function should not be used in a shipping app, although it may be useful during dev
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        return coordinator
    }()
    
    // Return managed obj context for app - optional prop b/c there are error conditions that could cause the
    // creation of the context to fail
    lazy var managedObjectContext: NSManagedObjectContext? = {
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext()
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        if let moc = self.managedObjectContext {
            do {
                try moc.save()
            }
            catch {
                // Replace this implementation with code to handle the error appropriately
                // abort() causes the application to generate a crash log and terminate
                // This function should not be used in a shipping app, although it may be useful during dev
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }
}