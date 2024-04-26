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
    var test  = [1,2,3]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let presenter = LeaguesPresenter(leaguesVC: self)
        presenter.getLeaguesFromNetwork(sportStr: sportStr)
        
        
        var nibCell = UINib(nibName: "LeaguesTableViewCell", bundle: nil)
        tableView.register(nibCell, forCellReuseIdentifier: "cell")

    }
    
    func showDataInUI(leagues: Leagues) {
        print("Iam Outter here")
        DispatchQueue.main.async {
            self.leaguesInfoArray = leagues.result
            self.tableView.reloadData()
            print("showDataInUI",self.leaguesInfoArray[0].league_name)
       }
        print("Im Inner Here")
    }

    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return leaguesInfoArray.count
       // return test.count
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var fixtureViewController = self.storyboard?.instantiateViewController(withIdentifier: "FixtureViewController") as? FixtureViewController

        fixtureViewController?.sportType = self.sportStr
        fixtureViewController?.leagueID = String(leaguesInfoArray[indexPath.row].league_key)
        navigationController?.pushViewController(fixtureViewController!, animated: true)

        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LeaguesTableViewCell
        
        cell.leagueNameLabel.text = leaguesInfoArray[indexPath.row].league_name
        
        //cell.leagueNameLabel.text = "\(test[indexPath.row])"
        //cell.leagueImageView.image = ui
        //sd_setImage(with: leaguesInfoArray[indexPath.row].league_logo)
    
        let url = URL.init(string: leaguesInfoArray[indexPath.row].league_logo ?? "fixedLogo")
        
        cell.leagueImageView.sd_setImage(with: url , placeholderImage: UIImage(named: "fixedLogo"))
        
        cell.leagueImageView.layer.cornerRadius = 75
        
        cell.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        cell.contentView.layer.borderWidth = 1
        cell.contentView.layer.borderColor = UIColor.purple.cgColor


        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */



}
