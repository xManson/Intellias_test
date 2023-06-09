//
//  Errors.swift
//  Technical-test

import Foundation

enum TError: Error {
    case wrongURL
}

extension TError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .wrongURL: return "We're sorry, but market url is wrong"
        }
    }
}
