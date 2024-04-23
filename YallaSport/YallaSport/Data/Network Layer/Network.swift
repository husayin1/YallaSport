//
//  Network.swift
//  YallaSport
//
//  Created by husayn on 22/04/2024.
//


import Foundation
import Alamofire
class Network :NetworkLayerProtocol{
    //apiKey
    let apiKey:String = "0b11a6a325539dbf2de2d49ca9f6c29c2fa7417fe868385cd36d18a939079788"
    //singleton
    private static var instance:Network? = nil
    //private constructor
    private init(){}
    static func getInstance() -> Network? {
        if instance == nil {
            instance = Network()
        }
        return instance
    }
    //fetche leagues from network
    func fetchLeagues(sportType sport:String,completionHandler completion: @escaping(Result<Leagues,Error>) -> Void) {
        let url = URL(string: "https://apiv2.allsportsapi.com/\(sport)/?met=Leagues&APIkey=\(apiKey)")
        AF.request(url!).validate().response{ data in
            switch data.result{
            case .success(let fetchedData):
                do{
                    let decodedData = try JSONDecoder().decode(Leagues.self, from: fetchedData!)
                    print(decodedData.result[0].league_name)
                    completion(.success(decodedData))
                } catch {
                    print("Error from fetch Leagues -> \n")
                    print(error.localizedDescription)
                    print(error)
                    completion(.failure(error))
                }
            case .failure(let err):
                print(err.localizedDescription)
                print("error Fetching Leagues->> \(err)")
                completion(.failure(err))
            }
        }
    }
}
