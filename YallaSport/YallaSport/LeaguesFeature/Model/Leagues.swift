//
//  Leagues.swift
//  YallaSport
//
//  Created by husayn on 22/04/2024.
//

import Foundation
// Root of Leagues
struct Leagues: Decodable {
    let success: Int
    let result: [LeagueInfo]
}

// LeagueItem -> Result
struct LeagueInfo: Decodable {
    let league_key: Int
    let league_name: String
    var league_logo: String?

}
