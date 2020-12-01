//
//  day1.swift
//  advent2020
//
//  Created by Elliot Barer on 11/30/20.
//

import Foundation

func day1() {
    let day1_input = AdventParser<Int>(file: "day1.txt").inputs
    print("Day 1, Part 1: \(day1_1(entries: day1_input) ?? (-1,-1,-1))")
    print("Day 1, Part 2: \(day1_2(entries: day1_input) ?? (-1,-1,-1,-1))")
}

func day1_1(entries: [Int]) -> (a: Int, b: Int, result: Int)? {
    for i in 0..<entries.count {
        for j in i+1..<entries.count {
            if (entries[i] + entries[j]) == 2020 {
                let result = entries[i] * entries[j]
                return (entries[i], entries[j], result)
            }
        }
    }

    return nil
}

func day1_2(entries: [Int]) -> (a: Int, b: Int, c: Int, result: Int)? {
    for i in 0..<entries.count {
        for j in i+1..<entries.count {
            for k in i+1..<entries.count {
                if (entries[i] + entries[j] + entries[k]) == 2020 {
                    let result = entries[i] * entries[j] * entries[k]
                    return (entries[i], entries[j], entries[k], result)
                }
            }
        }
    }

    return nil
}
