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
                    XCTAssertNotNil(teams.result)
                case .failure(_):
                    XCTFail("Failed")
            }
        })
    }

}
