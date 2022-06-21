//
//  Venue.swift
//  MLBScoreboard
//
//  Created by Damian Torres on 4/19/22.
//

import Foundation

struct Venue: Decodable {
    let name: String
    let location: Location
}

struct Location: Decodable {
    let city: String
    let country: String
}
