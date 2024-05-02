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

class LeaguesTableViewController: UITableViewController , LeaguesViewProtocol ,UISearchResultsUpdating{
    var sportStr = ""
    var leaguesInfoArray : [LeagueInfo] = []
    var searchController = UISearchController(searchResultsController: nil)
    var filteredLeagues:[LeagueInfo]?
    var activityIndicator:UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search For League"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        
        let presenter = LeaguesPresenter(leaguesVC: self)
        presenter.getLeaguesFromNetwork(sportStr: sportStr)
        
        
        let nibCell = UINib(nibName: "LeaguesTableViewCell", bundle: nil)
        tableView.register(nibCell, forCellReuseIdentifier: "cell")
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = view.center
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
        activityIndicator.isHidden = false
        activityIndicator.color = .blue
 
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredLeagues?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if sportStr == "tennis" {
            AlertPresenter.positiveAlert(true, title: "Sorry!", message: "There is No Matches At The Current Time!", yesButton: "OK", noButton: "Cancel", on: self, yesHandler: {}, noHandler: {})
        } else {
            
                let fixtureViewController = self.storyboard?.instantiateViewController(withIdentifier: "FixtureViewController") as? FixtureViewController

                guard let fixtureViewController = fixtureViewController else {return}
                
                
                
                fixtureViewController.sportType = self.sportStr
            fixtureViewController.leagueID = String(Int(filteredLeagues?[indexPath.row].league_key ?? 0))
                //
            fixtureViewController.currentLeague = filteredLeagues?[indexPath.row]
            
            navigationController?.pushViewController(fixtureViewController, animated: true)
        }
        //

        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? LeaguesTableViewCell
        guard let cell = cell else {return UITableViewCell()}
        
        
        cell.setUpLeaguesCell(league: (filteredLeagues?[indexPath.row])!)
        

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
            self.filteredLeagues = self.leaguesInfoArray
            self.tableView.reloadData()
       }
    }
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines), !searchText.isEmpty {
            filteredLeagues = leaguesInfoArray.filter{
                league in
                return league.league_name.localizedCaseInsensitiveContains(searchText)
            }
        }else{
            filteredLeagues = leaguesInfoArray
        }
        self.tableView.reloadData()
    }

}

