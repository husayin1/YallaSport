//
//  FavouriteViewController.swift
//  YallaSport
//
//  Created by marwa on 27/04/2024.
//

import UIKit

class FavouriteViewController: UIViewController {
    
    

    @IBOutlet weak var noFavImg: UIImageView!
    
    
    @IBOutlet weak var leagueName: UILabel!
    @IBOutlet weak var teamImg: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

       var l = DataBaseManager.fetchLeaguesFromDB()
        if l.count == 0{
            
        }
        else{
            noFavImg.isHidden = true
            leagueName.text = l[0].league_name
            if let imageData = l[0].league_logo {
                teamImg.image = UIImage(data: imageData)
            }
            else {
                teamImg.image = UIImage(named: "errorDbImg")
            }
        }
    }
    


}
