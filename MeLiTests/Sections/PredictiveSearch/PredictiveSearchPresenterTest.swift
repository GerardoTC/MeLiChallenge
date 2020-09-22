//
//  PredictiveSearchPresenterTest.swift
//  MeLiTests
//
//  Created by Gerardo Tarazona Caceres on 21/09/20.
//  Copyright © 2020 Gerardo Tarazona Caceres. All rights reserved.
//

import XCTest
@testable import MeLi

class PredictiveSearchPresenterTest: XCTestCase {
    var sut: PredictiveSearchPresenter!
    var mockRouter: MockPredictiveSearchRouter!
    var mockView: MockPredictiveSearchView!
    var mockInteractor: MockPredictiveSearchInteractor!
    var fakeDebouncer: TextDebouncer!
    var mockErrorRouter: ErrorHandlingRouter!
    
    override func setUp() {
        super.setUp()
        fakeDebouncer = TextDebouncer(timeInterval: 0.0)
        sut = PredictiveSearchPresenter(debouncer: fakeDebouncer)
        mockView = MockPredictiveSearchView()
        mockRouter = MockPredictiveSearchRouter()
        mockInteractor = MockPredictiveSearchInteractor()
        sut.view = mockView
        sut.router = mockRouter
        sut.interactor = mockInteractor
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
        mockView = nil
        mockRouter = nil
        mockInteractor = nil
    }
    
    func test_viewDidLoad() {
        //Given
        mockInteractor.expectedResult = .success(["value1"])
        //When
        sut.viewDidLoad()
        //Then
        XCTAssertEqual(mockInteractor.calledActions, [.bringAllSuggestions])
        XCTAssertEqual(mockView.calledActions, [.focusOnSearchText, .refreshView])
    }
    
    func test_textDidChangeNil() {
        //When
        sut.textDidChange(nil)
        //Then
        XCTAssertEqual(mockInteractor.calledActions, [])
    }

    func test_textDidChangeEmpty() {
        //Given
        let text = String()
        //When
        sut.textDidChange(text)
        fakeDebouncer.closure?(text)
        //Then
        XCTAssertEqual(mockInteractor.calledActions, [.bringAllSuggestions])
        XCTAssertEqual(mockView.calledActions, [.refreshView])
    }
    
    func test_textDidChangeValidValue() {
        //Given
        let text = "Search Value"
        mockInteractor.expectedResult = .success(["Suggestion 1"])
        //When
        sut.textDidChange(text)
        fakeDebouncer.closure?(text)
        //Then
        XCTAssertEqual(mockInteractor.calledActions, [.searchText,
                                                      .searchTextLocally])
        XCTAssertEqual(mockView.calledActions, [.refreshView, .refreshView])
    }
    
    func test_numberOfRowsInLocalSuggestionSection() {
        //Given
        sut.localSuggestions = ["value1","value2"]
        //When
        let rows = sut.numberOfRowsInSection(section: 0)
        //Then
        XCTAssertEqual(rows, 2)
    }
    
    func test_numberOfRowsInSuggestionSection() {
        //Given
        sut.suggestions = ["value1","value2"]
        //When
        let rows = sut.numberOfRowsInSection(section: 1)
        //Then
        XCTAssertEqual(rows, 2)
    }
    
    func test_suggestionAtIndexLocalSuggestion() {
        //Given
        sut.localSuggestions = ["value1"]
        //When
        let suggestion = sut.suggestion(at: 0, section: 0)
        //Then
        XCTAssertEqual(suggestion, sut.localSuggestions[0])
    }
    
    func test_suggestionAtIndexSuggestions() {
        //Given
        sut.suggestions = ["value1"]
        //When
        let suggestion = sut.suggestion(at: 0, section: 1)
        //Then
        XCTAssertEqual(suggestion, sut.suggestions[0])
    }
    
    func test_didSelectLocalSuggestion() {
        //Given
        sut.localSuggestions = ["value1"]
        //When
        sut.didSelectSuggestion(index: 0, section: 0)
        //Then
        XCTAssertEqual(mockRouter.calledActions, [.dismissViewWithText])
    }
    
    func test_didSelectSuggestion() {
        //Given
        sut.suggestions = ["value1"]
        //When
        sut.didSelectSuggestion(index: 0, section: 1)
        //Then
        XCTAssertEqual(mockInteractor.calledActions, [.saveSuggestion])
        XCTAssertEqual(mockRouter.calledActions, [.dismissViewWithText])
    }
    
    func test_searchBarClicked() {
        //When
        sut.searchButtonClicked(text: "value")
        //Then
        XCTAssertEqual(mockInteractor.calledActions, [.saveSuggestion])
        XCTAssertEqual(mockRouter.calledActions, [.dismissViewWithText])
    }
    
    func test_cancelButtonPressed() {
        //When
        sut.cancelButtonPressed()
        //Then
        XCTAssertEqual(mockRouter.calledActions, [.dismissView])
    }
        
    class MockPredictiveSearchInteractor: PredictiveSearchInteractorProtocol {
        
        var calledActions: [CalledAction] = []
        var expectedResult: Result<[String], Error> = .failure(NetworkError.unknown)
        enum CalledAction {
            case searchText
            case searchTextLocally
            case saveSuggestion
            case bringAllSuggestions
        }
        
        func searchText(_ text: String, completion: @escaping (Result<[String], Error>) -> Void) {
            calledActions.append(.searchText)
            completion(expectedResult)
        }
        
        func searchTextLocally(_ text: String) -> Result<[String], Error> {
            calledActions.append(.searchTextLocally)
            return expectedResult
        }
        
        func saveSuggestion(text: String) {
            calledActions.append(.saveSuggestion)
        }
        
        func bringAllSuggestions() -> Result<[String], Error> {
            calledActions.append(.bringAllSuggestions)
            return expectedResult
        }
        
        
    }
    
    class MockPredictiveSearchView: PredictiveSearchViewProtocol {
        var presenter: PredictiveSearchPresenterProtocol?
        
        var calledActions: [CalledAction] = []
        
        enum CalledAction {
            case focusOnSearchText
            case refreshView
        }
        
        func focusOnSearchText() {
            calledActions.append(.focusOnSearchText)
        }
        
        func refreshView() {
            calledActions.append(.refreshView)
        }
        
        
    }
    
    class MockPredictiveSearchRouter: PredictiveSearchRouterProtocol {
        var viewController: UIViewController?
        var predictiveDelegate: PredictiveResultDelegate?
        var calledActions: [CalledAction] = []
        
        enum CalledAction {
            case dismissView
            case dismissViewWithText
        }
        
        static func buildPredictiveSearchSection(delegate: PredictiveResultDelegate) -> PredictiveSearchVC {
            return PredictiveSearchVC()
        }
        
        func dismissView(withText: String) {
            calledActions.append(.dismissViewWithText)
        }
        
        func dismissView() {
            calledActions.append(.dismissView)
        }
    }
}
