//
//  NewsAppTests.swift
//  NewsAppTests
//
//  Created by Luciano Uchoa on 13/05/24.
//

import XCTest
@testable import NewsApp

final class NewsAppTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
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
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    // Teste para verificar se os artigos são recuperados corretamente
    func testFetchArticles() {
        // Crie uma instância do NewsService
        let newsService = NewsService.shared
        
        // Defina a expectativa
        let expectation = XCTestExpectation(description: "Artigos recuperados com sucesso")
        
        // Chame o método fetchArticles com uma palavra-chave
        newsService.fetchArticles(keyword: "apple") { (articles, error) in
            // Verifique se não há erro
            XCTAssertNil(error)
            // Verifique se os artigos foram recuperados com sucesso
            XCTAssertNotNil(articles)
            // Complete a expectativa
            expectation.fulfill()
        }
        
        // Aguarde a expectativa ser cumprida
        wait(for: [expectation], timeout: 5.0)
    }
    
}
