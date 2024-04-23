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
        Network.getInstance()?.fetchLeagues(sportType: "football"){
            [weak self] data in
            guard let self = self else {return}
            switch data {
            case .success(let response):
                print(response.result[0].league_key)
                print(response.success)
            case .failure(let err):
                print(err)
                print(err.localizedDescription)
            }
        }
    }
    
}

