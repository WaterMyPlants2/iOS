//
//  WMP34Tests.swift
//  WMP34Tests
//
//  Created by Ezra Black on 6/22/20.
//  Copyright © 2020 Casanova Studios. All rights reserved.
//

import XCTest
@testable import WMP34

class WMP34Tests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLoginFailure() throws {
        let controller = UserController()
        let expectation = XCTestExpectation(description: "Could not log in Vincent")
        controller.loginUser(username: "vincent", password: "⚠️not Vincents password") { _ in
            XCTAssertFalse(controller.token != nil)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func testLoginSuccess() throws {
           let controller = UserController()
           let expectation = XCTestExpectation(description: "Logged in Vincent")
           controller.loginUser(username: "vincent", password: "12345") { _ in
               XCTAssertTrue(controller.token != nil)
               expectation.fulfill()
           }
           wait(for: [expectation], timeout: 10)
       }
    
    func testValidPlant() {
        let expectation = self.expectation(description: "Waiting for data")
        let controller = PlantController()
        let plant = Plant(nickname: "testplant", species: "fake", image: "testimage", h2ofrequency: "everyday")
        controller.deletePlantFromServer(plant: plant)
        controller.fetchPlantsFromServer()
        expectation.fulfill()
        XCTAssertTrue(controller.plants.count == 0)
        wait(for: [expectation], timeout: 10)
    }
    func testInvalidPlant() {
        let expectation = self.expectation(description: "Waiting for data")
               let controller = PlantController()
               let plant = Plant(nickname: "testplant", species: "fake", image: "testimage", h2ofrequency: "everyday")
               controller.deletePlantFromServer(plant: plant)
               controller.fetchPlantsFromServer()
               expectation.fulfill()
               XCTAssertFalse(controller.plants.count == 1)
               wait(for: [expectation], timeout: 10)
    }
    func testinValidLoginJSON() {
        let expectation = self.expectation(description: "TestingJSON")
        let dataLoader = MockDataLoader(data: registerRequest, error: nil, response: nil)
        let client = UserController(dataLoader: dataLoader)
        client.loginUser(username: "vincent", password: "12345")
        XCTAssertNil(client.token?.access_token)
        expectation.fulfill()
        wait(for: [expectation], timeout: 10)
    }
    
}
