//
//  DatelyTests.swift
//  DatelyTests
//
//  Created by Nick Cory on 10/7/24.
//

import Testing
@testable import Dately
import Foundation

struct DatelyTests {

    @Test func testWeekNumberFormatting() {
            let result = getCurrentWeekNumber(compact: false)
            #expect(result.hasPrefix("Week"))
        }

        @Test func testCompactWeekNumberFormatting() {
            let result = getCurrentWeekNumber(compact: true)
            #expect(result.hasPrefix("W"))
        }

        @Test func testDayOfYearFormatting() {
            let result = getCurrentDayOfYear(compact: false)
            #expect(result.hasPrefix("Day"))
        }

        @Test func testCompactDayOfYearFormatting() {
            let result = getCurrentDayOfYear(compact: true)
            #expect(result.hasPrefix("D"))
        }

        @Test func testCompactDisplayToggle() {
            let store = SettingsStore.shared
            let original = store.compactDisplay

            store.compactDisplay = true
            #expect(store.compactDisplay)

            store.compactDisplay = false
            #expect(!store.compactDisplay)

            // Restore original
            store.compactDisplay = original
        }

    
    @Test func testCompactWeekNumberWithKnownDate() {
        let testDate = ISO8601DateFormatter().date(from: "2024-01-03T00:00:00Z")! // Week 1
        let result = getCurrentWeekNumber(compact: true, date: testDate)
        #expect(result == "W1")
    }

    @Test func testDayOfYearWithKnownDate() {
        let formatter = ISO8601DateFormatter()
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        let testDate = ISO8601DateFormatter().date(from: "2024-12-31T00:00:00Z")! // Should be day 366 in a leap year
        let result = getCurrentDayOfYear(compact: false, date: testDate)
        #expect(result == "Day 366")
    }
    
    @Test func testDayOfYearWithKnownDate2() {
        let formatter = ISO8601DateFormatter()
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        let testDate = ISO8601DateFormatter().date(from: "2025-01-01T00:00:00Z")!
        let result = getCurrentDayOfYear(compact: false, date: testDate)
        #expect(result == "Day 1")
    }

}


