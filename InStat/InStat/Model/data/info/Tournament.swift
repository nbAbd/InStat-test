//
//  Tournament.swift
//  InStat
//
//  Created by Nurbek Abdulahatov on 19/11/21.
//

import Foundation

// MARK: - Tournament
struct Tournament : Codable {
    let id : Int?
    let name_eng : String?
    let name_rus : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name_eng = "name_eng"
        case name_rus = "name_rus"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name_eng = try values.decodeIfPresent(String.self, forKey: .name_eng)
        name_rus = try values.decodeIfPresent(String.self, forKey: .name_rus)
    }
}
