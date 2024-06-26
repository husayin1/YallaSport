//
//  HomeSportsCollectionViewCell.swift
//  YallaSport
//
//  Created by marwa on 24/04/2024.
//

import UIKit

class HomeSportsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var sportLabel: UILabel!
    
    @IBOutlet weak var sportImageView: UIImageView!
        
    func setUpHomeSportsCell(sport:String){
        self.sportLabel.text = sport.capitalized
        self.sportImageView.image = UIImage(named: sport)
    }
}
