//
//  LeaguesTableViewController.swift
//  YallaSport
//
//  Created by marwa on 25/04/2024.
//

import UIKit
import SDWebImage

protocol LeaguesViewProtocol {
    func showDataInUI (leagues : Leagues)
}

class LeaguesTableViewController: UITableViewController , LeaguesViewProtocol {
   
    
    var sportStr = ""
    var leaguesInfoArray : [LeagueInfo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let presenter = LeaguesPresenter(leaguesVC: self)
        presenter.getLeaguesFromNetwork(sportStr: sportStr)
        
        
        let nibCell = UINib(nibName: "LeaguesTableViewCell", bundle: nil)
        tableView.register(nibCell, forCellReuseIdentifier: "cell")
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leaguesInfoArray.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let fixtureViewController = self.storyboard?.instantiateViewController(withIdentifier: "FixtureViewController") as? FixtureViewController

        fixtureViewController?.sportType = self.sportStr
        fixtureViewController?.leagueID = String(leaguesInfoArray[indexPath.row].league_key)
        //
        DataBaseManager.addLeague(league: leaguesInfoArray[indexPath.row])
        //
        navigationController?.pushViewController(fixtureViewController!, animated: true)

        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LeaguesTableViewCell
        
        cell.leagueNameLabel.text = leaguesInfoArray[indexPath.row].league_name

        let url = URL.init(string: leaguesInfoArray[indexPath.row].league_logo ?? "fixedLogo")
        
        cell.leagueImageView.sd_setImage(with: url , placeholderImage: UIImage(named: "fixedLogo"))
        
        cell.leagueImageView.layer.cornerRadius = 70
        cell.backgroundImg.layer.borderWidth = 1
        cell.backgroundImg.layer.cornerRadius = 35
        cell.backgroundImg.layer.borderColor = UIColor(red: 21/255, green: 52/255, blue: 72/255, alpha: 1.0).cgColor


       // cell.contentView.layer.borderWidth = 1
     //   cell.contentView.layer.borderColor = UIColor.purple.cgColor


        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }

    
    
    func showDataInUI(leagues: Leagues) {
        DispatchQueue.main.async {
            self.leaguesInfoArray = leagues.result
            self.tableView.reloadData()
       }
    }

}
