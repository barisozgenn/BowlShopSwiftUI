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
    var userHasAddressAndPaymentMethod : Bool = false
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launchArguments = ["-UITest_userLogin"]
        
        // user saved address and payment info?
        userHasAddressAndPaymentMethod = (app.launchEnvironment["-UITest_userHasAddress"] == "true" ? true : false ) && (app.launchEnvironment["-UITest_userHasPaymentMethod"] == "true" ? true : false )
        
        app.launch()
    }
    
    override func tearDownWithError() throws {
    }
    
    func test_CartView_payButton_shouldPaymentProcesStartIfTheyHaveAddressAndPaymentMethod() {
        addCartSteps()
        
        sleep(1)
        
        typeDeliveryNote(note: "Delivery note will be written here…")
        
        sleep(1)
        
        paymentProcess(canProcessStart: userHasAddressAndPaymentMethod)
    }
    
    
}

// MARK: Functions
extension CartView_UITests {
    
    func addCartSteps(){
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
    }
    
    func paymentProcess(canProcessStart: Bool){
        
        app.scrollViews["cardViewPageBottom"].otherElements.buttons["payButton"].tap()
        sleep(1)
        
        if !canProcessStart {
            let alert = app.alerts["OPPS!"].scrollViews.otherElements
            let alertButton = alert.buttons["OK"]
            
            let alertButtonExist = alertButton.waitForExistence(timeout: 3)
            XCTAssertTrue(alertButtonExist)
            
            alertButton.tap()
            sleep(1)
            XCTAssertFalse(alert.element.exists)
            sleep(1)
            let cardViewPageBottom = app.windows.children(matching: .other).element(boundBy: 1).children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .image).matching(identifier: "cardViewPageBottom").element(boundBy: 0)
            
            cardViewPageBottom.swipeDown()
        }
        else {
            let paymentStatus = app.images["Card"]
            let paymentStatusExist = paymentStatus.waitForExistence(timeout: 3)
            XCTAssertTrue(paymentStatusExist)
        }
        
    }
    
    func typeDeliveryNote(note: String){
        let deliveryNoteTextField = app.scrollViews["cardViewPageBottom"].otherElements.textFields["Delivery Note"]
        sleep(2)
        deliveryNoteTextField.tap()
        sleep(3)
        deliveryNoteTextField.typeText(note)
        sleep(5)
        let returnButton = app.buttons["Return"]
        returnButton.tap()
    }
    
}
