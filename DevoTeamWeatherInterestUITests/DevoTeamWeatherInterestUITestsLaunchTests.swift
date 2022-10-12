//  ----------------------------------------------------
//
//  DevoTeamWeatherInterestUITestsLaunchTests.swift
//  Version 1.0
//
//  Unique ID:  24239E6D-8DF5-495D-8494-48752EA0CFF1
//
//  part of the DevoTeamWeatherInterestUITests™ product.
//
//  Written in Swift 5.0 on macOS 12.6
//
//  https://github.com/coldpointblue
//  Created by Hugo Diaz on 12/10/22.
//  
//  ----------------------------------------------------

//  ----------------------------------------------------
/*  Goal explanation:  (whole app does? … for users)   */
//  ----------------------------------------------------


import XCTest

final class DevoTeamWeatherInterestUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
