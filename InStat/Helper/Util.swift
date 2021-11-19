//
//  Util.swift
//  InStat
//
//  Created by Nurbek Abdulahatov on 19/11/21.
//

import Foundation

class Util {
    class func formatDate(date: Date, format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
         // dateFormatter.timeZone = TimeZone(secondsFromGMT: 2)
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }
    
    class func stringToDate(dateString: String, format: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: dateString)
    }
}
