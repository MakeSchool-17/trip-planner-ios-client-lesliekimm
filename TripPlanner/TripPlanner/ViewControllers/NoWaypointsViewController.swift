//
//  NoWaypointsViewController.swift
//  TripPlanner
//
//  Created by Leslie Kim on 11/3/15.
//  Copyright © 2015 Leslie Kim. All rights reserved.
//

import UIKit

class NoWaypointsViewController: UIViewController {
    @IBAction func unwindToSegue(segue: UIStoryboardSegue) {
        if let identifier = segue.identifier {
            print("Identifier \(identifier)")
        }
    }

    @IBOutlet weak var infoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.infoLabel.text = "You haven't added any waypoints to your trip!"
        self.infoLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        self.infoLabel.numberOfLines = 0
        self.infoLabel.sizeToFit()
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
