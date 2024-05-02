//
//  FavouritePresenter.swift
//  YallaSport
//
//  Created by marwa on 30/04/2024.
//

import Foundation
class FavouritePresenter {
    
    var favouriteVC : ViewProtocol!
    func attachViewcontroller (favouriteVC : ViewProtocol){
        self.favouriteVC = favouriteVC
    }
    
    func fetchFavouritsFromDB () -> [League]{
        return DataBaseManager.fetchLeaguesFromDB()
        
    }
    
    func deleteItem(league : League){
        DataBaseManager.deleteLeagueItem(league: league)
        
    }
}
