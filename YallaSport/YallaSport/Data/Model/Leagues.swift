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
    let league_key: Int
    let league_name: String
    var league_logo: String? // return null sometimes

}
