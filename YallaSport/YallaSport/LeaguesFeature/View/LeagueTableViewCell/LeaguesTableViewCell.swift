//
//  LeaguesTableViewCell.swift
//  YallaSport
//
//  Created by marwa on 25/04/2024.
//

import UIKit

class LeaguesTableViewCell: UITableViewCell {
    @IBOutlet weak var backgroundImg: UIImageView!
    
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
    
    func setUpLeaguesCell(league:LeagueInfo){
        leagueNameLabel.text = league.league_name
        leagueImageView.sd_setImage(with: URL(string: league.league_logo ?? ""),placeholderImage: UIImage(named: "fixedLogo"))
        leagueImageView.layer.cornerRadius = 24
        backgroundImg.layer.borderWidth = 1
        backgroundImg.layer.cornerRadius = 35
        backgroundImg.layer.borderColor = UIColor(red: 0.0/255.0, green: 121.0/255.0, blue: 255.0/255.0, alpha: 1.0).cgColor

    }
    
}
