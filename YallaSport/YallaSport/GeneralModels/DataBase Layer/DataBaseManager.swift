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
protocol CoreDataProtocol {
    static func addLeague(league: LeagueInfo)
    static func fetchLeaguesFromDB () -> [League]
    static func deleteLeagueItem(league: League)
    static func getAllLeagues()->[LeagueInfo]
    static func deleteDataFromCoreData()
    //
    static func addTeam(team : TeamsResult )
    static func fetchTeamsFromDB () -> [TeamsDB]
}

class DataBaseManager:CoreDataProtocol {
    
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
    
    
    
    static func getAllLeagues()->[LeagueInfo]{
        var leagues:[LeagueInfo] = []
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest<NSFetchRequestResult>()
        
        fetchRequest.entity = NSEntityDescription.entity(forEntityName: "League", in: context)
        
        do{
            let fetchedLeagues = try context.fetch(fetchRequest) as! [League]
            for leagueItem in fetchedLeagues {
                if let leagueName = leagueItem.league_name {
                    let leagueKey = Int(truncating: leagueItem.league_key ?? 0)
                    print("league key from cd->",leagueItem.league_key)
                    var logoString: String?
                    if let logoData = leagueItem.league_logo {
                        logoString = String(data: logoData, encoding: .utf8)
                    }
                    let league = LeagueInfo(league_key: leagueKey, league_name: leagueName,league_logo: logoString)
                    leagues.append(league)
                }
            }
        }catch{
            print(error)
        }
        return leagues
    }
    
    static func deleteDataFromCoreData(){
        do{
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "League")
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            try context.execute(deleteRequest)
            try context.save()
        }catch let err{
            print("ERROR=======>\n")
            print(err.localizedDescription)
        }
    }
    
    //insert , delete and fetch teams
    static func addTeam(team: TeamsResult) {
        
        guard let entity = NSEntityDescription.entity(forEntityName: "TeamsDB", in: context) else {
                  print("Entity is nil")
                  return
              }

              let myLeague = NSManagedObject(entity: entity, insertInto: context)

        myLeague.setValue(team.team_name, forKey: "team_name")
        myLeague.setValue(team.team_key, forKey: "team_key")
             
        if let logoURLString = team.team_logo,
                 let url = URL(string: logoURLString) {
                  let task = URLSession.shared.dataTask(with: url) { data, response, error in
                      guard let data = data else {
                          print("Error downloading image:", error?.localizedDescription ?? "Unknown error")
                          return
                      }
                      myLeague.setValue(data, forKey: "team_logo")
                      contextSave()
                  }
                  task.resume()
              } else {
                  contextSave()
                  print("Invalid URL or nil logo URL provided")
              }
    }
    
    
    static func fetchTeamsFromDB() -> [TeamsDB] {
        let fetchRequest = NSFetchRequest<TeamsDB>(entityName: "TeamsDB")
        do{
            let teams = try context.fetch(fetchRequest)
            return teams
        }catch let error as NSError{
            print("Error in Fetching Leagues : ",error)
        }
        return []
    }
    
    static func deleteTeamItem(team: TeamsDB) {
                let fetchRequest: NSFetchRequest<TeamsDB> = TeamsDB.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "team_key == %@", team.team_key!)
                do {
                    let fetchedTeams = try context.fetch(fetchRequest)
                    guard let teamEntityToDelete = fetchedTeams.first else {
                        print("League not found in database")
                        return
                    }
                    context.delete(teamEntityToDelete)
                    contextSave()
                    print("League item deleted successfully")
                } catch {
                    print("Error deleting league item: \(error)")
                }
        }
    
    static func deleteAllTeamsFromCoreData(){
        do{
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "TeamsDB")
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            try context.execute(deleteRequest)
            try context.save()
        }catch let err{
            print("ERROR=======>\n")
            print(err.localizedDescription)
        }
    }
    
    
    
}

