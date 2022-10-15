//
//  ProductDetailViewModel_Tests.swift
//  BowlShopSwiftUI_Tests
//
//  Created by Baris OZGEN on 15.10.2022.
//

import XCTest
@testable import BowlShopSwiftUI

// import target with name
// Naming Structure : test_UnitOfWork_StateUnderTest_ExpectedBehavior
// Naming Structure : test_[struct or class]_[variable or function]_[expected result]

// Test Structure: Given, When, Then

final class ProductDetailViewModel_Tests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_ProductDetailViewModel_isAvailableInStock_shouldBeInjectedValue_stress() {
        for _ in 0..<100 {
            // Given
            let isAvailableInStock: Bool = Bool.random()
            
            // When
            let vm =  ProductDetailViewModel(isAvailableInStock: isAvailableInStock)
            
            // Then
            XCTAssertEqual(isAvailableInStock, vm.isAvailableInStock)
        }
    }
    
    func test_ProductDetailViewModel_dataArray_shouldBeEmpty() {
        // Given
         
        // When
        let vm =  ProductDetailViewModel(isAvailableInStock: Bool.random())

        // Then
        XCTAssertTrue(vm.dataArray.isEmpty)
        XCTAssertEqual(vm.dataArray.count, 0)

    }
    
    func test_ProductDetailViewModel_dataArray_shouldAddItems() {
        // Given
        let vm =  ProductDetailViewModel(isAvailableInStock: Bool.random())
 
        let loopAdd : Int = Int.random(in: 1..<100)
        
        // When
        for _ in 0..<loopAdd {
            let item : String = String(UUID().uuidString.prefix(Int.random(in: 1..<36)))//create random uuid string is always 36 characters
            vm.addItem(item: item)
        }
       
        // Then
        XCTAssertFalse(vm.dataArray.isEmpty)
        XCTAssertEqual(vm.dataArray.count, loopAdd)

    }
    
    func test_ProductDetailViewModel_dataArray_shouldNotAddBlankItem() {
        // Given
        let vm =  ProductDetailViewModel(isAvailableInStock: Bool.random())
 
        // When
        vm.addItem(item: "")
        
        // Then
        XCTAssertTrue(vm.dataArray.isEmpty)

    }
    
    func test_ProductDetailViewModel_selectedItem_shouldBeNilInTheBeginning() {
        // Given
 
        // When
        let vm =  ProductDetailViewModel(isAvailableInStock: Bool.random())

        // Then
        XCTAssertNil(vm.selectedItem)

    }
    
    func test_ProductDetailViewModel_selectedItem_shouldBeNilWhenSelectingInvalidItem() {
        // Given
        let vm =  ProductDetailViewModel(isAvailableInStock: Bool.random())

        // When
        
        // select valid item first
        let item : String = String(UUID().uuidString.prefix(Int.random(in: 1..<36)))
        vm.addItem(item: item)
        vm.selectItem(item: item)
        
        // select invalid item
        vm.selectItem(item: UUID().uuidString)
        
        // Then
        XCTAssertNil(vm.selectedItem)

    }
    
    func test_ProductDetailViewModel_selectedItem_shouldBeSelectedWhenItemFound() {
        // Given
        let vm =  ProductDetailViewModel(isAvailableInStock: Bool.random())

        // When
        let item : String = String(UUID().uuidString.prefix(Int.random(in: 1..<36)))
        vm.addItem(item: item)
        vm.selectItem(item: item)
        // Then
        XCTAssertNotNil(vm.selectedItem)
        XCTAssertEqual(vm.selectedItem, item)
    }
    
    func test_ProductDetailViewModel_selectedItem_shouldBeSelectedWhenItemFound_stress() {
        // Given
        let vm =  ProductDetailViewModel(isAvailableInStock: Bool.random())
        let loopAdd : Int = Int.random(in: 1..<100)

        // When
        var itemArray : [String] = []
        
        for _ in 0..<loopAdd {
            let item : String = String(UUID().uuidString.prefix(Int.random(in: 1..<36)))
            vm.addItem(item: item)
            itemArray.append(item)
        }
        
        let randomItem = itemArray.randomElement() ?? ""
        vm.selectItem(item: randomItem)
        
        // Then
        XCTAssertNotNil(vm.selectedItem)
        XCTAssertEqual(vm.selectedItem, randomItem)
    }
}
