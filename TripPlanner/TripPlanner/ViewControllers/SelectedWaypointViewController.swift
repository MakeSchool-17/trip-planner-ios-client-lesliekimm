//
//  SelectedWaypointViewController.swift
//  TripPlanner
//
//  Created by Leslie Kim on 11/3/15.
//  Copyright © 2015 Leslie Kim. All rights reserved.
//

import UIKit
import MapKit
class SelectedWaypointViewController: UIViewController {

    @IBOutlet weak var waypointNameLabel: UILabel!
    @IBOutlet weak var waypointMapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.waypointNameLabel.text = "San Francisco"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}