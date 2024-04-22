//
//  League.swift
//  YallaSport
//
//  Created by husayn on 22/04/2024.
//

import Foundation

struct League : Codable{
    let leagueKey:String
    let leagueName:String
    let countryKey:String
    let countryName:String
    let leagueLogo:String
    let countryLogo:String
    
    enum leagueKeys : String , CodingKey {
        case leagueKey = "league_key"
        case leagueName = "league_name"
        case countryKey = "country_key"
        case countryName = "country_name"
        case leagueLogo = "league_logo"
        case countryLogo = "country_logo"
    }
}
