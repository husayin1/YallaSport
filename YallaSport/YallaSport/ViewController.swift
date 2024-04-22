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
        Network.getInstance()?.fetchDataFromNetwork(sportType: "football", apiMethodName: "Leagues")
    }
}

