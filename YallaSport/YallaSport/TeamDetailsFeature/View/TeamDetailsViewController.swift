//
//  TeamDetailsViewController.swift
//  YallaSport
//
//  Created by marwa on 26/04/2024.
//

import UIKit
import SDWebImage

class TeamDetailsViewController: UIViewController ,ViewProtocol {

        
    
    @IBOutlet weak var teamImg: UIImageView!
    @IBOutlet weak var teamName: UILabel!
    var team: TeamsResult!

    
    @IBOutlet weak var coachName: UILabel!
    
    @IBOutlet weak var backgroundCoachImg: UIImageView!
    

    @IBOutlet weak var playersTableView: UITableView!
    var presenter : TeamDetailsPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = TeamDetailsPresenter()
        self.presenter.attachViewcontroller(favouriteVC: self)

        teamName.text = team.team_name
       teamImg.sd_setImage(with: URL(string: team.team_logo ?? ""), placeholderImage: UIImage(named: "basketballplayerplaceholder"))
        teamImg.layer.cornerRadius = 75
        
        coachName.text = "Coach Name: \(team.coaches?[0].coach_name! ?? "Unkown")"
        backgroundCoachImg.layer.borderWidth = 1
        backgroundCoachImg.layer.cornerRadius = 15
        backgroundCoachImg.layer.borderColor = UIColor(red: 0.0/255.0, green: 121.0/255.0, blue: 255.0/255.0, alpha: 1.0).cgColor
        playersTableView.register(UINib(nibName: "PlayerViewCell", bundle: nil), forCellReuseIdentifier: "playerCell")
        
    }
    @IBAction func addTeam(_ sender: Any) {
        if checkIfTeamExist(){
            AlertPresenter.positiveAlert(true, title: "Don't Worry", message: "This team Already Saved!", yesButton: "Ok", noButton: nil, on: self, yesHandler: {}, noHandler: {})
        }else{
            AlertPresenter.positiveAlert(false, title: "Save Team", message: "Are you sure you want to save this team ?.", yesButton: "Save", noButton: "Cancel", on: self, yesHandler: {
                
                self.presenter.addTeamInDB(team: self.team)
            }, noHandler: {})
        }
    }
    
    func bindWithUI() {
        print("add team done")
    }
    func checkIfTeamExist()->Bool{
        var teamAlreadyExists = false
        let fetchedTeams = presenter.fetchTeamsSaved()
        for item in fetchedTeams {
            if Int(item.team_key ?? 0) == team.team_key {
                teamAlreadyExists = true
                break
            }
        }
        return teamAlreadyExists
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "playerCell", for: indexPath) as? PlayerViewCell
        guard let cell = cell else {return UITableViewCell()}
        cell.setUpPlayerCell(player: (team.players?[indexPath.row]))
        return cell
    }
}
