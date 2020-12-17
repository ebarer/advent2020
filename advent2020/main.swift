//
//  main.swift
//  advent2020
//
//  Created by Elliot Barer on 11/30/20.
//

import Foundation

let days: [Day] = [
                       Day1(),  Day2(),  Day3(),  Day4(),  Day5(),
     Day6(),  Day7(),  Day8(),  Day9(), Day10(), Day11(), Day12(),
    Day13(), Day14(), Day15(), Day16(), Day17()
]

func allDays() {
    printHeader()
    days.forEach { print($0.description) }
}

func today() {
    guard let start = DateComponents(calendar: Calendar.current, timeZone: TimeZone(abbreviation: "EST"), year: 2020, month: 12, day: 1).date,
          let dif = Calendar.current.dateComponents([.day], from: start, to: Date()).day,
          days.count > dif
    else {
        printInvalid()
        return
    }

    let description = days[dif].description
    
    printHeader(title: false)
    print(description, "\n")
}

//allDays()
today()
