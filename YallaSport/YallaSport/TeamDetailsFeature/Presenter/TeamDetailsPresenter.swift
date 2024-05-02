//
//  TeamDetailsPresenter.swift
//  YallaSport
//
//  Created by marwa on 27/04/2024.
//

import Foundation
class TeamDetailsPresenter {
    
    var favouriteTeamsVC : ViewProtocol!
    func attachViewcontroller (favouriteVC : ViewProtocol){
        self.favouriteTeamsVC = favouriteVC
    }
    
    func addTeamInDB (team : TeamsResult){
        DataBaseManager.addTeam(team: team)
        
    }
    
}
