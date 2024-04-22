//
//  Leagues.swift
//  YallaSport
//
//  Created by husayn on 22/04/2024.
//

import Foundation
//Root of Leagues
struct Leagues: Decodable{
    let success: Int
    let result: [LeagueInfo]
    
}
//LeagueItem -> Result
struct LeagueInfo: Decodable {
    let leagueKey : Int
    let leagueName : String
    let leagueLogo : String?
    
    enum leagueKeys : String , CodingKey {
        case leagueKey = "league_key"
        case leagueName = "league_name"
        case leagueLogo = "league_logo"
    }
}
