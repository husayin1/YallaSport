//
//  Network.swift
//  YallaSport
//
//  Created by husayn on 22/04/2024.
//

import Foundation
import Alamofire
class Network : NetworkLayerProtocol{
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
    
    func fetchDataFromNetwork (sportType: String, apiMethodName: String) {
        if let url = URL(string: "https://apiv2.allsportsapi.com/\(sportType)/?met=\(apiMethodName)&APIkey=\(apiKey)") {
            let requset = URLRequest(url: url)
            let session = URLSession(configuration: URLSessionConfiguration.default)
            let task = session.dataTask(with: requset) { data, response, error in
                do{
                    let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! Dictionary<String,Any>
                    let dataArray = jsonResponse["result"] as! Array<Dictionary<String,Any>>
                    for item in dataArray{
                        let leagueKey = item["league_key"] as! Int
                        let leagueName = item["league_name"] as! String
                        let leagueLogo = item["league_logo"] as? String
                        
                        let leagueModel = LeagueInfo(leagueKey: leagueKey, leagueName: leagueName, leagueLogo: leagueLogo ?? "0") as LeagueInfo
                        print("League Name : -> \(leagueModel.leagueName)")
                    }
                    DispatchQueue.main.async {
                        print("DispatchQueue\n")
                        print("Returned to main thread")
                    }
                }catch{
                    print(error.localizedDescription)
                    print("ERROR!!!\n")
                }
            }
            task.resume()
        }
    }
    
}
