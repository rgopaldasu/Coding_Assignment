//
//  CityModel.swift
//  CodingAssignment
//
//  Created by Rajesh on 26/06/21.
//

import Foundation

// MARK: - CityModel
struct CityModel: Codable {
    let country, name: String?
    let id: Int?
    let coord: Coord?

    enum CodingKeys: String, CodingKey {
        case country, name
        case id = "_id"
        case coord
    }
}

// MARK: - Coord
struct Coord: Codable {
    let lon, lat: Double?
}

typealias CitiesListModel = [CityModel]
