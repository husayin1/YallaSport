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
//        Network.getInstance()?.fetchDataFromNetwork(sportType: "football", apiMethodName: "Leagues")
//
//
        Network.getInstance()?.fetchLeagues(sport: "football"){[weak self] resulte in
                    
                    guard let self = self else {return}
                    switch resulte {
                        
                    case .success(let done):
                        print("el hussin hena ")
                        print(done.result[0].leagueName)
                    case .failure(let err):
                        print(err.localizedDescription)
                        print(err)
                    }
                    
                }
            }
    
}

