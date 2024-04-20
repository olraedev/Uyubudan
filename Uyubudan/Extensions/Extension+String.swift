//
//  Extension+String.swift
//  Uyubudan
//
//  Created by SangRae Kim on 4/18/24.
//

import Foundation

extension String {
    var timeIntervalSinceNow: String {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.timeZone = .current
        dateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        
        let targetDate = dateFormatter.date(from: self) ?? .now
        let components: Set<Calendar.Component> = [.year, .month, .day, .hour, .minute, .second]

        let diff = Calendar.current.dateComponents(components, from: targetDate, to: .now)
        
        // 오늘 날짜와 다르면
        if !Calendar.current.isDateInToday(targetDate) {
            let date = Calendar.current.dateComponents(components, from: targetDate)
            return "\(date.year!)-\(date.month!)-\(date.day!)"
        }

        if let hour = diff.hour, hour > 0 {
            return "\(hour)시간 전"
        }
        if let minute = diff.minute, minute > 0 {
            return "\(minute)분 전"
        }
        return "방금 전"
    }
}
