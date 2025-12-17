import Foundation

/// Returns the current week number formatted for display.
/// - Parameter compact: When true, returns a compact form like "W41"; otherwise "Week 41".
/// - Returns: A string representing the current week number.
func getCurrentWeekNumber(compact: Bool, date: Date = Date()) -> String {
    let calendar = Calendar(identifier: .iso8601)
    let weekOfYear = calendar.component(.weekOfYear, from: date)
    if compact {
        return "W\(weekOfYear)"
    } else {
        return "Week \(weekOfYear)"
    }
}

/// Returns the current day of year formatted for display.
/// - Parameter compact: When true, returns a compact form like "D285"; otherwise "Day 285".
/// - Returns: A string representing the current day-of-year.
func getCurrentDayOfYear(compact: Bool, date: Date = Date()) -> String {
    var calendar = Calendar(identifier: .gregorian)
    calendar.timeZone = TimeZone(secondsFromGMT: 0)! // Ensure consistent results

    let dayOfYear = calendar.ordinality(of: .day, in: .year, for: date) ?? 1

    if compact {
        return "D\(dayOfYear)"
    } else {
        return "Day \(dayOfYear)"
    }
}
