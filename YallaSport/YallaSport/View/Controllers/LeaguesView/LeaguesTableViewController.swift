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
        DispatchQueue.main.async {
           
            print("showDataInUI",leagues.result[0].league_name)
            self.leaguesInfoArray = leagues.result
       }
    }

    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return leaguesInfoArray.count
       // return test.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LeaguesTableViewCell
        cell.leagueNameLabel.text = leaguesInfoArray[indexPath.row].league_name

        let url = URL.init(string: leaguesInfoArray[indexPath.row].league_logo!)
        cell.leagueImageView.sd_setImage(with: url , placeholderImage: nil)
        cell.layer.borderColor = UIColor.purple.cgColor

        return cell
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
