//
//  PlannedTripsViewController.swift
//  TripPlanner
//
//  Created by Leslie Kim on 11/3/15.
//  Copyright © 2015 Leslie Kim. All rights reserved.
//

// NOTES: http://www.raywenderlich.com/115695/getting-started-with-core-data-tutorial
// for using alerts to save new trip names


import UIKit

class PlannedTripsViewController: UIViewController, UITableViewDataSource {
    @IBAction func unwindToSegue(segue: UIStoryboardSegue) {
        if let identifier = segue.identifier {
            print("Identifier \(identifier)")
        }
    }
    
    @IBOutlet weak var tripsTableView: UITableView!
    @IBAction func addTrip(sender: AnyObject) {
        let alert = UIAlertController(title: "New Trip",
            message: "Add a new trip",
            preferredStyle: .Alert)
        
        let saveAction = UIAlertAction(title: "Save",
            style: .Default,
            handler: { (action:UIAlertAction) -> Void in
                
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
    
    var trips = [String]()
    
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