//
//  ISODateFormatManager.swift
//  Uyubudan
//
//  Created by SangRae Kim on 5/1/24.
//

import Foundation

final class ISODateFormatManager {
    
    static let shared = ISODateFormatManager()
    private let dateFormatter: ISO8601DateFormatter
    private let components: Set<Calendar.Component> = [.year, .month, .day, .hour, .minute, .second]
    
    private init() { 
        dateFormatter = ISO8601DateFormatter()
        dateFormatter.timeZone = .current
        dateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
    }
    
    func ISODateFormatToString(_ date: String) -> String {
        let targetDate = dateFormatter.date(from: date) ?? .now
        let diff = Calendar.current.dateComponents(components, from: targetDate, to: .now)
        
        // 오늘 날짜와 다르면
        if !Calendar.current.isDateInToday(targetDate) {
            let date = Calendar.current.dateComponents(components, from: targetDate)
            return "\(date.year!)년\(date.month!)월\(date.day!)일"
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
