//
//  LeaguesPresenter.swift
//  YallaSport
//
//  Created by marwa on 25/04/2024.
//

import Foundation

protocol LeaguePresenterProtocol{
    func viewDidLoad()
    func didSelectIndexPath(idx:IndexPath)
    func search(searchText:String)
    func setUpCellItem(index:IndexPath)->LeagueInfo
    func setUpNumberOfRows()->Int
}
class LeaguesPresenter:LeaguePresenterProtocol {
    private weak var leaguesVC : LeaguesViewProtocol?
    private var leaguesInfoArray : [LeagueInfo] = []
    private var filteredLeagues:[LeagueInfo] = []
    private var sportStr:String
    
    init(leaguesVC: LeaguesViewProtocol, sportString: String) {
        self.leaguesVC = leaguesVC
        self.sportStr = sportString
    }
    
    func viewDidLoad(){
        self.leaguesVC?.setupUI()
        self.getLeaguesFromNetwork()
    }
    
    func didSelectIndexPath(idx:IndexPath){
        if sportStr == "tennis" {
            self.leaguesVC?.showAlert()
        }else{
            self.leaguesVC?.navigateToFixtures(sport: sportStr, leagueId: filteredLeagues[idx.row].league_key, leagueItem: (filteredLeagues[idx.row]))
        }
        
    }
    
    func search(searchText:String){
        if  searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == false {
            filteredLeagues = leaguesInfoArray.filter{
                league in
                return league.league_name.localizedStandardContains(searchText)
            }
        }else{
            filteredLeagues = leaguesInfoArray
        }
        
        self.leaguesVC?.reloadTable()
    }
    
    deinit {
        print("League Presenter deinit")
    }
    
    func setUpCellItem(index:IndexPath)->LeagueInfo{
        return filteredLeagues[index.row]
    }
    
    func setUpNumberOfRows()->Int{
        return filteredLeagues.count
    }
    
    
    func getLeaguesFromNetwork (){
        Network.fetchLeagues(sportType: sportStr){[weak self] result in
            self?.leaguesVC?.showIndicator()
            switch result {
            case .success(let leagues) :
                self?.leaguesInfoArray = leagues.result
                self?.filteredLeagues = self?.leaguesInfoArray ?? []
                self?.leaguesVC?.reloadTable()
                self?.leaguesVC?.hideIndiator()
            case .failure(let error) :
                print("error : ",error)
                self?.leaguesVC?.showAlert()
            }
        }
    }
}

