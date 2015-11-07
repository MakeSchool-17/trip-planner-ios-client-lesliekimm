//
//  TripManager.swift
//  TripPlanner
//
//  Created by Leslie Kim on 11/6/15.
//  Copyright © 2015 Leslie Kim. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class TripManager: NSObject {
    var myCoreData = (UIApplication.sharedApplication().delegate as! AppDelegate?)!.myCoreData
    
    func addTrip(name: String) -> Trip {
        let context: NSManagedObjectContext = myCoreData!.managedObjectContext
        let trip = Trip(context: context)
//        let trip: Trip = NSEntityDescription.insertNewObjectForEntityForName("Trip", inManagedObjectContext:context)
        
        trip.name = name
        do {
            try context.save()
        }
        catch {
            print("error")
        }
        return trip
    }
}

