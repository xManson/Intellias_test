//
//  Quote.swift
//  Technical-test
//
//  Created by Patrice MIAKASSISSA on 29.04.21.
//

import UIKit

class Quote: Codable {
    var symbol: String = ""
    var name: String = ""
    var currency: String = ""
    var readableLastChangePercent: String? = ""
    var last: String = ""
    var variationColor: String?
    var isFavourite: Bool? = false
    
    var percentColor: UIColor {
        switch variationColor {
        case "red": return .red
        case "green": return .green
        default: return .black
        }
    }
    
    var favouriteImage: UIImage? {
        let noFav = UIImage(named: "no-favorite")
        guard let isFavourite else {
            return noFav
        }
        switch isFavourite {
        case true: return UIImage(named: "favorite")
        case false: return noFav
        }
    }
}
