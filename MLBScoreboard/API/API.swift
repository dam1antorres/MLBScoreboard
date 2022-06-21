//
//  API.swift
//  MLBScoreboard
//
//  Created by Damian Torres on 4/14/22.
//

import Foundation

class API {

    enum APIError: LocalizedError {
        case invalidUrl
        case unknownError
    }

    struct Constants {
        static let host = "https://statsapi.mlb.com/api/v1/schedule?hydrate=team(league),venue(location,timezone),linescore&sportId=1,51&language=en&date="
    }

    private let gameDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }()

    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        return decoder
    }()

    func fetchScoreboard(date: Date) async throws -> [Scoreboard] {
        let date = gameDateFormatter.string(from: date)
        let urlString = "\(Constants.host)\(date)"

        guard let url = URL(string: urlString) else {
            throw APIError.invalidUrl
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        let status = (response as? HTTPURLResponse)?.statusCode

        if let status = status, (200..<300).contains(status) {
            let scoreboard = try decoder.decode(Scoreboard.self, from: data)
            return [scoreboard]
        } else {
            throw APIError.unknownError
        }
    }

}
