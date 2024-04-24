//
//  HomeViewController.swift
//  YallaSport
//
//  Created by marwa on 24/04/2024.
//

import UIKit

class HomeViewController: UIViewController
,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate{

    var sportsArray : [String]=[]
    var leaguesArray : [Leagues] = []
    @IBOutlet weak var myCollectionViewSportsType: UICollectionView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sportsArray =   ["football","basketball","tennis","cricket"]
        self.myCollectionViewSportsType.delegate = self
        self.myCollectionViewSportsType.dataSource = self
        
        self.myCollectionViewSportsType.layer.borderWidth = 1.0
        self.myCollectionViewSportsType.layer.borderColor = UIColor.purple.cgColor
        self.myCollectionViewSportsType.layer.cornerRadius = 50
        
    }
    
 
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HomeSportsCollectionViewCell
        cell.sportImageView.image = UIImage(named: sportsArray[indexPath.item])
        cell.sportLabel.text = sportsArray[indexPath.item].capitalized
       
        return cell
    }
    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 150, height: 240)
        }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var leagueViewController = self.storyboard?.instantiateViewController(withIdentifier: "LeagueViewController") as? LeagueViewController

        leagueViewController?.sportStr = sportsArray[indexPath.item]
        navigationController?.pushViewController(leagueViewController!, animated: true)

        
        print(sportsArray[indexPath.item])
    }
}
