//
//  NetworkLayerProtocol.swift
//  YallaSport
//
//  Created by husayn on 22/04/2024.
//

import Foundation
protocol NetworkLayerProtocol : Codable {
    static func fetchLeagues (sportType: String,completionHandler:@escaping(Result<Leagues,Error>)->(Void))
    static func fetchFixtures(sportType: String,leagueID: String,from:String,to :String, completionHandler:@escaping(Result<Fixtures,Error>)->(Void))
}
