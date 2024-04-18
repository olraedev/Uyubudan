//
//  DateFormatterManager.swift
//  Uyubudan
//
//  Created by SangRae Kim on 4/18/24.
//

import Foundation

final class DateFormatterManager {
    static let shared = DateFormatterManager()
    private let dateFormatter = DateFormatter()
    private let components: Set<Calendar.Component> = [.year, .month, .day, .hour, .minute, .second]
    
    private init() { 
        
    }
    
    func timeIntervalSinceNow(target: String) -> String {
        let targetDate = dateFormatter.date(from: target) ?? .now
        let compareDateFromTarget = Date.now.compare(targetDate)
        
        // 오늘 날짜와 다르면
        if compareDateFromTarget != .orderedSame {
            let date = Calendar.current.dateComponents(components, from: targetDate)
            return "\(date.year!)-\(date.month!)-\(date.day!)"
        }
        
        // 아니면 계산
        let diff = Calendar.current.dateComponents(components, from: targetDate, to: .now)
        
        guard let hour = diff.hour,
                let minute = diff.minute,
                let second = diff.second else {
            return ""
        }

        if let hour = diff.hour, hour > 0 {
            return "\(hour)시간 전"
        }
        if let minute = diff.minute, minute > 0 {
            return "\(minute)분 전"
        }
        return "방금"
    }
}
