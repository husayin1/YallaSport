//
//  PlayerViewCell.swift
//  YallaSport
//
//  Created by husayn on 28/04/2024.
//

import UIKit

class PlayerViewCell: UITableViewCell {

    @IBOutlet weak var playerImage: UIImageView!
    
    @IBOutlet weak var playerName: UILabel!
    
    
    
    @IBOutlet weak var playerNo: UILabel!
    
    
    @IBOutlet weak var playerPosition: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
