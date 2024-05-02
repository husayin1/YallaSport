//
//  YallaSportTests.swift
//  YallaSportTests
//
//  Created by husayn on 22/04/2024.
//

import XCTest
@testable import YallaSport

final class YallaSportTests: XCTestCase {
    
    var networkMockObj : MockingNetworkProtocol?

    override func setUpWithError() throws {
        networkMockObj = MockNetwork(isError: false)
 
    }

    override func tearDownWithError() throws {
        networkMockObj = nil

    }

    func testExample() throws {

    }

    func testFetchLeagues(){
        let expect = expectation(description: "test Fetch Leagues from network")
        
        Network.fetchLeagues(sportType: "football") { result in
            switch result{
            case .success(let teams) :
                XCTAssertNotNil(teams.result)
                expect.fulfill()
            case .failure(_):
                XCTFail("Failed")
                expect.fulfill()
            }
        }
        waitForExpectations(timeout: 5)
    }
    
    
    func testFetchLeaguesFromOriginalNetworkError(){
        let leaguesExpectation = expectation(description: "Waiting For Leagues")
        Network.fetchLeagues(sportType: "footboooll"){
            fetchedLeagues in
            switch fetchedLeagues {
            case .success(let leagues):
                XCTAssertNotNil(leagues.result)
                leaguesExpectation.fulfill()
            case .failure(let err):
                XCTFail("Network Error,->\n\(err)")
                leaguesExpectation.fulfill()
            }
            
        }
        waitForExpectations(timeout: 5)
        
    }
    
    func testFetchTeamsFromOriginalNetworkError(){
        let teamsExpectation = expectation(description: "Waiting For Teams")
        Network.fetchTeamsFromNetwork(sportType: "fotball", leagueId: "175"){
            fetchedTeams in
            switch fetchedTeams {
            case .success(let teams):
                XCTAssertFalse(teams.result?.count == 0)
                teamsExpectation.fulfill()
            case .failure(let err):
                XCTFail("Network Error, ->\(err)")
                teamsExpectation.fulfill()
            }
            
        }
        waitForExpectations(timeout: 5)
        
    }
    

    
    
    func testFetchMockLeagues(){
        networkMockObj?.fetchLeagues(sportType: "football", completionHandler: { result  in
            switch result{
            case .success(let leagues) :
                XCTAssertNotNil(leagues.result)
                
            case .failure(_):
                XCTFail("Failed")
            }
        })
        
    }
   
    func testFetchFixturesFromOriginalNetworkError(){
        let fixturesExpectation = expectation(description: "Waiting For Fixtures")
        Network.fetchFixtures(sportType: "googlooo", leagueID: "175", from: "2024-04-25", to: "2024-05-2"){
            fetchedFixtures in
            switch fetchedFixtures {
            case .success(let fixtures):
                XCTAssertGreaterThan(fixtures.result?.count ?? 0, 0)
                fixturesExpectation.fulfill()
            case .failure(let err):
                XCTFail("Network Error,->\(err)")
                fixturesExpectation.fulfill()
            }
            
        }
        waitForExpectations(timeout: 5)
        
    }
    func testFetchFixturesFromOriginalNetwork(){
        let fixturesExpectation = expectation(description: "Waiting For Fixtures")
        Network.fetchFixtures(sportType: "football", leagueID: "175", from: "2024-04-25", to: "2024-05-2"){
            fetchedFixtures in
            switch fetchedFixtures {
            case .success(let fixtures):
                XCTAssertGreaterThan(fixtures.result?.count ?? 0, 0)
                fixturesExpectation.fulfill()
            case .failure(let err):
                XCTFail("Network Error,->\(err)")
                fixturesExpectation.fulfill()
            }
            
        }
        waitForExpectations(timeout: 5)
        
    }
    
    func testFetchFixturesFromMokedData(){
        networkMockObj?.fetchFixtures(sportType: "football", leagueID: "175", from: "2024-04-30", to: "2024-05-02"){
            fetchResult in
            switch fetchResult {
            case .success(let fixtures):
                XCTAssertTrue(fixtures.result?.count == 1)
            case .failure(let err):
                XCTFail("Wrong Json->\(err)")
            }
        }
    }
  
    
    
    func testFetchTeams(){
        let expect = expectation(description: "test Fetch Teams from network")
        Network.fetchTeamsFromNetwork(sportType: "football", leagueId: "96") { result in
            switch result{
            case .success(let teams) :
                XCTAssertNotNil(teams.result)
            //    XCTAssertEqual(teams.result?[0].players?[0].player_key,3063582184)
                expect.fulfill()
            case .failure(_):
                XCTFail("Failed")
            }
        }
        waitForExpectations(timeout: 5)
    }
    
    func testFetchMockTeams (){
        networkMockObj?.fetchTeamsFromNetwork(sportType: "football", leagueId: "96", completionHnadler: { result in
            switch result {
                case .success(let teams) :
                XCTAssertTrue(teams.success == 1)
                case .failure(_):
                    XCTFail("Failed")
            }
        })
    }

}
