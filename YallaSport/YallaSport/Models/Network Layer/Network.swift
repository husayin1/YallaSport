//
//  Network.swift
//  YallaSport
//
//  Created by husayn on 22/04/2024.
//


import Foundation
import Alamofire
//apiKey
let apiKey:String = "0b11a6a325539dbf2de2d49ca9f6c29c2fa7417fe868385cd36d18a939079788"

class Network :NetworkLayerProtocol{
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
   static func fetchLeagues(sportType sport:String,completionHandler completion: @escaping(Result<Leagues,Error>) -> Void) {
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
    
    
    
    static func fetchTeamsFromNetwork (leagueId : String , completionHnadler : @escaping (Result<Teams , Error>) ->()) {
        
        var url = URL(string: "https://apiv2.allsportsapi.com/football/?&met=Teams&leagueId=\(leagueId)&APIkey=\(apiKey)")
        var request = URLRequest(url: url!)
        var session = URLSession.shared
        
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
                var teams = try JSONDecoder().decode(Teams.self, from: data)
                completionHnadler(.success(teams))
                print("fetchTeamsFromNetwork",teams.result[0].team_name!)
            }
            catch {
                print("Error ")
            }
        }
        
        task.resume()
        
        
     }
   /*
    static func fetchTeamsFromNetwork (leagueId : String , completionHnadler : @escaping (Result<Teams , Error>) ->()) {
        AF.request("https://apiv2.allsportsapi.com/football/?&met=Teams&leagueId=\(leagueId)&APIkey=\(apiKey)").validate().response { response in
            switch response.result {
            case .success(let teamsData) :
                do {
                    var teams = try JSONDecoder().decode(Teams.self, from: teamsData!)
                    completionHnadler(.success(teams))
                    print("fetchTeamsFromNetwork",teams.result[0].team_name!)
                }
                catch {
                    completionHnadler(.failure(error))
                    print("Error ")
                }
            
                
                
            case .failure(let error):
                completionHnadler(.failure(error))
            }
        }
        
        
    }
    */

    
    
    static func fetchFixtures(sportType sport:String,leagueID: String,from:String,to :String,completionHandler completion: @escaping(Result<Fixtures,Error>) -> (Void)) {
         let fixuresUrl = URL(string: "https://apiv2.allsportsapi.com/\(sport)/?met=Fixtures&APIkey=\(apiKey)&from=\(from)&leagueId=\(leagueID)&to=\(to)")
         
         guard let fixuresUrl = fixuresUrl
         else{return}
         
         AF.request(fixuresUrl).validate().response{ data in
             switch data.result{
             case .success(let fetchedData):
                 do{
                     let decodedData = try JSONDecoder().decode(Fixtures.self, from: fetchedData!)
                     print("Event home team from network")
                     print(decodedData.result?[0].event_home_team)
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
