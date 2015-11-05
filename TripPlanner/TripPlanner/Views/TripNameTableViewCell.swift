//
//  TripNameTableViewCell.swift
//  TripPlanner
//
//  Created by Leslie Kim on 11/3/15.
//  Copyright © 2015 Leslie Kim. All rights reserved.
//

import UIKit

protocol PlannedTripsTableViewCellDelegate: class {
    func cell(cell: TripNameTableViewCell, didSelectFollowUser tripName: String)
    func cell(cell: TripNameTableViewCell, didSelectUnfollowUser tripName: String)
}

class TripNameTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
