//
//  HolidaysModel.swift
//  FavoriteListingDemo
//
//  Created by Admin on 23/02/22.
//

import Foundation


import Foundation

// MARK: - Holidays
class Holidays: Codable {
    let meta: Meta
    let response: Response

    init(meta: Meta, response: Response) {
        self.meta = meta
        self.response = response
    }
}

// MARK: - Meta
class Meta: Codable {
    let code: Int

    init(code: Int) {
        self.code = code
    }
}

// MARK: - Response
class Response: Codable {
    let holidays: [Holiday]

    init(holidays: [Holiday]) {
        self.holidays = holidays
    }
}

// MARK: - Holiday
class Holiday: Codable {
    let name, holidayDescription: String
    let country: Country
    let locations: String

    enum CodingKeys: String, CodingKey {
        case name
        case holidayDescription = "description"
        case country, locations
    }

    init(name: String, holidayDescription: String, country: Country, locations: String) {
        self.name = name
        self.holidayDescription = holidayDescription
        self.country = country
        self.locations = locations
    }
}

// MARK: - Country
class Country: Codable {
    let id: ID
    let name: Name

    init(id: ID, name: Name) {
        self.id = id
        self.name = name
    }
}

enum ID: String, Codable {
    case us = "us"
}

enum Name: String, Codable {
    case unitedStates = "United States"
}







