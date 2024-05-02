//
//  HomeViewController.swift
//  YallaSport
//
//  Created by marwa on 24/04/2024.
//

import UIKit

protocol HomeViewProtocol :AnyObject{
    func didLoadView()
    func showAlert()
    func continueProcess(sport:String)
    
}

class HomeViewController: UIViewController{
    var presenter:HomePresenterProtocol?
    @IBOutlet weak var myCollectionViewSportsType: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //presenter
        presenter = HomePresenter(homeVc: self)
        
    }
    deinit {
        print("HomeController Deinit")
    }
    
    
}
extension HomeViewController:HomeViewProtocol{
    func continueProcess(sport: String) {
        let leagueViewController = self.storyboard?.instantiateViewController(withIdentifier: "LeaguesTableViewController") as? LeaguesTableViewController
        
        guard let leagueViewController = leagueViewController else {return}
        leagueViewController.presenter = LeaguesPresenter(leaguesVC: leagueViewController, sportString: sport)
        navigationController?.pushViewController(leagueViewController, animated: true)
    }
    
    func didLoadView() {
        self.myCollectionViewSportsType.delegate = self
        self.myCollectionViewSportsType.dataSource = self
        
        self.myCollectionViewSportsType.layer.borderWidth = 1.0
        self.myCollectionViewSportsType.layer.borderColor = UIColor(red: 0.0/255.0, green: 121.0/255.0, blue: 255.0/255.0, alpha: 1.0).cgColor
        
        self.myCollectionViewSportsType.layer.cornerRadius = 50
        
    }
    
    func showAlert() {
        DispatchQueue.main.async {
            [weak self] in
            AlertPresenter.positiveAlert(true, title:  "Sorry!", message: "It seems you are not connected to the internet. Please check your network connection and try again.", yesButton: "OK", noButton: nil, on: self, yesHandler: {}, noHandler: {})
        }
        
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
        
        cell.setUpHomeSportsCell(sport: presenter?.didSelectSport(indexPath: indexPath) ?? "football")
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
