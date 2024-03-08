//
//  ToiletDetailsTableViewCell.swift
//  ToiletsAppTest
//
//  Created by Yasin Akinci on 08/03/2024.
//

import UIKit

class ToiletDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var fullAddressLabel : UILabel!
    @IBOutlet weak var hourLabel : UILabel!
    @IBOutlet weak var isPRMLabel : UILabel!
    @IBOutlet weak var distanceLabel : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(fullAddress: String, hour: String, isPRM: String, distance: String) {
        fullAddressLabel.text = fullAddress
        hourLabel.text = hour
        isPRMLabel.text = isPRM
        distanceLabel.text = distance
    }
    
}
