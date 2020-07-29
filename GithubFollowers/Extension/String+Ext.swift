//
//  String+Ext.swift
//  GithubFollowers
//
//  Created by Mac OS on 7/29/20.
//  Copyright © 2020 Ahmed Eid. All rights reserved.
//

import Foundation

extension String {
    
    func convertStringToDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale        =  Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone      = .current
        return dateFormatter.date(from: self)
    }
    
    func convertDateToDisplayingFormate() -> String {
        guard let date = self.convertStringToDate() else { return "N/A" }
        return date.convertDateToMonthYearString()
    }
    
}
