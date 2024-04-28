//
//  FixturePresenter.swift
//  YallaSport
//
//  Created by husayn on 26/04/2024.
//

import Foundation

class FixturesPresenter{
    
    
    let fixtureViewController: FixtureProtocol
    let sportType: String
    let leagueID: String
    init(sportType: String,leagueID:String,fixtureVC:FixtureProtocol){
        self.fixtureViewController = fixtureVC
        self.sportType = sportType
        self.leagueID = leagueID
    }
    
    func fetchFixturesFromNetwork(){
        let fromDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let currentDateString = dateFormatter.string(from: fromDate)
        
        let calendar = Calendar.current
        let dateComponents = DateComponents(day:-7)
        let twoDayAgo = calendar.date(byAdding: dateComponents, to: fromDate)
        guard let twoDayAgo = twoDayAgo else {return}
        let twoDayAgoString = dateFormatter.string(from: twoDayAgo)
        Network.fetchFixtures(sportType: sportType, leagueID: leagueID, from: twoDayAgoString, to: currentDateString){
            data in
            switch data {
            case .success(let response):
                self.fixtureViewController.showFixtures(fixtures: response.result)
            case .failure(_):
                self.fixtureViewController.showFixtures(fixtures: nil)
            }
        }
    }
    func fetchTeamsFromNetwork(){
        Network.fetchTeamsFromNetwork(sportType:sportType,leagueId: leagueID){
            data in
            switch data {
            case .success(let response):
                self.fixtureViewController.showTeams(teams: response.result)
            case .failure(_):
                self.fixtureViewController.showTeams(teams: nil)
            }
        }
    }
}
