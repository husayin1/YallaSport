//
//  LeaguesTableViewCell.swift
//  YallaSport
//
//  Created by marwa on 25/04/2024.
//

import UIKit

class LeaguesTableViewCell: UITableViewCell {

    @IBOutlet weak var leagueImageView: UIImageView!
    @IBOutlet weak var leagueNameLabel: UILabel!
    


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
