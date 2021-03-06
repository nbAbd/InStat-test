//
//  VideoElement.swift
//  InStat
//
//  Created by Nurbek Abdulahatov on 19/11/21.
//

import Foundation

// MARK: - VideoElement
struct VideoElement: Codable {
    let name: String?
    let matchID, period, serverID: Int?
    let quality, folder, videoType, abc: String?
    let startMS, checksum, size: Int?
    let abcType: String?
    let duration, fps: Int?
    let urlRoot: String?
    let url: String?

    enum CodingKeys: String, CodingKey {
        case name
        case matchID = "match_id"
        case period
        case serverID = "server_id"
        case quality, folder
        case videoType = "video_type"
        case abc
        case startMS = "start_ms"
        case checksum, size
        case abcType = "abc_type"
        case duration, fps
        case urlRoot = "url_root"
        case url
    }
}

typealias Video = [VideoElement]
