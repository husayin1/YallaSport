//
//  HomeViewController.swift
//  YallaSport
//
//  Created by marwa on 24/04/2024.
//

import UIKit

protocol HomeViewProtocol {
    func showAlert()
    func ContinueProcess(indexPath:IndexPath)
    
}
class HomeViewController: UIViewController,HomeViewProtocol{
    
    

    var sportsArray : [String]=[]
    var leaguesArray : [Leagues] = []
    var presenter:HomePresenter?
    @IBOutlet weak var myCollectionViewSportsType: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = HomePresenter(homeVc: self)
        sportsArray =   ["football","basketball","tennis","cricket"]
        self.myCollectionViewSportsType.delegate = self
        self.myCollectionViewSportsType.dataSource = self
        
        self.myCollectionViewSportsType.layer.borderWidth = 1.0
        self.myCollectionViewSportsType.layer.borderColor = UIColor(red: 0.0/255.0, green: 121.0/255.0, blue: 255.0/255.0, alpha: 1.0).cgColor
        //UIColor(red: 21/255, green: 52/255, blue: 72/255, alpha: 1.0).cgColor

        self.myCollectionViewSportsType.layer.cornerRadius = 50
        
    }
    
    func showAlert() {
        AlertPresenter.positiveAlert(true, title:  "Sorry!", message: "It seems you are not connected to the internet. Please check your network connection and try again.", yesButton: "OK", noButton: nil, on: self, yesHandler: {}, noHandler: {})
       

//        let alert = UIAlertController(title: "Sorry!", message: "It seems you are not connected to the internet. Please check your network connection and try again.", preferredStyle: UIAlertController.Style.alert)
        
        
//        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil))
    
//        self.present(alert, animated: true, completion: nil)
    
    }
    
    func ContinueProcess(indexPath :IndexPath) {
        let leagueViewController = self.storyboard?.instantiateViewController(withIdentifier: "LeaguesTableViewController") as? LeaguesTableViewController

        guard let leagueViewController = leagueViewController else {return}
      
        
        leagueViewController.sportStr = sportsArray[indexPath.item]
        navigationController?.pushViewController(leagueViewController, animated: true)
    }
    
}
extension HomeViewController:UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.checkIfUserCanContinue(indexPath: indexPath)
    }
    
    
}

extension HomeViewController:UICollectionViewDataSource{
    

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? HomeSportsCollectionViewCell
        guard let cell = cell else {return UICollectionViewCell()}
        cell.setUpHomeSportsCell(sport: sportsArray[indexPath.item])
        return cell
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    
}

extension HomeViewController:UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 150, height: 240)
        }
}
