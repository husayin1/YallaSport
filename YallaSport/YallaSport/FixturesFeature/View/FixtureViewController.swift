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
    
    override func viewDidLoad() {
        super.viewDidLoad()
         presenter = FixturesPresenter(sportType: sportType, leagueID: leagueID, fixtureVC: self)
        presenter.fetchFixturesFromNetwork()
        presenter.fetchTeamsFromNetwork()
        
        fixtureCollectionView.register(UINib(nibName: "FixtureCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "fixtureCell")
        
        fixtureCollectionView.register(UINib(nibName: "TeamCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "teamCell")
        
        fixtureCollectionView.register(HeaderCollectionViewReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderCollectionReusableView")
        
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
            self.fixtureCollectionView.reloadData()
        }
    }
    func showTeams(teams: [TeamsResult]?) {
        DispatchQueue.main.async{
            self.leagueTeams = teams ?? [TeamsResult]()
            self.fixtureCollectionView.reloadData()
        }
    }
    
    @IBAction func saveLeagueData(_ sender: UIButton) {
        //here to save leagueData y marwa
        sender.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
        presenter.addLeagueToDB(league: currentLeague)
        print("current league added")
        
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
            let teamDetails = leagueTeams[indexPath.row]
            let teamViewController = self.storyboard?.instantiateViewController(withIdentifier: "TeamDetailsViewController") as? TeamDetailsViewController
            teamViewController?.team = teamDetails
            navigationController?.pushViewController(teamViewController!, animated: true)
        default:
            print("Aa")
        }
    }
    
}


extension FixtureViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let sectionName = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderCollectionReusableView", for: indexPath) as! HeaderCollectionViewReusableView
        
        if kind == UICollectionView.elementKindSectionHeader {
            switch indexPath.section {
            case 0:
                sectionName.collectionHeader.text = "Up Coming Matches"
            case 1:
                sectionName.collectionHeader.text = "Latest Matches"
            default:
                sectionName.collectionHeader.text = "League Teams"
            }
        }
        return sectionName
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
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
            cell.scoreLabel.text = "VS"
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        switch section{
        case 0:
            if currentMatches.count == 0 {
                currentMatches.append(FixturesInfo(league_key: 0, event_date: "UnExist", event_time: "Unavilable", event_home_team: "No Team", event_away_team: "No Team", home_team_logo: "TeamLogo", away_team_logo: "AwayLogo", event_ft_result: "0-0"))
                return 1
            }
            return currentMatches.count
        case 1:
            if previousMatches.count == 0 {
                previousMatches.append(FixturesInfo(league_key: 0, event_date: "UnExist", event_time: "Unavilable", event_home_team: "No Team", event_away_team: "No Team", home_team_logo: "TeamLogo", away_team_logo: "AwayLogo", event_ft_result: "0-0"))
                
            }
            return previousMatches.count
        case 2:
            if leagueTeams.count == 0 {
                leagueTeams.append(TeamsResult(team_key: 0,team_name: "NoTeams",team_logo: "NoLogo"))
            }
            return leagueTeams.count
        default:
            return 0
        }
    }
    
}
