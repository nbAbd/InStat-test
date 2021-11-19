//
//  Team.swift
//  InStat
//
//  Created by Nurbek Abdulahatov on 19/11/21.
//

import Foundation

// MARK: - Team
struct Team: Codable {
    let id : Int?
    let name_eng : String?
    let name_rus : String?
    let abbrev_eng : String?
    let abbrev_rus : String?
    let score : Int?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name_eng = "name_eng"
        case name_rus = "name_rus"
        case abbrev_eng = "abbrev_eng"
        case abbrev_rus = "abbrev_rus"
        case score = "score"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name_eng = try values.decodeIfPresent(String.self, forKey: .name_eng)
        name_rus = try values.decodeIfPresent(String.self, forKey: .name_rus)
        abbrev_eng = try values.decodeIfPresent(String.self, forKey: .abbrev_eng)
        abbrev_rus = try values.decodeIfPresent(String.self, forKey: .abbrev_rus)
        score = try values.decodeIfPresent(Int.self, forKey: .score)
    }

}
