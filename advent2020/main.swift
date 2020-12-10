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
    Day4(),
    Day5(),
    Day6(),
    Day7(),
    Day8(),
    Day9(),
    Day10()
]

func allDays() {
    print("Advent of Code 2020")
    
    let headerDay = "Day".padding(toLength: 8, withPad: " ", startingAt: 0)
    let headerPart1 = "Part 1".padding(toLength: 15, withPad: " ", startingAt: 0)
    let headerPart2 = "Part 2".padding(toLength: 15, withPad: " ", startingAt: 0)
    print("\n  \(headerDay) \(headerPart1) \(headerPart2)")

    days.dropLast().forEach { print($0.description) }
    print(seperator())
}

func today() {
    guard let start = DateComponents(calendar: Calendar.current, timeZone: TimeZone(abbreviation: "EST"), year: 2020, month: 12, day: 1).date,
          let dif = Calendar.current.dateComponents([.day], from: start, to: Date()).day else { return }
    print(days[dif].description)
    print(seperator())
}

//allDays()
today()
