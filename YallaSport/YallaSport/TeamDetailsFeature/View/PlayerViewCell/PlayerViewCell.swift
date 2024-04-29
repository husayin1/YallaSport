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
    func setUpPlayerCell(player:Players?){
        guard let player = player else {return}
        playerName.text = player.player_name
        playerImage.sd_setImage(with: URL(string: player.player_image ?? ""),placeholderImage: UIImage(named: "basketballplayerplaceholder"))
        playerNo.text = player.player_number
        playerPosition.text = player.player_type
    }
    
    
}
