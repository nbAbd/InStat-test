//
//  ResponseResult.swift
//  InStat
//
//  Created by Nurbek Abdulahatov on 19/11/21.
//

import Foundation

public enum ResponseResult<Value> {
    case success(Value)
    case failure(Error)
}
