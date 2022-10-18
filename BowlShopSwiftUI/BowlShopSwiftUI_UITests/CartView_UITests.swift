//
//  CartView_UITests.swift
//  BowlShopSwiftUI_UITests
//
//  Created by Baris OZGEN on 17.10.2022.
//

import XCTest
// import target with name
// Naming Structure : test_UnitOfWork_StateUnderTest_ExpectedBehavior
// Naming Structure : test_[struct]_[ui component]_[expected result]

// Test Structure: Given, When, Then
final class CartView_UITests: XCTestCase {

    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }

    override func tearDownWithError() throws {
    }

    func test_CartView_payButton_shouldNotPayWithoutAddressAndPaymentMethod() {
       
        
        let app = XCUIApplication()
        let imagestabviewCollectionView = app.collectionViews["imagesTabView"]
        sleep(1)
        imagestabviewCollectionView/*@START_MENU_TOKEN@*/.images["image1"]/*[[".cells.images[\"image1\"]",".images[\"image1\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeLeft()
        sleep(1)
        imagestabviewCollectionView/*@START_MENU_TOKEN@*/.images["image2"]/*[[".cells.images[\"image2\"]",".images[\"image2\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeRight()
        app.images["fish.fill"].tap()
        sleep(1)
        app.scrollViews.otherElements.staticTexts["Seafood"].tap()
        
        sleep(1)
        let smokedSalmonPokeBowlImage = XCUIApplication().windows.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .image)["smoked-salmon-poke-bowl"]
        smokedSalmonPokeBowlImage.swipeUp()
        sleep(UInt32(1.5))
        smokedSalmonPokeBowlImage.swipeDown()
              
        sleep(1)
        app.buttons["addToCartButton"].tap()
        app.windows.children(matching: .other).element(boundBy: 1).children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .image).matching(identifier: "cardViewPageBottom").element(boundBy: 1).swipeUp()
        sleep(1)
         let deliveryNoteTextField = app.scrollViews["cardViewPageBottom"].otherElements.textFields["deliveryNoteTextField"]
        deliveryNoteTextField.tap()
        deliveryNoteTextField.tap()
        let deliveryNoteText = "Delivery note will be written here…"
        sleep(1)
        for chr in Array(deliveryNoteText) {
            sleep(UInt32(0.5))
            let fKey = app/*@START_MENU_TOKEN@*/.keys["f"]/*[[".keyboards.keys[\"f\"]",".keys[\"f\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
            fKey.tap()
            fKey.tap()
        }
        
                        
        let returnButton = app.buttons["Return"]
        returnButton.tap()
        sleep(1)
        app.scrollViews["cardViewPageBottom"].otherElements.buttons["payButton"].tap()
        
        let alert = app.alerts["OPPS!"].scrollViews.otherElements
        let alertButton = alert.buttons["OK"]
        sleep(1)
        XCTAssertTrue(alert.element.exists)
        sleep(1)
        alertButton.tap()
        sleep(1)
        XCTAssertFalse(alert.element.exists)
        sleep(1)
       let cardViewPageBottom = app.windows.children(matching: .other).element(boundBy: 1).children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .image).matching(identifier: "cardViewPageBottom").element(boundBy: 0)
      
        cardViewPageBottom.swipeDown()
                
                        
       
    }
    func test_CartView_payButton_shouldPayWithoutAddressAndPaymentMethod() {
       
    }
}
