//
//  YesWaypointsViewController.swift
//  TripPlanner
//
//  Created by Leslie Kim on 11/3/15.
//  Copyright © 2015 Leslie Kim. All rights reserved.
//

import UIKit
import CoreData

class WaypointsViewController: UIViewController, UITableViewDataSource {
    var trip: Trip?
    var waypoints = [Waypoint]()
    var selectedWaypoint: Waypoint?
    @IBOutlet weak var waypointsTableView: UITableView!
    
    @IBAction func unwindToSegue(segue: UIStoryboardSegue) {
        if let identifier = segue.identifier {
            print("Identifier \(identifier)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //self.infoLabel.text = "You haven't added any waypoints to your trip!"
        //self.infoLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        //self.infoLabel.numberOfLines = 0
        //self.infoLabel.sizeToFit()


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return waypoints.count
    }
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("WaypointCell")
        cell!.textLabel!.text = waypoints[indexPath.row].name
        
        return cell!
    }
}


extension WaypointsViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("selected waypoint")
        // When a waypoint has been selected, assign to selectedWaypoint
        selectedWaypoint = waypoints[indexPath.row]
        
        // Perform segue to SelectedWaypointViewController
        self.performSegueWithIdentifier("ShowWaypoint", sender: self)
    }
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        print("done")
    }
}