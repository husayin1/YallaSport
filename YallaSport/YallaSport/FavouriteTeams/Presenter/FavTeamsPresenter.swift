//
//  FavTeamsPresenter.swift
//  YallaSport
//
//  Created by marwa on 02/05/2024.
//

import Foundation
class FavTeamsPresenter {
    
    var favouriteTeamsVC : ViewProtocol!
    func attachViewcontroller (favouriteVC : ViewProtocol){
        self.favouriteTeamsVC = favouriteVC
    }
    
    func fetchFavouritTeamsFromDB () -> [TeamsDB]{
        return DataBaseManager.fetchTeamsFromDB()
        
    }
    
    func deleteItem(team : TeamsDB){
        DataBaseManager.deleteTeamItem(team: team)

    }
}
