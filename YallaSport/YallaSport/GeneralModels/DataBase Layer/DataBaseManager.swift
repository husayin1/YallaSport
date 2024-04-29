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
    
    private static func contextSave() {
         do {
             try DataBaseManager.context.save()
             print("League item saved successfully")
         } catch {
             print("Error saving league item: \(error)")
         }
     }

    
    
    static func addLeague(league: LeagueInfo) {
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
                      contextSave()
                  }
                  task.resume()
              } else {
                  contextSave()
                  print("Invalid URL or nil logo URL provided")
              }
    }
    
    
    static func fetchLeaguesFromDB () -> [League]{
        
        let fetchRequest = NSFetchRequest<League>(entityName: "League")
        do{
            let leagues = try context.fetch(fetchRequest)
            return leagues
        }catch let error as NSError{
            print("Error in Fetching Leagues : ",error)
        }
        return []
    }
    
    static func deleteLeagueItem(league: League) {
                let fetchRequest: NSFetchRequest<League> = League.fetchRequest()
                fetchRequest.predicate = NSPredicate(format: "league_key == %@", league.league_key!)
                do {
                    let fetchedLeagues = try context.fetch(fetchRequest)
                    guard let leagueEntityToDelete = fetchedLeagues.first else {
                        print("League not found in database")
                        return
                    }
                    context.delete(leagueEntityToDelete)
                    contextSave()
                    print("League item deleted successfully")
                } catch {
                    print("Error deleting league item: \(error)")
                }
        }
    
}

