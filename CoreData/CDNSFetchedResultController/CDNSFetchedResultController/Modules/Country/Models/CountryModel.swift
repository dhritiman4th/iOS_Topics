//
//  CountryModel.swift
//  CDNSFetchedResultController
//
//  Created by Dhritiman Saha on 26/01/24.
//

import Foundation

struct CountryModel: Codable {
    let name: CountryName
    let capital: [String]?
    let region: String
    let subregion: String?
    let flag: String
    let population: Int64
}

struct CountryName: Codable {
    let common: String
    let official: String
}
