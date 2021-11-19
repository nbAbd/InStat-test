//
//  Data.swift
//  InStat
//
//  Created by Nurbek Abdulahatov on 18/11/21.

import Foundation

struct MatchData: Codable {
    let date : String?
    let tournament : Tournament?
    let team1 : Team?
    let team2 : Team?
    let calc : Bool?
    let has_video : Bool?
    let live : Bool?
    let storage : Bool?
    let sub : Bool?

    enum CodingKeys: String, CodingKey {
        case date = "date"
        case tournament = "tournament"
        case team1 = "team1"
        case team2 = "team2"
        case calc = "calc"
        case has_video = "has_video"
        case live = "live"
        case storage = "storage"
        case sub = "sub"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        date = try values.decodeIfPresent(String.self, forKey: .date)
        tournament = try values.decodeIfPresent(Tournament.self, forKey: .tournament)
        team1 = try values.decodeIfPresent(Team.self, forKey: .team1)
        team2 = try values.decodeIfPresent(Team.self, forKey: .team2)
        calc = try values.decodeIfPresent(Bool.self, forKey: .calc)
        has_video = try values.decodeIfPresent(Bool.self, forKey: .has_video)
        live = try values.decodeIfPresent(Bool.self, forKey: .live)
        storage = try values.decodeIfPresent(Bool.self, forKey: .storage)
        sub = try values.decodeIfPresent(Bool.self, forKey: .sub)
    }
}

