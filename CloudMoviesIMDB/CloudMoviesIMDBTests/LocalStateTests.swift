//
//  LocalStateTests.swift
//  CloudMoviesIMDBTests
//
//  Created by Artem Bilyi on 03.05.2023.
//

import XCTest
@testable import CloudMoviesIMDB

class LocalStateTests: XCTestCase {
    
    func testHasOnboardedDefault() {
        UserDefaults.standard.removeObject(forKey: LocalState.Keys.hasOnboarded.rawValue)
        let hasOnboarded = LocalState.hasOnboarded
        XCTAssertFalse(hasOnboarded, "By default, `hasOnboarded` should be `false`.")
    }
    
    func testSetHasOnboarded() {
        // Given
        UserDefaults.standard.removeObject(forKey: LocalState.Keys.hasOnboarded.rawValue)
        // When
        LocalState.hasOnboarded = true
        // Then
        XCTAssertTrue(UserDefaults.standard.bool(forKey: LocalState.Keys.hasOnboarded.rawValue), "`hasOnboarded` should be set to `true`.")
    }
    
    func testGetHasOnboarded() {
        // Given
        UserDefaults.standard.set(true, forKey: LocalState.Keys.hasOnboarded.rawValue)
        
        // When
        let hasOnboarded = LocalState.hasOnboarded
        
        // Then
        XCTAssertTrue(hasOnboarded, "`hasOnboarded` should be `true` if it has been previously set.")
    }
    
    func testSetHasOnboardedMultipleTimes() {
        // Given
        UserDefaults.standard.removeObject(forKey: LocalState.Keys.hasOnboarded.rawValue)
        
        // When
        LocalState.hasOnboarded = true
        LocalState.hasOnboarded = false
        
        // Then
        XCTAssertFalse(UserDefaults.standard.bool(forKey: LocalState.Keys.hasOnboarded.rawValue), "`hasOnboarded` should be set to `false`.")
    }
    
}
