//
//  FavoriteListingCell.swift
//  FavoriteListingDemo
//
//  Created by Admin on 23/02/22.
//

import UIKit

class FavoriteListingCell: UITableViewCell {

    @IBOutlet var lblSegmentName : UILabel!
    @IBOutlet var lblPlatformName : UILabel!
    @IBOutlet var lblClusterName : UILabel!
    @IBOutlet var lblSiteName : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        lblSegmentName.text = "";
        lblPlatformName.text = "";
        lblClusterName.text = "";
        lblSiteName.text = "";
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
