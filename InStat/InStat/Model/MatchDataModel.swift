//
//  MatchDataController.swift
//  InStat
//
//  Created by Nurbek Abdulahatov on 18/11/21.
//

import Foundation

protocol MatchDataModelDelegate: AnyObject {
    func didReceiveData(data: MatchData)
    func didReceiverError(error: Error)
}

class MatchDataModel {
    weak var delegate: MatchDataModelDelegate?
    
    func requestData(params: DataRequestParam) {
        let requestModel = DataRequestModel(requestParam: params)
        
        ApiClient.sharedInstance.send(for: MatchData.self, apiRequest: requestModel) { result in
            switch result {
                case .success(let matchData):
                    self.delegate?.didReceiveData(data: matchData)
                case .failure(let error):
                    self.delegate?.didReceiverError(error: error)
            }
        }
    }
}
