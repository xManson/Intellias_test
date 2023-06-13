//
//  QuoteListService.swift
//  Technical-test
//
//

import Foundation

final class QuoteListService {
    
    private let networkLoader: NetworkLoader
    private let favouritesStore: FavouriteStore
    let market: Market

    init(networkLoader: NetworkLoader, favouritesStore: FavouriteStore, market: Market) {
        self.networkLoader = networkLoader
        self.favouritesStore = favouritesStore
        self.market = market
    }
    
    func applyFavourites(symbol: String) {
        favouritesStore.apply(symbol: symbol)
        if let quote = market.quotes.first(where: { $0.symbol == symbol }) {
            quote.isFavourite = favouritesStore.contains(symbol: symbol)
        }
    }
    
    func load() async throws {
        let quotes = try await networkLoader.fetchQuotes()
        market.quotes = merge(quotes: quotes)
    }

    private func merge( quotes: [Quote]) -> [Quote] {
        quotes.map({ quote -> Quote in
            quote.isFavourite = favouritesStore.contains(symbol: quote.symbol)
            return quote
        })
    }

}
