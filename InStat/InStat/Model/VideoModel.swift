//
//  VideoModel.swift
//  InStat
//
//  Created by Nurbek Abdulahatov on 19/11/21.
//

import Foundation

protocol VideoModelDelegate: AnyObject {
    func didReceiveVideos(videos: Video)
    func didReceiveError(error: Error)
}

class VideoModel {
    weak var delegate: VideoModelDelegate?
    
    func requestVideos(sportId: Int, matchId: Int) {
        let requestModel = VideoUrlRequestModel(sportId: sportId, matchId: matchId)
        
        ApiClient.sharedInstance.send(for: Video.self, apiRequest: requestModel) { result in
            switch result {
                case .success(let videos):
                    self.delegate?.didReceiveVideos(videos: videos)
                case .failure(let error):
                    self.delegate?.didReceiveError(error: error)
            }
        }
    }
}


