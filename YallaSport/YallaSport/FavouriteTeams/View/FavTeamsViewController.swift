//
//  FavTeamsViewController.swift
//  YallaSport
//
//  Created by marwa on 02/05/2024.
//

import UIKit

class FavTeamsViewController: UIViewController , ViewProtocol {
    
    @IBOutlet weak var noFavImg: UIImageView!
    var teamsArray : [TeamsDB]!
    var favPresenter : FavTeamsPresenter!

    @IBOutlet weak var favTeamsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.favTeamsTableView.delegate = self
        self.favTeamsTableView.dataSource = self
        //teamsArray = DataBaseManager.fetchTeamsFromDB()
       
        
        favPresenter = FavTeamsPresenter()
        self.favPresenter.attachViewcontroller(favouriteVC: self)
        teamsArray = favPresenter.fetchFavouritTeamsFromDB()
        favTeamsTableView.reloadData()

        let nibCell = UINib(nibName: "LeaguesTableViewCell", bundle: nil)
        favTeamsTableView.register(nibCell, forCellReuseIdentifier: "cell")
        showNoFavImg()

    }
    
    func bindWithUI() {
        DispatchQueue.main.async {
            self.teamsArray = self.favPresenter.fetchFavouritTeamsFromDB()
            self.favTeamsTableView.reloadData()
            
        }
    }
    
   
    override func viewWillAppear(_ animated: Bool) {
        teamsArray = favPresenter.fetchFavouritTeamsFromDB()
        favTeamsTableView.reloadData()
        showNoFavImg()

    }
    
    

    
    
}




extension  FavTeamsViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  teamsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LeaguesTableViewCell
        
        cell.leagueNameLabel.text = teamsArray[indexPath.row].team_name
        if let imageData = teamsArray[indexPath.row].team_logo {
            cell.leagueImageView.image = UIImage(data: imageData)
        }
        else {
            cell.leagueImageView.image = UIImage(named: "fixedLogo")
        }
        
        cell.leagueImageView.layer.cornerRadius = 70
        cell.backgroundImg.layer.borderWidth = 1
        cell.backgroundImg.layer.cornerRadius = 35
        cell.backgroundImg.layer.borderColor = UIColor(red: 0.0/255.0, green: 121.0/255.0, blue: 255.0/255.0, alpha: 1.0).cgColor
        
        return cell
    }
}




extension FavTeamsViewController : UITableViewDelegate{
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
     
        
        AlertPresenter.negativeAlert(false, title: "Delete League", message: "Are you sure you want to delete league ? ", yesButton: "YES", noButton: "NO", on: self, yesHandler: {
            self.favPresenter.deleteItem(team: self.teamsArray[indexPath.row])
            self.teamsArray = self.favPresenter.fetchFavouritTeamsFromDB()
            self.favTeamsTableView.reloadData()
            self.showNoFavImg()
           
            
        }, noHandler: {
            
        })
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       /*
        Network.fetchOneTeamFromNetwork(sportType: "football", teamId: "\(teamsArray[indexPath.row].team_key)") { res in
            switch res {
            case .success(let teams) :
                let teamViewController = self.storyboard?.instantiateViewController(withIdentifier: "TeamDetailsViewController") as? TeamDetailsViewController
                teamViewController?.team = teams.result![0]
                self.navigationController?.pushViewController(teamViewController!, animated: true)
            case .failure(_):
                print("erooooooor")
            }
        }
        //teamsArray[indexPath.row]

        
        /* if NetworkManager.networkM.IsInternetAvailable() {
          
             let fixtureViewController = self.storyboard?.instantiateViewController(withIdentifier: "FixtureViewController") as? FixtureViewController
             
             guard let fixtureViewController = fixtureViewController else {return}
             
             
             fixtureViewController.sportType = "football"
             fixtureViewController.leagueID =
             String(describing: Int(truncating: teamsArray[indexPath.row].league_key ?? 175))
             let league : LeagueInfo = LeagueInfo(league_key: Int(teamsArray[indexPath.row].league_key ?? 0), league_name: teamsArray[indexPath.row].league_name ?? "Unkown")
             fixtureViewController.currentLeague = league
             
             navigationController?.pushViewController(fixtureViewController, animated: true)
             }else{
             AlertPresenter.positiveAlert(false, title:  "Sorr!", message: "It seems you are not connected to the internet. Please check your network connection and try again.", yesButton: "OK", noButton: nil, on: self, yesHandler: {}, noHandler: {})
             
             
        }*/
        */
    }
    func showNoFavImg (){
        if teamsArray.count == 0{
             noFavImg.isHidden = false
             favTeamsTableView.isHidden = true
             print(" count =0")
         }
         else{
             noFavImg.isHidden = true
             favTeamsTableView.reloadData()
             favTeamsTableView.isHidden = false
             print(" count !=0")
             
         }
    }
}

