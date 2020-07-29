//
//  Date+Ext.swift
//  GithubFollowers
//
//  Created by Mac OS on 7/29/20.
//  Copyright © 2020 Ahmed Eid. All rights reserved.
//

import Foundation

extension Date {
    
    func convertDateToMonthYearString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat    = "MMM yyyy"
        return dateFormatter.string(from: self)
    }
}
