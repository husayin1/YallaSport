//
//  TeamDetailsViewController.swift
//  YallaSport
//
//  Created by marwa on 26/04/2024.
//

import UIKit
import SDWebImage

class TeamDetailsViewController: UIViewController
,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate {
    
    
    @IBOutlet weak var teamImg: UIImageView!
    @IBOutlet weak var teamName: UILabel!
    var team: TeamsResult!

    
    @IBOutlet weak var coachName: UILabel!
    
    @IBOutlet weak var backgroundCoachImg: UIImageView!
    
    @IBOutlet weak var playersCollectionView: UICollectionView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        teamName.text = team.team_name
        let url = URL.init(string: team.team_logo ?? "fixedLogo")
        teamImg.sd_setImage(with: url , placeholderImage: UIImage(named: "fixedLogo"))
        teamImg.layer.cornerRadius = 75
        
        coachName.text = "Coach Name: \(team.coaches[0].coach_name!)"
        backgroundCoachImg.layer.borderWidth = 1
        backgroundCoachImg.layer.cornerRadius = 15
        backgroundCoachImg.layer.borderColor = UIColor(red: 21/255, green: 52/255, blue: 72/255, alpha: 1.0).cgColor


        
        self.playersCollectionView.delegate = self
        self.playersCollectionView.dataSource = self
        
        self.playersCollectionView.layer.borderWidth = 1.0
        self.playersCollectionView.layer.borderColor = UIColor(red: 21/255, green: 52/255, blue: 72/255, alpha: 1.0).cgColor

        self.playersCollectionView.layer.cornerRadius = 50
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return team.players.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mycell", for: indexPath) as! TeamDetailsCollectionViewCell
        
        
        let url = URL.init(string: team.players[indexPath.item].player_image ?? "fixedLogo")

        cell.playerImage.sd_setImage(with: url , placeholderImage: UIImage(named: "fixedLogo"))

        cell.playerImage.layer.cornerRadius = 75
        cell.playerImage.image = UIImage(named: team.players[indexPath.item].player_image ?? "fixedLogo")
        cell.playerName.text = team.players[indexPath.item].player_name?.capitalized

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 150, height: 240)
        }


}
