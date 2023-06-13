//
//  Technical_testTests.swift
//  Technical-testTests
//
//

import XCTest

final class DateTests: XCTestCase {

    private let sym1 = "CHI"
    private let sym2 = "PRO"
    private let sym3 = "HOK"
    
    func testFavourites() {
        //g
        resetUserDef()
        let store = FavouriteStore()
        
        //w
        store.apply(symbol: sym1)
        store.apply(symbol: sym2)
        store.apply(symbol: sym3)
        
        //t
        XCTAssertEqual(store.contains(symbol: sym1), true)
        XCTAssertEqual(store.contains(symbol: sym2), true)
        XCTAssertEqual(store.contains(symbol: sym3), true)

        XCTAssertEqual(store.contains(symbol: "HO"), false)
    }
    
    private func resetUserDef() {
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
    }
    
   
}
