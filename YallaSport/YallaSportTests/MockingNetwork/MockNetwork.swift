//
//  MockNetwork.swift
//  YallaSportTests
//
//  Created by marwa on 01/05/2024.
//

import Foundation
@testable import YallaSport

protocol MockingNetworkProtocol{
    func fetchTeamsFromNetwork (sportType: String,leagueId : String , completionHnadler : @escaping (Result<Teams , Error>) ->())
   
    func fetchLeagues(sportType sport:String,completionHandler completion: @escaping(Result<Leagues,Error>) -> Void)
}

class MockNetwork {
    var isError : Bool
    init(isError: Bool) {
        self.isError = isError
    }
    
    
    
    var fakeLeaguesJsonObj : [String : Any] = [
    "success": 1,
    "result": [
      [
           "league_key": "205",
           "league_name": "Coppa Italia",
           "country_key": "5",
           "country_name": "Italy",
           "league_logo": "https://apiv2.allsportsapi.com/logo/logo_leagues/205_coppa-italia.png",
           "country_logo": "https://apiv2.allsportsapi.com/logo/logo_country/5_italy.png"
       ],
       [
           "league_key": "206",
           "league_name": "Serie B",
           "country_key": "5",
           "country_name": "Italy",
           "league_logo": "https://apiv2.allsportsapi.com/logo/logo_leagues/206_serie-b.png",
           "country_logo": "https://apiv2.allsportsapi.com/logo/logo_country/5_italy.png"
       ],
       [
           "league_key": "207",
           "league_name": "Serie A",
           "country_key": "5",
           "country_name": "Italy",
           "league_logo": "https://apiv2.allsportsapi.com/logo/logo_leagues/207_serie-a.png",
           "country_logo": "https://apiv2.allsportsapi.com/logo/logo_country/5_italy.png"
       ]]]
    
    var fakeTeamJsonObj : [String : Any] = [
        "success": 1,
        "result": [
            [
                "team_key": 96,
                "team_name": "Juventus",
                "team_logo": "https://apiv2.allsportsapi.com/logo/96_juventus.jpg",
                "players": [
                    [
                        "player_key": 3063582184,
                        "player_name": "F. Israel",
                        "player_number": "45",
                        "player_type": "Goalkeepers",
                        "player_age": "21",
                        "player_match_played": "0",
                        "player_goals": "0",
                        "player_yellow_cards": "0",
                        "player_red_cards": "0",
                        "player_image": "https://apiv2.allsportsapi.com/logo/players/79274_f-israel.jpg"
                    ],
                    [
                        "player_key": 41841276,
                        "player_name": "M. Perin",
                        "player_number": "",
                        "player_type": "Goalkeepers",
                        "player_age": "",
                        "player_match_played": "",
                        "player_goals": "",
                        "player_yellow_cards": "",
                        "player_red_cards": "",
                        "player_image": "https://apiv2.allsportsapi.com/logo/players/472_m-perin.jpg"
                    ]
                ],
                "coaches": []
            ]
        ]
    ]
    
    enum ErrorResponse : Error{
        case errorResponse
    }

}


extension MockNetwork : MockingNetworkProtocol{
    //fetch teams
     func fetchTeamsFromNetwork (sportType: String,leagueId : String , completionHnadler : @escaping (Result<Teams , Error>) ->()) {
         var teamsResult : Teams?
         
         do{
             let teamData = try JSONSerialization.data(withJSONObject: fakeTeamJsonObj)
             teamsResult = try JSONDecoder().decode(Teams.self, from: teamData)
         }catch let error {
             print("error",error)
         }
         
         if !isError{
             completionHnadler(.success(teamsResult!))
         }else{
             completionHnadler(.failure(ErrorResponse.errorResponse))
         }
     }
    
    
    //fetche leagues from network
    func fetchLeagues(sportType sport:String,completionHandler completion: @escaping(Result<Leagues,Error>) -> Void) {
       
        var leaguesResult : Leagues!
      
                do{
                    let data = try JSONSerialization.data(withJSONObject: fakeLeaguesJsonObj)
                    leaguesResult = try JSONDecoder().decode(Leagues.self, from: data)
                    if !isError{
                        completion(.success(leaguesResult))
                    }else{
                        completion(.failure(ErrorResponse.errorResponse))
                    }
                    
                } catch {
                    print("Error from fetch Leagues -> \n")
                    print(error.localizedDescription)
                    print(error)
                    
                }
       
        
    }
}
