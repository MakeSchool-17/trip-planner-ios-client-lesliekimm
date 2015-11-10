//
//  Waypoint.swift
//  TripPlanner
//
//  Created by Leslie Kim on 11/4/15.
//  Copyright © 2015 Leslie Kim. All rights reserved.
//

import Foundation
import CoreData


class Waypoint: NSManagedObject {
    @NSManaged var name: String?
    @NSManaged var longitude: String?
    @NSManaged var latitude: String?
    
    convenience init(context: NSManagedObjectContext) {
        let entityDescription = NSEntityDescription.entityForName("Waypoint", inManagedObjectContext:
            context)!
        self.init(entity: entityDescription, insertIntoManagedObjectContext: context)
    }
// Insert code here to add functionality to your managed object subclass

}
