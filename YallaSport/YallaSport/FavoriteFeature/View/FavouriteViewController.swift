//
//  FavouriteViewController.swift
//  YallaSport
//
//  Created by marwa on 27/04/2024.
//

import UIKit

class FavouriteViewController: UIViewController   {
    
    var leaguesArray = DataBaseManager.fetchLeaguesFromDB()
    var isConnected = true
    
    @IBOutlet weak var favTableView: UITableView!
    @IBOutlet weak var noFavImg: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.favTableView.delegate = self
        self.favTableView.dataSource = self
        let nibCell = UINib(nibName: "LeaguesTableViewCell", bundle: nil)
        favTableView.register(nibCell, forCellReuseIdentifier: "cell")
        
        leaguesArray = DataBaseManager.fetchLeaguesFromDB()
        if leaguesArray.count == 0{
            noFavImg.isHidden = false
            favTableView.isHidden = true
            print(" count =0")
        }
        else{
            noFavImg.isHidden = true
            favTableView.reloadData()
            favTableView.isHidden = false
            print(" count !=0")
            
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        leaguesArray = DataBaseManager.fetchLeaguesFromDB()
        if leaguesArray.count == 0{
            noFavImg.isHidden = false
            favTableView.isHidden = true
        }
        else{
            noFavImg.isHidden = true
            favTableView.reloadData()
            favTableView.isHidden = false
            
        }
    }
    
    
    @IBAction func clearLeagues(_ sender: Any) {
        if leaguesArray.count > 0 {
            
            print("Clear Now")
            AlertPresenter.negativeAlert(false, title: "Clear All Leagues", message: "Are you sure you want to clear your saved list ?", yesButton: "Sure", noButton: "Cancel", on: self, yesHandler: {
                
                DataBaseManager.deleteDataFromCoreData()
                self.leaguesArray = DataBaseManager.fetchLeaguesFromDB()
                self.favTableView.reloadData()
                self.viewWillAppear(true)
            }, noHandler: {})
        }
       
    }
    
    
}

extension  FavouriteViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  leaguesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LeaguesTableViewCell
        
        cell.leagueNameLabel.text = leaguesArray[indexPath.row].league_name
        if let imageData = leaguesArray[indexPath.row].league_logo {
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
extension FavouriteViewController : UITableViewDelegate{
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        AlertPresenter.negativeAlert(false, title: "Delete League", message: "Are you sure you want to delete league ? ", yesButton: "YES", noButton: "NO", on: self, yesHandler: {
            DataBaseManager.deleteLeagueItem(league: (self.leaguesArray[indexPath.row]))
            
            self.leaguesArray = DataBaseManager.fetchLeaguesFromDB()
            self.favTableView.reloadData()
            if(self.leaguesArray.count == 0) {
                self.viewWillAppear(true)
            }
            
        }, noHandler: {
            
        })
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if NetworkManager.networkM.IsInternetAvailable() {
            
                let fixtureViewController = self.storyboard?.instantiateViewController(withIdentifier: "FixtureViewController") as? FixtureViewController

                guard let fixtureViewController = fixtureViewController else {return}
                
                
                fixtureViewController.sportType = "football"
                fixtureViewController.leagueID =
            String(describing: Int(truncating: leaguesArray[indexPath.row].league_key ?? 175))
            let league : LeagueInfo = LeagueInfo(league_key: Int(leaguesArray[indexPath.row].league_key ?? 0), league_name: leaguesArray[indexPath.row].league_name ?? "Unkown")
                fixtureViewController.currentLeague = league
            
            navigationController?.pushViewController(fixtureViewController, animated: true)
        }else{
            AlertPresenter.positiveAlert(false, title:  "Sorr!", message: "It seems you are not connected to the internet. Please check your network connection and try again.", yesButton: "OK", noButton: nil, on: self, yesHandler: {}, noHandler: {})
           
        }
    }
    
    
    
}
