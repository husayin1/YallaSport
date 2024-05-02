//
//  FixtureViewController.swift
//  YallaSport
//
//  Created by husayn on 26/04/2024.
//

import UIKit
protocol FixtureProtocol{
    func showFixtures(fixtures:[FixturesInfo]?)
    func showTeams(teams:[TeamsResult]?)
}

class FixtureViewController: UIViewController, FixtureProtocol {
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var fixtureCollectionView: UICollectionView!
    
    
    var currentMatches = [FixturesInfo]()
    var previousMatches = [FixturesInfo]()
    var leagueTeams = [TeamsResult]()
    var currentLeague : LeagueInfo!
    
    var sportType:String = ""
    var leagueID:String = ""
    
    var presenter : FixturesPresenter!
    var activityIndicator:UIActivityIndicatorView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(currentLeague.league_key,"----",currentLeague.league_name)
         presenter = FixturesPresenter(sportType: sportType, leagueID: leagueID, fixtureVC: self)
        presenter.fetchFixturesFromNetwork()
        presenter.fetchTeamsFromNetwork()
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = view.center
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
        activityIndicator.isHidden = false
        activityIndicator.color = .blue

        fixtureCollectionView.register(UINib(nibName: "FixtureCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "fixtureCell")
        
        fixtureCollectionView.register(UINib(nibName: "TeamCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "teamCell")
        
        fixtureCollectionView.register(HeaderCollectionViewReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderCollectionReusableView")
        checkIfLeagueIsExist()
        let layout = UICollectionViewCompositionalLayout{
            index , enviroment in
            switch index {
            case 0:
                return self.drawTopSection()
            case 1:
                return self.drawMiddleSection()
            default:
                return self.drawBottomSection()
            }
        }
        fixtureCollectionView.setCollectionViewLayout(layout, animated: true)
        
    }
    
    func drawTopSection() -> NSCollectionLayoutSection{
        //size
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        //item
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        //group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.97), heightDimension: .absolute(180))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        //section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        
        //
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50))
                let headerSupplementary = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
                
                section.boundarySupplementaryItems = [headerSupplementary]
          
        //
        return section
    }
    
    func drawMiddleSection() -> NSCollectionLayoutSection{
        //size
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        //item
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        //group
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(180))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        //section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .none
        section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        //
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50))
                let headerSupplementary = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
                
                section.boundarySupplementaryItems = [headerSupplementary]
                
        //
        return section
    }
    
    func drawBottomSection() -> NSCollectionLayoutSection{
        //size
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        //item
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        //group
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.35), heightDimension: .absolute(150))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        //section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        //
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50))
                let headerSupplementary = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
                
                section.boundarySupplementaryItems = [headerSupplementary]
              
        //
        return section
    }
    
    
    func showFixtures(fixtures: [FixturesInfo]?) {
        DispatchQueue.main.async {
            let matches: [FixturesInfo] = fixtures ?? [FixturesInfo]()
            self.previousMatches.removeAll()
            for match in matches {
                if match.event_ft_result == "" {
                    self.currentMatches.append(match)
                }else if match.event_ft_result != "" {
                    self.previousMatches.append(match)
                }
            }
            print(self.currentMatches.count)
            
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
            self.fixtureCollectionView.reloadData()
        }
    }
    func showTeams(teams: [TeamsResult]?) {
        DispatchQueue.main.async{
            self.leagueTeams = teams ?? [TeamsResult]()
            
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
            self.fixtureCollectionView.reloadData()
        }
    }
    func checkIfLeagueIsExist()->Bool{
        var leagueAlreadyExists = false
        let fetchedLeagues = presenter.fetchLeaguesFromDB()
        for item in fetchedLeagues {
            if Int(item.league_key ?? 0) == currentLeague.league_key {
                saveButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
                leagueAlreadyExists = true
                break
            }
        }
        return leagueAlreadyExists
    }
    
    @IBAction func saveLeagueData(_ sender: UIButton) {
        let leagueAlreadyExists = checkIfLeagueIsExist()
           
           // If league doesn't exist in DB, add it
           if !leagueAlreadyExists {
               
               AlertPresenter.positiveAlert(false, title: "SaveLeague", message: "Are you sure you want to Save league ? ", yesButton: "Save", noButton: "Cancel", on: self) {
                   print(self.currentLeague!)
                       self.presenter.addLeagueToDB(league: (self.currentLeague)!)
                        sender.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
               } noHandler: {
                   
               }

               
               
               
//               let alert = UIAlertController(title: "Save League", message: "Are you sure you want to Save league ? ", preferredStyle: UIAlertController.Style.alert)
               
//               alert.addAction(UIAlertAction(title: "Save", style: UIAlertAction.Style.default){ [weak self] _ in
//                   print(self?.currentLeague!)
//                   self?.presenter.addLeagueToDB(league: (self?.currentLeague)!)
//                    sender.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
//               })
               
//               alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
           
//               self.present(alert, animated: true, completion: nil)
           
           } else if leagueAlreadyExists {
               print(leagueAlreadyExists)
               
               // If league already exists, update UI or perform other actions
               sender.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
           }
    }
}


