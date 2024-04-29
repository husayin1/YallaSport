//
//  FavouriteViewController.swift
//  YallaSport
//
//  Created by marwa on 27/04/2024.
//

import UIKit

class FavouriteViewController: UIViewController   {
    
    var leaguesArray = DataBaseManager.fetchLeaguesFromDB()
    var isConnected = true

    @IBOutlet weak var favTableView: UITableView!
    @IBOutlet weak var noFavImg: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.favTableView.delegate = self
        self.favTableView.dataSource = self
        let nibCell = UINib(nibName: "LeaguesTableViewCell", bundle: nil)
        favTableView.register(nibCell, forCellReuseIdentifier: "cell")

        leaguesArray = DataBaseManager.fetchLeaguesFromDB()
        if leaguesArray.count == 0{
            noFavImg.isHidden = false
            favTableView.isHidden = true
            print(" count =0")
        }
        else{
            noFavImg.isHidden = true
            favTableView.reloadData()
            favTableView.isHidden = false
            print(" count !=0")

        }
    }
    override func viewWillAppear(_ animated: Bool) {
        leaguesArray = DataBaseManager.fetchLeaguesFromDB()
        if leaguesArray.count == 0{
            noFavImg.isHidden = false
            favTableView.isHidden = true
        }
        else{
            noFavImg.isHidden = true
            favTableView.reloadData()
            favTableView.isHidden = false

        }
    }



     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }

}

extension  FavouriteViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return  leaguesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LeaguesTableViewCell
        
        cell.leagueNameLabel.text = leaguesArray[indexPath.row].league_name
        if let imageData = leaguesArray[indexPath.row].league_logo {
                        cell.leagueImageView.image = UIImage(data: imageData)
                    }
                    else {
                        cell.leagueImageView.image = UIImage(named: "errorDbImg")
                    }
        
        cell.leagueImageView.layer.cornerRadius = 70
        cell.backgroundImg.layer.borderWidth = 1
        cell.backgroundImg.layer.cornerRadius = 35
        cell.backgroundImg.layer.borderColor = UIColor(red: 0.0/255.0, green: 121.0/255.0, blue: 255.0/255.0, alpha: 1.0).cgColor

        return cell
    }
}
extension FavouriteViewController : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        leaguesArray.remove(at: indexPath.row)
        favTableView.reloadData()
        // delete from data base ya husayn
        
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(isConnected){
 
        }else{
            createAlert()
        }
    }
    
    func createAlert()
    {
        // create the alert
        let alert = UIAlertController(title: "My Title", message: "This is my message.", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
     //   alert.addAction(UIAlertAction(title: "CANCEL", style: UIAlertAction.Style.default, handler: nil))
    
        self.present(alert, animated: true, completion: nil)
    }
    

}
