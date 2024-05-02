//
//  ViewController.swift
//  YallaSport
//
//  Created by husayn on 22/04/2024.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        Network.getInstance()?.fetchLeagues(sportType: "football"){
//            [weak self] data in
//            guard let self = self else {return}
//            switch data {
//            case .success(let response):
//                print(response.result[0].league_key)
//                print(response.success)
//            case .failure(let err):
//                print(err)
//                print(err.localizedDescription)
//            }
//        }
        
        
        /*         //
         Network.fetchTeamsFromNetwork(leagueId: 3) {res in
             switch res{
             case .success(let teams) : print("home fetchTeamsFromNetwork",teams.result[0].team_name)
             case .failure(_):
                 print("error2")
             }
         }
         */
    }
    
}

