//
//  Teams.swift
//  YallaSport
//
//  Created by marwa on 25/04/2024.
//

import Foundation

struct Teams : Codable {
    var success :  Int?
    var result  :  [TeamsResult]?
}

class Coaches:Codable{
    var coach_name : String?
}

struct TeamsResult   : Codable {
    var team_key : Int?
    var team_name: String?
    var team_logo: String?
    var players  : [Players]?
    var coaches  : [Coaches]?
}


struct Players: Codable {
    var player_key   : Int?
    var player_image : String?
    var player_name  : String?
    var player_number: String?
    var player_type  : String?
}
