//
//  Fixtures.swift
//  YallaSport
//
//  Created by husayn on 26/04/2024.
//

import Foundation
struct Fixtures:Codable{
    let success: Int?
    let result: [FixturesInfo]?
}
struct FixturesInfo:Codable{
    let league_key: Int?
    let event_date: String?
    let event_time: String?
    let event_home_team: String?
    let event_away_team: String?
    let home_team_logo: String?
    let away_team_logo: String?
    let event_ft_result:String?
}

