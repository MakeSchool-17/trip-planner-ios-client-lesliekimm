//
//  Trip.swift
//  TripPlanner
//
//  Created by Leslie Kim on 11/4/15.
//  Copyright © 2015 Leslie Kim. All rights reserved.
//

import Foundation
import CoreData

// represents what's in DB so that when this is modified, it's modified in DB
class Trip: NSManagedObject {
    @NSManaged var name: String?

    convenience init(context: NSManagedObjectContext) {
        let entityDescription = NSEntityDescription.entityForName("Trip", inManagedObjectContext:
            context)!
        self.init(entity: entityDescription, insertIntoManagedObjectContext: context)
    }
// Insert code here to add functionality to your managed object subclass

}
