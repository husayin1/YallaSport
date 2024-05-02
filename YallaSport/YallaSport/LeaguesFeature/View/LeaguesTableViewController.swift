//
//  LeaguesTableViewController.swift
//  YallaSport
//
//  Created by marwa on 25/04/2024.
//

import UIKit
import SDWebImage

protocol LeaguesViewProtocol:AnyObject {
    func setupUI()
    func reloadTable()
    func showIndicator()
    func hideIndiator()
    func showAlert()
    func navigateToFixtures(sport:String,leagueId:Int,leagueItem:LeagueInfo)
}

class LeaguesTableViewController: UITableViewController {
    private var searchController = UISearchController(searchResultsController: nil)
    private var activityIndicator:UIActivityIndicatorView?
    
    var presenter:LeaguePresenterProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        //presenter
        presenter?.viewDidLoad()
        
    }
    
    deinit{
        print("Deinit please")
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.setUpNumberOfRows() ?? 0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectIndexPath(idx: indexPath)
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? LeaguesTableViewCell
        guard let cell = cell else {return UITableViewCell()}
        
        
        cell.setUpLeaguesCell(league: (presenter?.setUpCellItem(index: indexPath))!)
        
        
        return cell
    }
    
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
}


extension LeaguesTableViewController:UISearchResultsUpdating{
    
    func updateSearchResults(for searchController: UISearchController) {
        DispatchQueue.main.async {
            [weak self] in
            if let searchText = searchController.searchBar.text{
                self?.presenter?.search(searchText: searchText)
            }
        }
    }
}


extension LeaguesTableViewController: LeaguesViewProtocol{
    
    func setupUI() {
        setUpCell()
        setUpSearch()
    }
    
    func showIndicator(){
        //        DispatchQueue.main.async {[weak self] in
        self.activityIndicator = UIActivityIndicatorView(style: .large)
        self.activityIndicator?.center = (self.view?.center)!
        self.activityIndicator?.startAnimating()
        self.activityIndicator?.isHidden = false
        self.activityIndicator?.color = .blue
        self.view.addSubview(self.activityIndicator!)
        //        }
    }
    func hideIndiator() {
        DispatchQueue.main.async {[weak self] in
            self?.activityIndicator?.stopAnimating()
            self?.activityIndicator?.isHidden = true
        }
    }
    
    func showAlert(){
        DispatchQueue.main.async {[weak self] in
            AlertPresenter.positiveAlert(true, title: "Sorry!", message: "There is No Matches At The Current Time!", yesButton: "OK", noButton: "Cancel", on: self, yesHandler: {}, noHandler: {})
        }
        
    }
    
    func reloadTable() {
        DispatchQueue.main.async {
            [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    func navigateToFixtures(sport:String,leagueId:Int,leagueItem:LeagueInfo) {
        
        let fixtureViewController = self.storyboard?.instantiateViewController(withIdentifier: "FixtureViewController") as? FixtureViewController
        
        guard let fixtureViewController = fixtureViewController else {return}
        
        
        fixtureViewController.sportType = sport
        fixtureViewController.leagueID = String(Int(leagueId))
        fixtureViewController.currentLeague = leagueItem
        
        navigationController?.pushViewController(fixtureViewController, animated: true)
    }
}


private extension LeaguesTableViewController {
    func setUpSearch(){
        //search
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search For League"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    func setUpCell(){
        //nibFile
        let nibCell = UINib(nibName: "LeaguesTableViewCell", bundle: nil)
        tableView.register(nibCell, forCellReuseIdentifier: "cell")
    }
}
