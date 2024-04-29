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
    var activityIndicator:UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let presenter = LeaguesPresenter(leaguesVC: self)
        presenter.getLeaguesFromNetwork(sportStr: sportStr)
        
        
        let nibCell = UINib(nibName: "LeaguesTableViewCell", bundle: nil)
        tableView.register(nibCell, forCellReuseIdentifier: "cell")
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = view.center
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
        activityIndicator.isHidden = false
 
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leaguesInfoArray.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if sportStr == "tennis" {
            let alert = UIAlertController(title: "Sorry!", message: "There is No Matches At The Current Time!", preferredStyle: UIAlertController.Style.alert)
            
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil))
        
            self.present(alert, animated: true, completion: nil)
        
        } else {
            
                let fixtureViewController = self.storyboard?.instantiateViewController(withIdentifier: "FixtureViewController") as? FixtureViewController

                guard let fixtureViewController = fixtureViewController else {return}
                
                
                
                fixtureViewController.sportType = self.sportStr
                fixtureViewController.leagueID = String(leaguesInfoArray[indexPath.row].league_key)
                //
                fixtureViewController.currentLeague = leaguesInfoArray[indexPath.row]
            
            navigationController?.pushViewController(fixtureViewController, animated: true)
        }
        //

        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? LeaguesTableViewCell
        guard let cell = cell else {return UITableViewCell()}
        
        
        cell.setUpLeaguesCell(league: leaguesInfoArray[indexPath.row])
        

        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }

    
    
    func showDataInUI(leagues: Leagues) {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
            self.leaguesInfoArray = leagues.result
            self.tableView.reloadData()
       }
    }

}

