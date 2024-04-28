//
//  LeaguesPresenter.swift
//  YallaSport
//
//  Created by marwa on 25/04/2024.
//

import Foundation
class LeaguesPresenter {
    var leaguesVC : LeaguesViewProtocol?
    
    init(leaguesVC: LeaguesViewProtocol) {
        self.leaguesVC = leaguesVC
    }
    
    
    func getLeaguesFromNetwork (sportStr:String){
        Network.fetchLeagues(sportType: sportStr){ result in
            switch result {
            case .success(let leagues) :
                self.leaguesVC?.showDataInUI(leagues: leagues)
            case .failure(let error) :
                print("error : ",error)
            }
        }
    }
}

