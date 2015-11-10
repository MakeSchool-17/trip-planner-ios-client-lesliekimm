//
//  WaypointManager.swift
//  TripPlanner
//
//  Created by Leslie Kim on 11/10/15.
//  Copyright © 2015 Leslie Kim. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class WaypointManager: NSObject {
    var myCoreData = (UIApplication.sharedApplication().delegate as! AppDelegate?)!.myCoreData
    
    func addWaypoint(name: String, longitude: String, latitude: String) -> Waypoint {
        let context: NSManagedObjectContext = myCoreData!.managedObjectContext
        let waypoint = Waypoint(context: context)
        
        waypoint.name = name
        waypoint.longitude = longitude
        waypoint.name = latitude
        do {
            try context.save()
        }
        catch {
            print("error")
        }
        return waypoint
    }
}

