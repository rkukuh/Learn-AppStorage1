//
//  Currenc.swift
//  AppStorage01
//
//  Created by R. Kukuh on 12/05/23.
//

import Foundation

struct Currency: Identifiable, Codable, Hashable {
    var id = UUID()
    var code: String
    var name: String
}

extension Currency {
    static var emptyCurrency: Currency {
        Currency(code: "", name: "")
    }
}
