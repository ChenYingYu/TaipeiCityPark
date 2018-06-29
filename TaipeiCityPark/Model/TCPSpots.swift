//
//  TCPSpots.swift
//  TaipeiCityPark
//
//  Created by ChenAlan on 2018/6/29.
//  Copyright © 2018年 ChenAlan. All rights reserved.
//

import Foundation

struct Root: Codable {
    let result: Result
    enum CodingKeys: String, CodingKey {
        case result
    }
}

struct Result: Codable {
    let spots: [Spot]
    let count: Int
    enum CodingKeys: String, CodingKey {
        case spots = "results"
        case count
    }
}

struct Spot: Codable {
    let parkId: String
    let parkName: String
    let spotName: String
    let yearBuilt: String
    let openTime: String
    let imageURL: String
    let introduction: String
    enum CodingKeys: String, CodingKey {
        case parkId = "_id"
        case parkName = "ParkName"
        case spotName = "Name"
        case yearBuilt = "YearBuilt"
        case openTime = "OpenTime"
        case imageURL = "Image"
        case introduction = "Introduction"
    }
}
