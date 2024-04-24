//
//  NetworkLayerProtocol.swift
//  YallaSport
//
//  Created by husayn on 22/04/2024.
//

import Foundation
protocol NetworkLayerProtocol{
    func fetchLeagues (sportType: String,completionHandler:@escaping(Result<Leagues,Error>)->(Void))
}
