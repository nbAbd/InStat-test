//
//  VideoUrlRequestModel.swift
//  InStat
//
//  Created by Nurbek Abdulahatov on 18/11/21.
//

import Foundation

class VideoUrlRequestModel: APIRequest {
    var method = RequestType.POST
    var url = URL(string: RequestPath.video_urls)!
    var parameters = [String : Any]()
    
    init(sportId: Int, matchId: Int) {
        parameters = [
            "sport_id": sportId,
            "match_id": matchId
        ]
    }
}
