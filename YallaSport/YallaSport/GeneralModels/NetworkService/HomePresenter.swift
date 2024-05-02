//
//  HomePresenter.swift
//  YallaSport
//
//  Created by husayn on 29/04/2024.
//

import Foundation
class HomePresenter{
    
    var homeVc : HomeViewProtocol?
    
    init(homeVc: HomeViewProtocol) {
        self.homeVc = homeVc
    }
    
    func checkIfUserCanContinue(indexPath:IndexPath) {
        if NetworkManager.networkM.IsInternetAvailable(){
            homeVc?.ContinueProcess(indexPath: indexPath)
        }else{
            homeVc?.showAlert()
        }
    }
    
}
