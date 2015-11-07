//
// PlannedTripsViewController.swift
// TripPlanner
//
// Created by Leslie Kim on 11/3/15.
// Copyright © 2015 Leslie Kim. All rights reserved.
//

// SOURCES:
// 1) adding new trips to table view using UIAlerts:
//    http://www.raywenderlich.com/115695/getting-started-with-core-data-tutorial


import UIKit
import CoreData

class PlannedTripsViewController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var tripsTableView: UITableView!             // code connection for table view
    
    var trips = [Trip]()                                        // declare array of Trips
    var selectedTrip: Trip?                                     // declare selectedTrip obj
    
    // When the Add Nav Bar Button is selected, an alert will pop up prompting the
    // user to add the name for a new trip, which is stored in the trips array
    @IBAction func addTrip(sender: AnyObject) {
        // Create an alert that prompts user to enter a trip name
        let alert = UIAlertController(title: "New Trip",
                                      message: "Give this new trip a name",
                                      preferredStyle: .Alert)
        
        // Save button will append new Trip to trips array and reload the tripsTableView
        let saveAction = UIAlertAction(title: "Save",
                                       style: .Default,
                                       handler: {(action: UIAlertAction) -> Void in
                                                  let textField = alert.textFields!.first
                                                  let addedTrip = TripManager().addTrip(textField!.text!)
                                                  self.trips.append(addedTrip)
                                                  self.tripsTableView.reloadData()
                                                })
        
        // Cancel button will dismiss action sheet
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) {(action: UIAlertAction) -> Void in
        }
        
        // Add a placeholder to the text field
        alert.addTextFieldWithConfigurationHandler {(textField: UITextField) -> Void in
                                                     textField.placeholder = "Trip name"
        }
        
        alert.addAction(saveAction)                             // add save button action
        alert.addAction(cancelAction)                           // add cancel button action
        
        presentViewController(alert, animated: true, completion: nil)
    }

    // A ViewController that displays the waypoints for a specific trip will use
    // this segue to return to the PlannedTripsViewController.
    @IBAction func backToPlannedTrips(segue: UIStoryboardSegue) {
        if let identifier = segue.identifier {
            print("Identifier \(identifier) returning to Planned Trips.")
        }
    }
    

    // Set the title of the View Controller and store all the Trip instances in trips array
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Planned Trips"                                 // set title of view controller
        // Register TableViewCells with identifier "TripCell"
        tripsTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "TripCell")
        
        // Access managed object context
        let context: NSManagedObjectContext = ((UIApplication.sharedApplication().delegate as! AppDelegate?)!.myCoreData?.managedObjectContext)!
        let managedContext = context
        // Create a new fetch request with the entity description for the entity we are selecting
        let fetchRequest = NSFetchRequest(entityName: "Trip")
        var results: [Trip]?                                    // declare an array of Trips
        
        do {
            results = try managedContext.executeFetchRequest(fetchRequest) as? [Trip]
        }
        catch let error as NSError {
            print(error)
        }

        if let results = results {
            self.trips = results                                // set trips array to the results array
        }
    }

    // MARK: UITableViewDataSource
    
    // Returns the number of rows that should be in the TableView
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trips.count
    }
    
    // Sets the textLabel of each TableViewCell to the name of Trip
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TripCell")
        cell!.textLabel!.text = trips[indexPath.row].name
        
        return cell!
    }
    
    // Set segue for ShowTrip to show the YesWaypointsViewController if there
    // are waypoints for the trip or show the NoWaypointsViewController if there
    // aren't waypoints for the trip
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "ShowTrip") {
            let plannedTripViewController = segue.destinationViewController as! WaypointsViewController
            plannedTripViewController.trip = selectedTrip
        }
    }
}

extension PlannedTripsViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("selected")
        // When a trip has been selected, assign to selectedTrip
        selectedTrip = trips[indexPath.row]
        
        // Perform segue to YesWaypointsViewController
        self.performSegueWithIdentifier("ShowTrip", sender: self)
    }
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        print("done")
    }
}