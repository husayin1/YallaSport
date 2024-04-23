//
//  Network.swift
//  YallaSport
//
//  Created by husayn on 22/04/2024.
//

import Foundation
import Alamofire
class Network {
    //apiKey
    let apiKey:String = "0b11a6a325539dbf2de2d49ca9f6c29c2fa7417fe868385cd36d18a939079788"
    //singleton
    private static var instance:Network? = nil
    private init(){}
    static func getInstance() -> Network? {
        if instance == nil {
            instance = Network()
        }
        return instance
    }
    
    
    func fetchLeagues(sport:String,completion: @escaping(Result<Leagues,Error>) -> Void) {
        
        let url = URL(string: "https://apiv2.allsportsapi.com/\(sport)/?met=Leagues&APIkey=\(apiKey)")
        AF.request(url!).validate().response{
            respon in
            switch respon.result{
            case .success(let data):
                do{
                    let jsonData = try JSONDecoder().decode(Leagues.self, from: data!)
                    print(jsonData.result[0].leagueName)
                    completion(.success(jsonData))
                } catch {
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
            case .failure(let error):
                print(error.localizedDescription)
                print("error ->> \(error)")
                completion(.failure(error))
            }
            
        }
    }
    
    
//    func fetchDataFromNetwork (sportType: String, apiMethodName: String) {
//        if let url = URL(string: "https://apiv2.allsportsapi.com/\(sportType)/?met=\(apiMethodName)&APIkey=\(apiKey)") {
//            let requset = URLRequest(url: url)
//            let session = URLSession(configuration: URLSessionConfiguration.default)
//            let task = session.dataTask(with: requset) { data, response, error in
//                do{
//                    let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! Dictionary<String,Any>
//                    let dataArray = jsonResponse["result"] as! Array<Dictionary<String,Any>>
//                    for item in dataArray{
//                        let leagueKey = item["league_key"] as! Int
//                        let leagueName = item["league_name"] as! String
//                        let leagueLogo = item["league_logo"] as? String
//
//                        let leagueModel = LeagueInfo(leagueKey: leagueKey, leagueName: leagueName, leagueLogo: leagueLogo ?? "0") as LeagueInfo
//                        print("League Name : -> \(leagueModel.leagueName)")
//                    }
//                    DispatchQueue.main.async {
//                        print("DispatchQueue\n")
//                        print("Returned to main thread")
//                    }
//                }catch{
//                    print(error.localizedDescription)
//                    print("ERROR!!!\n")
//                }
//            }
//            task.resume()
//        }
//    }
//
}
/*
 import Foundation
 import Alamofire

 class Network  {
     static let shared : Network = Network()
     let apiKey = "6c1c88500e41b80918d93cf0cf1dfaa81b7cb613452241ab62f48a103781099e"
     private  init() {
         
     }
     
     
     func fetchLeagues(sport:String,completion: @escaping(Result<LeagueDto,Error>) -> Void) {
         
         let url = URL(string: "https://apiv2.allsportsapi.com/\(sport)/?met=Leagues&APIkey=\(apiKey)")
         AF.request(url!).validate().response{
             respon in
             switch respon.result{
             case .success(let data):
                 do{
                     let jsonData = try JSONDecoder().decode(LeagueDto.self, from: data!)
                     print(jsonData.result?[0].country_name)
                     completion(.success(jsonData))
 //                    print(jsonData.result)
                     
                   
                 } catch {
                     print(error.localizedDescription)
                     completion(.failure(error))

                 }
             case .failure(let error):
                 print(error.localizedDescription)
                 completion(.failure(error))

             }
             
         }
     }
     
     func fetchFixtures(sport:String,from dateFrom:Date?,completion: @escaping(Result<FixturesResult,Error>) -> Void) {
         let dateFormatter = DateFormatter()
         dateFormatter.dateFormat = "yyyy-MM-dd"
         let currentDate = Date()
         let formattedDate = dateFormatter.string(from: currentDate)
         let fromDate = dateFormatter.string(from: dateFrom ?? currentDate)
         let url = URL(string: "https://apiv2.allsportsapi.com/\(sport)/?met=Fixtures&APIkey=\(apiKey)&from=\(fromDate)&to=\(formattedDate)")
         AF.request(url!).validate().response{
             respon in
             switch respon.result{
             case .success(let data):
                 do{
                     let jsonData = try JSONDecoder().decode(FixturesResult.self, from: data!)
                     print(jsonData.result?[0].country_name)
                     completion(.success(jsonData))
                     
 //                    print(jsonData.result)
                     
                   
                 } catch {
                     print(error.localizedDescription)
                     completion(.failure(error))

                 }
             case .failure(let error):
                 print(error.localizedDescription)
                 completion(.failure(error))

             }
             
         }
     }
 }
 */
