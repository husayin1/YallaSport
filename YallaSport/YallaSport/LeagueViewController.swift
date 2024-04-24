//
//  LeagueViewController.swift
//  YallaSport
//
//  Created by marwa on 24/04/2024.
//

import UIKit

class LeagueViewController: UIViewController {

    var sportStr = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Network.getInstance()?.fetchLeagues(sportType: sportStr, completionHandler: { [weak self] result in
            switch result {
            case .success(let leagues) :
                DispatchQueue.main.async {
                  //  self?.myLabel.text = leagues.result[0].league_name
                    print(leagues.result[0].league_name)
                }
                
            case .failure(let error) :
                print("error : ",error)
            }

        })
        
        
    }
    

}
