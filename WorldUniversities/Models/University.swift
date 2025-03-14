//
//  University.swift
//  WorldUniversities
//
//  Created by Дима Монид on 6.03.25.
//

import Foundation

struct University {
    let name: String
    let country: String
    let webPages: [String]
    let alphaTwoCode: String
    
    init(universityDetails: [String: Any]) {
        name = universityDetails["name"] as? String ?? ""
        country = universityDetails["country"] as? String ?? ""
        webPages = universityDetails["web_pages"] as? [String] ?? [""]
        alphaTwoCode = universityDetails["alpha_two_code"] as? String ?? ""
    }
    
    static func getUniversities(from value: Any) -> [University] {
        guard let universityDetails = value as? [[String: Any]] else { return [] }
        return universityDetails.map {University(universityDetails: $0)}
    }
}
