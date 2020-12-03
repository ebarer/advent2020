//
//  main.swift
//  advent2020
//
//  Created by Elliot Barer on 11/30/20.
//

import Foundation

let days: [Day] = [
    Day1(),
    Day2(),
    Day3(),
    Day4()
]

func allDays() {
    print("Advent of Code 2020")
    
    let dayIndex = "Day".padding(toLength: 8, withPad: " ", startingAt: 0)
    let partOne = "Part 1".padding(toLength: 15, withPad: " ", startingAt: 0)
    let partTwo = "Part 2".padding(toLength: 15, withPad: " ", startingAt: 0)
    print("\n  \(dayIndex) \(partOne) \(partTwo)")

    days.reversed().forEach { print($0.description) }
    print(seperator())
}

func today() {
    guard let start = DateComponents(calendar: Calendar.current, timeZone: TimeZone(abbreviation: "EST"), year: 2020, month: 12, day: 1).date else {
        return
    }
    
    let dif = Calendar.current.compare(Date(), to: start, toGranularity: .day).rawValue + 1
    guard dif < days.count else {
        return
    }
    
    print("Today")
    print(days[dif].description)
    print(seperator())
}

today()
allDays()
