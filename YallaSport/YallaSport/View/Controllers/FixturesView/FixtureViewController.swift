//
//  FixtureViewController.swift
//  YallaSport
//
//  Created by husayn on 26/04/2024.
//

import UIKit
protocol FixtureProtocol{
    
}

class FixtureViewController: UIViewController , UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout,FixtureProtocol {
    
    @IBOutlet weak var fixtureCollectionView: UICollectionView!
    
    var currentMatches = [FixturesInfo]()
    var previousMatches = [FixturesInfo]()
    var leagueTeams = [TeamsResult]()
    
    var sportType:String = ""
    var leagueID:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Here Iam")
        let fromDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let currentDateString = dateFormatter.string(from: fromDate)
        
        let calendar = Calendar.current
        let dateComponents = DateComponents(day:-7)
        let oneDayAgo = calendar.date(byAdding: dateComponents, to: fromDate)
        let oneDayAgoString = dateFormatter.string(from: oneDayAgo!)
        Network.fetchFixtures(sportType: sportType,leagueID: leagueID,from: oneDayAgoString,to: "2024-04-28"){
            [weak self] data in
            switch data {
            case .success(let response):
                DispatchQueue.main.async {
                    let matches: [FixturesInfo] = response.result ?? [FixturesInfo]()
                    for match in matches {
                        if match.event_ft_result == "" {
                            self?.currentMatches.append(match)
                        }else if match.event_ft_result != "" {
                            self?.previousMatches.append(match)
                        }
                    }
                    self?.fixtureCollectionView.reloadData()
                }
            case .failure(let err):
                print(err)
                print(err.localizedDescription)
            }
        }
        Network.fetchTeamsFromNetwork(leagueId: leagueID){
            [weak self] data in
            switch data {
            case .success(let response):
                DispatchQueue.main.async{
                    self?.leagueTeams = response.result
                    self?.fixtureCollectionView.reloadData()
                }
                
            case .failure(let err):
                print(err)
                print(err.localizedDescription)
            }
        }
        fixtureCollectionView.register(UINib(nibName: "FixtureCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "fixtureCell")
        
        fixtureCollectionView.register(UINib(nibName: "TeamCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "teamCell")
        
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
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.95), heightDimension: .absolute(180))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        //section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        
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
        
        //return
        
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
        
        //return
        
        return section
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 360 , height: 180)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 50)
    }
    // MARK: UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        switch section{
        case 0:
            return currentMatches.count
        case 1:
            return previousMatches.count
        case 2:
            return leagueTeams.count
        default:
            return 0
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "fixtureCell", for: indexPath) as! FixtureCollectionViewCell
        
        let teamCell = collectionView.dequeueReusableCell(withReuseIdentifier: "teamCell", for: indexPath) as! TeamCollectionViewCell
        
        switch indexPath.section{
        case 0:
            cell.homeTeamImage.sd_setImage(with: URL(string: currentMatches[indexPath.row].home_team_logo ?? ""), placeholderImage: UIImage(named: "car"))
            cell.homeTeamLabel.text = currentMatches[indexPath.row].event_home_team
            cell.awayTeamImage.sd_setImage(with: URL(string: currentMatches[indexPath.row].away_team_logo ?? ""), placeholderImage: UIImage(named: "car"))
            cell.awayTeamLabel.text = currentMatches[indexPath.row].event_away_team
            cell.matchDate.text =  currentMatches[indexPath.row].event_date
            cell.matchTime.text = currentMatches[indexPath.row].event_time
            cell.scoreLabel.text = currentMatches[indexPath.row].event_ft_result
        case 1:
            cell.homeTeamImage.sd_setImage(with: URL(string: previousMatches[indexPath.row].home_team_logo ?? ""), placeholderImage: UIImage(named: "car"))
            cell.homeTeamLabel.text = previousMatches[indexPath.row].event_home_team
            cell.awayTeamImage.sd_setImage(with: URL(string: previousMatches[indexPath.row].away_team_logo ?? ""), placeholderImage: UIImage(named: "car"))
            cell.awayTeamLabel.text = previousMatches[indexPath.row].event_away_team
            cell.matchDate.text = previousMatches[indexPath.row].event_date
            cell.matchTime.text = previousMatches[indexPath.row].event_time
            cell.scoreLabel.text = previousMatches[indexPath.row].event_ft_result
        default:
            
            teamCell.teamImage.sd_setImage(with: URL(string: leagueTeams[indexPath.row].team_logo ?? ""), placeholderImage: UIImage(named: "car"))
            teamCell.teamName.text = leagueTeams[indexPath.row].team_name
        }
        switch indexPath.section{
        case 2:
            return teamCell
        default:
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section {
        case 2:
            //Go to Team Details From Here ya marwa->
            print(leagueTeams[indexPath.row].team_key)
            print(leagueTeams[indexPath.row].team_name)
        default:
            print("Aa")
        }
    }
}



// MARK: UICollectionViewDelegate

/*
 // Uncomment this method to specify if the specified item should be highlighted during tracking
 func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
 return true
 }
 */

/*
 // Uncomment this method to specify if the specified item should be selected
 func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
 return true
 }
 */

/*
 // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
 func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
 return false
 }
 
 func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
 return false
 }
 
 func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
 
 }
 */
