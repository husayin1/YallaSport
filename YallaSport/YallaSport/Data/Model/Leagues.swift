//
//  Leagues.swift
//  YallaSport
//
//  Created by husayn on 22/04/2024.
//

import Foundation

// Root of Leagues
struct Leagues: Codable {
    let success: Int
    let result: [LeagueInfo]
}

// LeagueItem -> Result
struct LeagueInfo: Codable {
    let leagueKey: Int
    let leagueName: String
    var leagueLogo: String? // Make leagueLogo optional
    
    enum CodingKeys: String, CodingKey {
        case leagueKey = "league_key"
        case leagueName = "league_name"
        case leagueLogo = "league_logo"
    }
    
    // Implementing the initializer to use custom coding keys
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        leagueKey = try container.decode(Int.self, forKey: .leagueKey)
        leagueName = try container.decode(String.self, forKey: .leagueName)
        leagueLogo = try container.decodeIfPresent(String.self, forKey: .leagueLogo) // Decode as optional
        
        // Handle null case gracefully
        if leagueLogo == nil {
            // Provide a default value or handle the null case as needed
            leagueLogo = "default_logo_url"
        }
    }
}
