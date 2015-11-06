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

class PlannedTripsViewController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var tripsTableView: UITableView!             // code connection for table view
    
    var trips = [String]()                                      // array of trip names
    
    /*
      When the Add Nav Bar Button is selected, an alert will pop up prompting the
      user to add the name for a new trip, which is stored in a table cell.
    */
    @IBAction func addTrip(sender: AnyObject) {
        // Create an alert that prompts user to enter a trip name
        let alert = UIAlertController(title: "New Trip",
                                      message: "Give this new trip a name",
                                      preferredStyle: .Alert)
        
        //
        let saveAction = UIAlertAction(title: "Save",
                                       style: .Default,
                                       handler: { (action: UIAlertAction) -> Void in
                                                    let textField = alert.textFields!.first
                self.trips.append(textField!.text!)
                self.tripsTableView.reloadData()
        })
        
        let cancelAction = UIAlertAction(title: "Cancel",
            style: .Default) { (action: UIAlertAction) -> Void in
        }
        
        alert.addTextFieldWithConfigurationHandler {
            (textField: UITextField) -> Void in
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        presentViewController(alert,
            animated: true,
            completion: nil)
    }

    /*
      A ViewController that displays the waypoints for a specific trip will use
      this segue to return to the PlannedTripsViewController.
    */
    @IBAction func backToPlannedTrips(segue: UIStoryboardSegue) {
        if let identifier = segue.identifier {
            print("Identifier \(identifier) returning to Planned Trips.")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "\"Planned Trips\""
        tripsTableView.registerClass(UITableViewCell.self,
            forCellReuseIdentifier: "TripCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: UITableViewDataSource
    func tableView(tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
            return trips.count
    }
    
    func tableView(tableView: UITableView,
        cellForRowAtIndexPath
        indexPath: NSIndexPath) -> UITableViewCell {
            
            let cell =
            tableView.dequeueReusableCellWithIdentifier("TripCell")
            
            cell!.textLabel!.text = trips[indexPath.row]
            
            return cell!
    }
}

extension PlannedTripsViewController: PlannedTripsTableViewCellDelegate {
    func cell(cell: TripNameTableViewCell, didSelectFollowUser tripName: String) {
        
    }
    func cell(cell: TripNameTableViewCell, didSelectUnfollowUser tripName: String) {
        
    }
}