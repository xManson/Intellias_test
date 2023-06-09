//
//  FavouriteStore.swift
//  Technical-test
//

import Foundation

final class FavouriteStore {
    
    var symbols: [String] = []
    private let defaults = UserDefaults.standard
    private let key = "FavouriteStore.key"
    
    init() {
        symbols = (defaults.array(forKey: key) as? [String]) ?? []
    }
    
    private func save() {
        defaults.set(symbols, forKey: key)
    }
    
    func contains(symbol: String) -> Bool {
        symbols.contains(symbol)
    }
    
    func apply(symbol: String) {
        symbols.contains(symbol) ? symbols.removeAll(where: { $0 == symbol }) : symbols.append(symbol)
        save()
    }
}
