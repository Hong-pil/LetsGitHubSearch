//
//  CodeSquad_GithubSearchTests.swift
//  CodeSquad_GithubSearchTests
//
//  Created by kimhongpil on 6/13/24.
//

import XCTest
import ComposableArchitecture
@testable import CodeSquad_GithubSearch

final class CodeSquad_GithubSearchTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    @MainActor
    func testFeature() async {
        
//        // Arrange
//        // TestStore를 생성합니다.
//        let store = TestStore(initialState: RepoSearch.State()) {
//            RepoSearch()
//        }
//        
//        // Act & Assert
//        // 1. "Swift"를 입력했을 때, state.keyword가 "Swift"인지 테스트합니다.
//        await store.send(.keywordChanged("Swift")) {
//            $0.keyword = "Swift"
//        }
//        
//        // 2. 검색을 했을 때, 예상하는 검색 결과가 나오는지를 테스트합니다.
//        await store.send(.search) {
//            $0.searchResults = [
//                "Swift",
//                "SwiftyJSON",
//                "SwiftGuide",
//                "SwiftterSwift",
//            ]
//        }
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
