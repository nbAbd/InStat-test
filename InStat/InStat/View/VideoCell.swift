//
//  VideoCell.swift
//  InStat
//
//  Created by Nurbek Abdulahatov on 19/11/21.
//

import UIKit

class VideoCell: UITableViewCell {

    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var playImageView: UIImageView!
    
    @IBOutlet weak var videoNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
