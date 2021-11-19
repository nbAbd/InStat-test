//
//  DataRequestModel.swift
//  InStat
//
//  Created by Nurbek Abdulahatov on 18/11/21.
//

import Foundation

class DataRequestModel: APIRequest {
    var method = RequestType.POST
    var url = URL(string: RequestPath.data)!
    var parameters = [String : Any]()
    
    init(requestParam: DataRequestParam) {
        let params: [String: Any] = [
            "_p_sport": requestParam.sportId,
            "_p_match_id": requestParam.matchId
        ]
        
        self.parameters = [
            "proc": requestParam.proc,
            "params": params
        ]
    }
}

struct DataRequestParam {
    var proc: String
    var sportId: Int
    var matchId: Int
}
