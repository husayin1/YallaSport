//
//  Network.swift
//  YallaSport
//
//  Created by husayn on 22/04/2024.
//


import Foundation
import Alamofire

protocol NetworkLayerProtocol : Codable {
    static func fetchLeagues (sportType: String,completionHandler:@escaping(Result<Leagues,Error>)->(Void))
    static func fetchFixtures(sportType: String,leagueID: String,from:String,to :String, completionHandler:@escaping(Result<Fixtures,Error>)->(Void))
    static func fetchTeamsFromNetwork (sportType: String,leagueId : String , completionHnadler : @escaping (Result<Teams , Error>) ->()) 
}


class Network :NetworkLayerProtocol{
    //apiKey
    static let apiKey:String = "0b11a6a325539dbf2de2d49ca9f6c29c2fa7417fe868385cd36d18a939079788"
    static let base_Url:String = "https://apiv2.allsportsapi.com/"
    //private constructor
//    private init(){}
    //fetche leagues from network
   static func fetchLeagues(sportType sport:String,completionHandler completion: @escaping(Result<Leagues,Error>) -> Void) {
        let url = URL(string: "\(base_Url)\(sport)/?met=Leagues&APIkey=\(apiKey)")
       guard let newUrl = url else {return}
        AF.request(newUrl).validate().response{ data in
            switch data.result{
            case .success(let fetchedData):
                do{
                    guard let fetchedData = fetchedData else {return}
                    let decodedData = try JSONDecoder().decode(Leagues.self, from: fetchedData)
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
    
    
    //fetch teams
    static func fetchTeamsFromNetwork (sportType: String,leagueId : String , completionHnadler : @escaping (Result<Teams , Error>) ->()) {
        
        let url = URL(string: "\(base_Url)\(sportType)/?&met=Teams&leagueId=\(leagueId)&APIkey=\(apiKey)")
        guard let newUrl = url else {return }
        print(newUrl)
        let request = URLRequest(url: newUrl)
        let session = URLSession.shared        
        let task = session.dataTask(with: request){
            data,response,error in
            if let error = error {
                completionHnadler(.failure(error))
                return
            }
            guard let data = data else {
                let error = NSError(domain: "NoData", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received"])
                completionHnadler(.failure(error))
                return
            }
            do {
                let teams = try JSONDecoder().decode(Teams.self, from: data)
                completionHnadler(.success(teams))
                print(newUrl)
                print("fetchTeamsFromNetwork",teams.result?[0].team_name ?? "Unfound teams")
            }
            catch {
                print("Error ")
            }
        }
        task.resume()
     }
//fetch Fixtures
    static func fetchFixtures(sportType sport:String,leagueID: String,from:String,to :String,completionHandler completion: @escaping(Result<Fixtures,Error>) -> (Void)) {
         let fixuresUrl = URL(string: "\(base_Url)\(sport)/?met=Fixtures&APIkey=\(apiKey)&from=\(from)&leagueId=\(leagueID)&to=\(to)")
         
         guard let fixuresUrl = fixuresUrl
         else{return}
         
         AF.request(fixuresUrl).validate().response{ data in
             switch data.result{
             case .success(let fetchedData):
                 do{
                     guard let fetchedData = fetchedData else {return}
                     let decodedData = try JSONDecoder().decode(Fixtures.self, from: fetchedData)
                     completion(.success(decodedData))
                 } catch {
                     print("Error from fetch Fixtures -> \n")
                     print(error.localizedDescription)
                     print(error)
                     completion(.failure(error))
                 }
             case .failure(let err):
                 print(err.localizedDescription)
                 print("error Fetching Fixtures->> \(err)")
                 completion(.failure(err))
             }
         }
     }
     
    
}
