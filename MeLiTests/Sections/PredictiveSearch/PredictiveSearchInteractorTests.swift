//
//  PredictiveSearchInteractorTests.swift
//  MeLiTests
//
//  Created by Gerardo Tarazona Caceres on 21/09/20.
//  Copyright © 2020 Gerardo Tarazona Caceres. All rights reserved.
//

import XCTest
@testable import MeLi

class PredictiveSearchInteractorTests: XCTestCase {
    var sut: PredictiveSearchInteractor!
    var mockDataController: MockLocalDataController!
    var mockNetwork: MockNetwork!
    
    override func setUp() {
        super.setUp()
        mockNetwork = MockNetwork()
        mockDataController = MockLocalDataController()
        sut = PredictiveSearchInteractor(network: mockNetwork,
                                         dataController: mockDataController)
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
        mockNetwork = nil
        mockDataController = nil
    }
    
    func test_SearchTextSuccess() {
        let response = "{\r\n    \"q\": \"ren\",\r\n    \"suggested_queries\": [\r\n        {\r\n            \"q\": \"renault sandero\",\r\n            \"match_start\": 0,\r\n            \"match_end\": 3\r\n        } ]\r\n}\r\n"
        mockNetwork.mockData = response.data(using: .utf8)
        sut.searchText("text") { (result) in
            switch result {
            case .success(let suggestions):
                XCTAssert(suggestions.count > 0)
            case .failure:
                XCTFail("parsing should not failed")
            }
        }
    }
    
    func test_SearchTextFailure() {
        //Given
         let response = "Not Valid data"
         mockNetwork.mockData = response.data(using: .utf8)
        //When
         sut.searchText("text") { (result) in
             switch result {
             case .success:
                XCTFail("parsing should not failed")
             case .failure:
                //Then
                XCTAssert(true)
                  break
             }
         }
     }
    
    func test_searchTextLocally() {
        //Given
        let expectedSuggestions = ["suggestion"]
        let expectedResult: Result<[String], Error> = .success(expectedSuggestions)
        mockDataController.expectedResult = expectedResult
        //When
        let result = sut.searchTextLocally("Text")
        //Then
        guard case .success(let suggestions) = result,
        suggestions == expectedSuggestions else {
            XCTFail("The result should be success")
            return
        }
    }
    
    func test_searchTextLocallyFailure() {
        //Given
        let expectedResult: Result<[String], Error> = .failure(NetworkError.unknown)
        mockDataController.expectedResult = expectedResult
        //When
        let result = sut.searchTextLocally("Text")
        //Then
        guard case .failure = result else {
            XCTFail("The result should be success")
            return
        }
    }
    
    func test_bringAllSuggestions() {
        //Given
        let expectedSuggestions = ["suggestion"]
        let expectedResult: Result<[String], Error> = .success(expectedSuggestions)
        mockDataController.expectedResult = expectedResult
        //When
        let result = sut.bringAllSuggestions()
        //Then
        guard case .success(let suggestions) = result,
        suggestions == expectedSuggestions else {
            XCTFail("The result should be success")
            return
        }
    }
    
    func test_saveSuggestion() {
        //When
        sut.saveSuggestion(text: "Text")
        //Then
        XCTAssertTrue(mockDataController.saveSuggestionCalled)
    }
    
    class MockLocalDataController: LocalSuggestionDataControllerProtocol {
        var expectedResult: (Result<[String], Error>) = .failure(NetworkError.unknown)
        var expectedExistance: Bool = false
        var saveSuggestionCalled: Bool = false
        func saveSuggestion(_ text: String) {
            saveSuggestionCalled = true
        }
        
        func alreadyExists(_ text: String) -> Bool {
            expectedExistance
        }
        
        func bringAllLocalSuggestions() -> (Result<[String], Error>) {
            expectedResult
        }
        
        func searchTextLocally(_ text: String) -> (Result<[String], Error>) {
            expectedResult
        }
        
        
    }

    class MockNetwork: MeLiAPIProtocol {
        var mockData: Data? = nil
        func getRequest<T>(resource: NetworkResource<T>, completion: @escaping (Result<T, Error>) -> Void) -> URLSessionTask {
            completion(
                Result {
                    guard let data = mockData else {
                        throw NetworkError.noDataError
                    }
                    if let dataParsed = try? resource.parse(data) {
                        return dataParsed
                    } else {
                        throw NetworkError.unableToParse
                    }
                }
            )
            return FakeDataTask()
        }
    }
    
    class FakeDataTask: URLSessionTask {
        override init() { }
    }
    

    
}

