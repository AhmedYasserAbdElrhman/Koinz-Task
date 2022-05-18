//
//  NetworkManagerTests.swift
//  Koinz-TaskTests
//
//  Created by Ahmad Yasser on 18/05/2022.
//

import XCTest
@testable import Koinz_Task

class NetworkManagerTests: XCTestCase {

    var sut: NetworkManager!
    override func setUpWithError() throws {
        sut = NetworkManager()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
        
    func testNetworkManager_WhenCallSearch_SearchRequestCalled() {
        // Arrange
        let page = 1
        let defaultTimeOut: TimeInterval = 60
        let expectation = self.expectation(description: "Search Request Expectation")
        // Act
        sut.search(page: page) {
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: defaultTimeOut)
        
        // Assert
        XCTAssert(sut.searchCalled)
        
        
    }
}