extension FixtureViewController:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 360 , height: 180)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 50)
    }
}



extension FixtureViewController: UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section {
        case 2:
            if sportType == "football" {
                
                let teamDetails = leagueTeams[indexPath.row]
                let teamViewController = self.storyboard?.instantiateViewController(withIdentifier: "TeamDetailsViewController") as? TeamDetailsViewController
                teamViewController?.team = teamDetails
                navigationController?.pushViewController(teamViewController!, animated: true)
            } else {
                AlertPresenter.positiveAlert(true, title: "Sorry!", message: "We Cant Access This Team Now! ", yesButton: "OK", noButton: nil, on: self, yesHandler: {}, noHandler: {})
//
//                let alert = UIAlertController(title: "Sorry!", message: "We Cant Access This Team Now! ", preferredStyle: UIAlertController.Style.alert)
//                
//
//                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil))
//
//                self.present(alert, animated: true, completion: nil)
            
            }
        default:
            print("Aa")
        }
    }
    
}


extension FixtureViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let sectionName = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderCollectionReusableView", for: indexPath) as? HeaderCollectionViewReusableView
        guard let sectionName = sectionName else { return UICollectionReusableView()}
        if kind == UICollectionView.elementKindSectionHeader {
            switch indexPath.section {
            case 0:
                if currentMatches.count == 1 {
                    
                    sectionName.collectionHeader.text = "No UpComing Matches"
                }else {
                    
                    sectionName.collectionHeader.text = "UpComing Matches"
                }
            case 1:
                if previousMatches.count == 1 {
                    
                    sectionName.collectionHeader.text = "No Latest Matches"
                }else{
                    
                    sectionName.collectionHeader.text = "Latest Matches"
                }
            default:
                if leagueTeams.count == 1{
                    
                    sectionName.collectionHeader.text = "No Teams"
                }else {
                    
                    sectionName.collectionHeader.text = "\(currentLeague.league_name) Teams"
                }
            }
        }
        return sectionName
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section{
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "fixtureCell", for: indexPath) as? FixtureCollectionViewCell
            
            guard let cell = cell else {return UICollectionViewCell()}
            
            cell.homeTeamLabel.text = currentMatches[indexPath.row].event_home_team
            switch sportType{
            case "football":
                cell.homeTeamImage.sd_setImage(with: URL(string: currentMatches[indexPath.row].home_team_logo ?? ""), placeholderImage: UIImage(named: "footballteamplaceholder"))
                cell.awayTeamImage.sd_setImage(with: URL(string: currentMatches[indexPath.row].away_team_logo ?? ""), placeholderImage: UIImage(named: "footballteamplaceholder"))
            case "basketball":
                cell.homeTeamImage.sd_setImage(with: URL(string: currentMatches[indexPath.row].home_team_logo ?? ""), placeholderImage: UIImage(named: "basketballteamplaceholder"))
                
                cell.awayTeamImage.sd_setImage(with: URL(string: currentMatches[indexPath.row].away_team_logo ?? ""), placeholderImage: UIImage(named: "basketballteamplaceholder"))
            case "tennis":
                cell.homeTeamImage.sd_setImage(with: URL(string: currentMatches[indexPath.row].home_team_logo ?? ""), placeholderImage: UIImage(named: "tennisplayerplaceholder"))
                
                cell.awayTeamImage.sd_setImage(with: URL(string: currentMatches[indexPath.row].away_team_logo ?? ""), placeholderImage: UIImage(named: "tennisplayerplaceholder"))
            
            case "cricket":
                cell.homeTeamImage.sd_setImage(with: URL(string: currentMatches[indexPath.row].home_team_logo ?? ""), placeholderImage: UIImage(named: "basketballplayerplaceholder"))
                
                cell.awayTeamImage.sd_setImage(with: URL(string: currentMatches[indexPath.row].away_team_logo ?? ""), placeholderImage: UIImage(named: "basketballplayerplaceholder"))
            
                
            default:
                
                    cell.homeTeamImage.sd_setImage(with: URL(string: currentMatches[indexPath.row].home_team_logo ?? ""), placeholderImage: UIImage(named: "footballplayerplaceholder"))
                    cell.awayTeamImage.sd_setImage(with: URL(string: currentMatches[indexPath.row].away_team_logo ?? ""), placeholderImage: UIImage(named: "footballplayerplaceholder"))
                
            }
            cell.awayTeamLabel.text = currentMatches[indexPath.row].event_away_team
            cell.matchDate.text =  currentMatches[indexPath.row].event_date
            cell.matchTime.text = currentMatches[indexPath.row].event_time
            cell.scoreLabel.text = "VS"
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "fixtureCell", for: indexPath) as? FixtureCollectionViewCell
            guard let cell = cell else {return UICollectionViewCell()}
            switch sportType{
            case "football":
                cell.homeTeamImage.sd_setImage(with: URL(string: previousMatches[indexPath.row].home_team_logo ?? ""), placeholderImage: UIImage(named: "footballteamplaceholder"))
                cell.awayTeamImage.sd_setImage(with: URL(string: previousMatches[indexPath.row].away_team_logo ?? ""), placeholderImage: UIImage(named: "footballteamplaceholder"))
            case "basketball":
                
                    cell.homeTeamImage.sd_setImage(with: URL(string: previousMatches[indexPath.row].home_team_logo ?? ""), placeholderImage: UIImage(named: "basketballteamplaceholder"))
                    cell.awayTeamImage.sd_setImage(with: URL(string: previousMatches[indexPath.row].away_team_logo ?? ""), placeholderImage: UIImage(named: "basketballteamplaceholder"))
            case "tennis":
                
                    cell.homeTeamImage.sd_setImage(with: URL(string: previousMatches[indexPath.row].home_team_logo ?? ""), placeholderImage: UIImage(named: "tennisplayerplaceholder"))
                    cell.awayTeamImage.sd_setImage(with: URL(string: previousMatches[indexPath.row].away_team_logo ?? ""), placeholderImage: UIImage(named: "tennisplayerplaceholder"))
            
            case "cricket":
                
                    cell.homeTeamImage.sd_setImage(with: URL(string: previousMatches[indexPath.row].home_team_logo ?? ""), placeholderImage: UIImage(named: "basketballplayerplaceholder"))
                    cell.awayTeamImage.sd_setImage(with: URL(string: previousMatches[indexPath.row].away_team_logo ?? ""), placeholderImage: UIImage(named: "basketballplayerplaceholder"))
            
                
            default:
                
                    cell.homeTeamImage.sd_setImage(with: URL(string: previousMatches[indexPath.row].home_team_logo ?? ""), placeholderImage: UIImage(named: "footballplayerplaceholder"))
                    cell.awayTeamImage.sd_setImage(with: URL(string: previousMatches[indexPath.row].away_team_logo ?? ""), placeholderImage: UIImage(named: "footballplayerplaceholder"))
                
            }
            cell.homeTeamLabel.text = previousMatches[indexPath.row].event_home_team
            cell.awayTeamLabel.text = previousMatches[indexPath.row].event_away_team
            cell.matchDate.text = previousMatches[indexPath.row].event_date
            cell.matchTime.text = previousMatches[indexPath.row].event_time
            cell.scoreLabel.text = previousMatches[indexPath.row].event_ft_result
            return cell
        default:
            let teamCell = collectionView.dequeueReusableCell(withReuseIdentifier: "teamCell", for: indexPath) as? TeamCollectionViewCell
            guard let teamCell = teamCell else { return UICollectionViewCell()}
            teamCell.setUpTeamCell(team: leagueTeams[indexPath.row],sportType:sportType)
            return teamCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        switch section{
        case 0:
            if currentMatches.count == 0 {
                currentMatches.append(FixturesInfo(league_key: 0, event_date: "Undeined", event_time: "0:00", event_home_team: "N/A", event_away_team: "N/A", home_team_logo: "N/A", away_team_logo: "N/A", event_ft_result: "0-0"))
                return 1
            }
            return currentMatches.count
        case 1:
            if previousMatches.count == 0 {
                previousMatches.append(FixturesInfo(league_key: 0, event_date: "Undefined", event_time: "0:00", event_home_team: "N/A", event_away_team: "N/A", home_team_logo: "N/A", away_team_logo: "N/A", event_ft_result: "0-0"))
                
            }
            return previousMatches.count
        case 2:
            if leagueTeams.count == 0 {
                leagueTeams.append(TeamsResult(team_key: 0,team_name: "Undefined",team_logo: "N/A"))
            }
            return leagueTeams.count
        default:
            return 0
        }
    }
    
}
