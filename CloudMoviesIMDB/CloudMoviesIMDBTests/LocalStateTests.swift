//
//  LocalStateTests.swift
//  CloudMoviesIMDBTests
//
//  Created by Artem Bilyi on 03.05.2023.
//

import XCTest
@testable import CloudMoviesIMDB

final class LocalStateTests: XCTestCase {
    
    func testHasOnboardedDefault() {
        UserDefaults.standard.removeObject(forKey: LocalState.Keys.hasOnboarded.rawValue)
        let hasOnboarded = LocalState.hasOnboarded
        XCTAssertFalse(hasOnboarded, "By default, `hasOnboarded` should be `false`.")
    }
    
    func testSetHasOnboarded() {
        UserDefaults.standard.removeObject(forKey: LocalState.Keys.hasOnboarded.rawValue)
        LocalState.hasOnboarded = true
        XCTAssertTrue(UserDefaults.standard.bool(forKey: LocalState.Keys.hasOnboarded.rawValue), "`hasOnboarded` should be set to `true`.")
    }
    
    func testGetHasOnboarded() {
        UserDefaults.standard.set(true, forKey: LocalState.Keys.hasOnboarded.rawValue)
        let hasOnboarded = LocalState.hasOnboarded
        XCTAssertTrue(hasOnboarded, "`hasOnboarded` should be `true` if it has been previously set.")
    }
    
    func testSetHasOnboardedMultipleTimes() {
        UserDefaults.standard.removeObject(forKey: LocalState.Keys.hasOnboarded.rawValue)
        LocalState.hasOnboarded = true
        LocalState.hasOnboarded = false
        XCTAssertFalse(UserDefaults.standard.bool(forKey: LocalState.Keys.hasOnboarded.rawValue), "`hasOnboarded` should be set to `false`.")
    }
    
}
