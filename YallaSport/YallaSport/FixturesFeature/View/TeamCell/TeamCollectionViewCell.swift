//
//  TeamCollectionViewCell.swift
//  FixturesDemo
//
//  Created by husayn on 25/04/2024.
//

import UIKit

class TeamCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var teamName: UILabel!
    
    @IBOutlet weak var teamImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setUpTeamCell(team:TeamsResult,sportType:String){
        switch sportType{
        case "football":
            
            teamImage.sd_setImage(with: URL(string: team.team_logo ?? ""),placeholderImage: UIImage(named: "footballteamplaceholder"))
        case "basketball":
            
            teamImage.sd_setImage(with: URL(string: team.team_logo ?? ""),placeholderImage: UIImage(named: "basketballteamplaceholder"))
            
        case "tennis":
            
            teamImage.sd_setImage(with: URL(string: team.team_logo ?? ""),placeholderImage: UIImage(named: "tennisplayerplaceholder"))
            
        case "cricket":
            
            teamImage.sd_setImage(with: URL(string: team.team_logo ?? ""),placeholderImage: UIImage(named: "team"))
            
        default:
            
            teamImage.sd_setImage(with: URL(string: team.team_logo ?? ""),placeholderImage: UIImage(named: "team"))
        }
        teamName.text = team.team_name
    }

}
