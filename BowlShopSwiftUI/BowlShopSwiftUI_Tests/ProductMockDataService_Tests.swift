//
//  ProductMockDataService_Tests.swift
//  BowlShopSwiftUI_Tests
//
//  Created by Baris OZGEN on 16.10.2022.
//

import XCTest
@testable import BowlShopSwiftUI
import Combine

// import target with name
// Naming Structure : test_UnitOfWork_StateUnderTest_ExpectedBehavior
// Naming Structure : test_[struct or class]_[variable or function]_[expected result]

// Test Structure: Given, When, Then

final class ProductMockDataService_Tests: XCTestCase {
    
    var cancellables = Set<AnyCancellable>()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        cancellables.removeAll()
    }
    
    func test_ProductMockDataService_init_doesSetValuesCorrectly(){
        // Given
        let products : [String]? = nil
        let products2 : [String]? = []
        let products3 : [String]? = [UUID().uuidString,UUID().uuidString,UUID().uuidString,]
        
        // When
        let dataService = ProductMockDataService(products: products)
        let dataService2 = ProductMockDataService(products: products2)
        let dataService3 = ProductMockDataService(products: products3)
        
        // Then
        XCTAssertFalse(dataService.products.isEmpty)
        XCTAssertTrue(dataService2.products.isEmpty)
        XCTAssertEqual(dataService3.products.count, products3?.count)
    }
    
    func test_ProductMockDataService_downloadWithEscaping_doesReturnValues(){
        // Given
        let dataService = ProductMockDataService(products: nil)
        
        // When
        var products : [String] = []
        let expectation = XCTestExpectation(description: "default values should return when it is nil")
        
        dataService.downloadProductsWithEscaping { returnedProducts in
            products = returnedProducts
            expectation.fulfill()
        }
        
        // Then
        wait(for: [expectation], timeout: 3 )
        XCTAssertEqual(products.count, dataService.products.count)
    }
    
    func test_ProductMockDataService_downloadWithCombine_doesReturnValues(){
        // Given
        let dataService = ProductMockDataService(products: nil)
        
        // When
        var products : [String] = []
        let expectation = XCTestExpectation(description: "default values should return when it is nil")
        
        dataService.downloadProductsWithCombine()
            .sink { completion in
                switch completion {
                case .finished:
                    expectation.fulfill()
                    
                case .failure(let error):
                    XCTFail(error.localizedDescription )
                   
                }
            } receiveValue: { returnedProducts in
                products = returnedProducts
             }
            .store(in: &cancellables)
        
        // Then
        wait(for: [expectation], timeout: 3 )
        XCTAssertEqual(products.count, dataService.products.count)
    }
    
    func test_ProductMockDataService_downloadWithCombine_doesFail(){
        // Given
        let dataService = ProductMockDataService(products: [])
        
        // When
        var products : [String] = []
        let expectation = XCTestExpectation(description: "it should be empty when it is blank array")
        let expectation2 = XCTestExpectation(description: "it should throw badServerResponse empty when it is blank array")

        dataService.downloadProductsWithCombine()
            .sink { completion in
                switch completion {
                case .finished:
                    XCTFail(expectation.expectationDescription)
                case .failure(let error):
                    expectation.fulfill()
                    
                    let urlError = error as? URLError
                    XCTAssertEqual(urlError, URLError(.badServerResponse))
                   
                    if urlError == URLError(.badServerResponse) {
                        expectation2.fulfill()
                    }

                }
            } receiveValue: { returnedProducts in
                products = returnedProducts
             }
            .store(in: &cancellables)
        
        // Then
        wait(for: [expectation, expectation2], timeout: 3 )
        XCTAssertEqual(products.count, dataService.products.count)
    }
}
