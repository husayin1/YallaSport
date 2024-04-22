//
//  NetworkLayerProtocol.swift
//  YallaSport
//
//  Created by husayn on 22/04/2024.
//

import Foundation
protocol NetworkLayerProtocol{
    func fetchDataFromNetwork (sportType: String, apiMethodName: String)
}
