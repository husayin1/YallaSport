//
//  HomePresenter.swift
//  YallaSport
//
//  Created by husayn on 29/04/2024.
//

import Foundation


protocol HomePresenterProtocol{
    func checkIfUserCanContinue(indexPath:IndexPath)
    func didSelectSport(indexPath:IndexPath)->String
}

class HomePresenter:HomePresenterProtocol{
    private var sportsArray : [String] =   ["football","basketball","tennis","cricket"]
    private var leaguesArray : [Leagues] = []
    weak var homeVc : HomeViewProtocol?
    
    init(homeVc: HomeViewProtocol) {
        self.homeVc = homeVc
        self.homeVc?.didLoadView()
    }
    
    func checkIfUserCanContinue(indexPath:IndexPath) {
        if NetworkManager.networkM.IsInternetAvailable(){
            homeVc?.continueProcess(sport: sportsArray[indexPath.row])
        }else{
            homeVc?.showAlert()
        }
    }
    func didSelectSport(indexPath:IndexPath)->String{
        return sportsArray[indexPath.row]
    }
    
    deinit {
        print("HomePresenter Deinit")
    }
    
}
