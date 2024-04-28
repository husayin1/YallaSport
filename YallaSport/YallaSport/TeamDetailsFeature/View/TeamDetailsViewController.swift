//
//  TeamDetailsViewController.swift
//  YallaSport
//
//  Created by marwa on 26/04/2024.
//

import UIKit
import SDWebImage

class TeamDetailsViewController: UIViewController {
    
    
    @IBOutlet weak var teamImg: UIImageView!
    @IBOutlet weak var teamName: UILabel!
    var team: TeamsResult!

    
    @IBOutlet weak var coachName: UILabel!
    
    @IBOutlet weak var backgroundCoachImg: UIImageView!
    

    @IBOutlet weak var playersTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        teamName.text = team.team_name
//        let url = URL.init(string: team.team_logo ?? "fixedLogo")
//        teamImg.sd_setImage(with: url , placeholderImage: UIImage(named: "fixedLogo"))
//
        teamImg.sd_setImage(with: URL(string: team.team_logo ?? ""), placeholderImage: UIImage(named: "car"))
        teamImg.layer.cornerRadius = 75
        
        coachName.text = "Coach Name: \(team.coaches?[0].coach_name! ?? "Unkown")"
        backgroundCoachImg.layer.borderWidth = 1
        backgroundCoachImg.layer.cornerRadius = 15
        backgroundCoachImg.layer.borderColor = UIColor(red: 21/255, green: 52/255, blue: 72/255, alpha: 1.0).cgColor
        playersTableView.register(UINib(nibName: "PlayerViewCell", bundle: nil), forCellReuseIdentifier: "playerCell")
        
    }


}


extension TeamDetailsViewController :UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
extension TeamDetailsViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return team.players?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "playerCell", for: indexPath) as! PlayerViewCell
        cell.playerName.text = team.players?[indexPath.row].player_name
        cell.playerImage.sd_setImage(with: URL(string: team.players?[indexPath.row].player_image ?? ""), placeholderImage: UIImage(named: "car"))
        cell.playerNo.text = team.players?[indexPath.row].player_number
        cell.playerPosition.text = team.players?[indexPath.row].player_type
//        cell.backgroundColor = UIColor(ciColor: .blue)
        return cell
    }
}
