//
//  Date+Extentions.swift
//  RAWG-Dicoding
//
//  Created by Finn Christoffer Kurniawan on 06/03/23.
//

import Foundation

extension String {
    func convertToDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: self)!
        return date
    }
}

extension Date {
    func convertToString(format: String) -> String {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
