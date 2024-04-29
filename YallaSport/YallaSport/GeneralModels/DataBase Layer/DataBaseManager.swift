//
//  DataBaseManager.swift
//  YallaSport
//
//  Created by marwa on 27/04/2024.
//

import Foundation
import UIKit
import CoreData
import SDWebImage

let appDelegate = UIApplication.shared.delegate as! AppDelegate

class DataBaseManager {
    
    private static var context = appDelegate.persistentContainer.viewContext
    private static let entity = NSEntityDescription.entity(forEntityName: "League", in: context)
    
    
//    static func addLeague (league : LeagueInfo){
//        //managed obj
//        let myLeague = NSManagedObject(entity: entity!, insertInto: context)
//
//        guard let urlStr = URL(string: league.league_logo ?? "https://purepng.com/public/uploads/large/purepng.com-league-of-legends-old-logoleague-of-legendslogooldoutdated-331523980009wndgt.png")   else{print("Invalid URL")
//            return
//        }
//        SDWebImageDownloader.shared.downloadImage(with: urlStr) { image, data, error, _ in
//            guard let imageData = data else {
//                print("Error downloading image:", error?.localizedDescription ?? "Unknown error")
//                return
//            }
//            myLeague.setValue(image, forKey: "league_logo")
//        }
//
//    //
//            myLeague.setValue(league.league_key, forKey: "league_key")
//            //myLeague.setValue(league.league_logo, forKey: "league_logo")
//            myLeague.setValue(league.league_name, forKey: "league_name")
//
//            do {
//                print("saving League Done")
//                try context.save()
//            }catch let error as NSError{
//                print("Error in saving League : ",error)
//            }
//        }
//
    
    static func addLeague(league: LeagueInfo , sportName : String) {
        guard let entity = NSEntityDescription.entity(forEntityName: "League", in: context) else {
                  print("Entity is nil")
                  return
              }

              let myLeague = NSManagedObject(entity: entity, insertInto: context)

              myLeague.setValue(league.league_key, forKey: "league_key")
              myLeague.setValue(league.league_name, forKey: "league_name")
             
              if let logoURLString = league.league_logo,
                 let url = URL(string: logoURLString) {
                  let task = URLSession.shared.dataTask(with: url) { data, response, error in
                      guard let data = data else {
                          print("Error downloading image:", error?.localizedDescription ?? "Unknown error")
                          return
                      }
                      myLeague.setValue(data, forKey: "league_logo")

                      do {
                          try context.save()
                          print("League saved successfully")
                      } catch {
                          print("Error saving league:", error.localizedDescription)
                      }
                  }
                  task.resume()
              } else {
                  print("Invalid URL or nil logo URL provided")
              }
    }
    
    static func fetchLeaguesFromDB () -> [League]{
        
        var fetchRequest = NSFetchRequest<League>(entityName: "League")
        do{
            let leagues = try context.fetch(fetchRequest)
            return leagues
        }catch let error as NSError{
            print("Error in Fetching Leagues : ",error)
        }
        return []
    }
    
}

