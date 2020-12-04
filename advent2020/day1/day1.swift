//
//  day1.swift
//  advent2020
//
//  Created by Elliot Barer on 11/30/20.
//

import Foundation

struct Day1: Day {
    var index: Int
    var input: [Any]
    
    init() {
        index = 1
        input = AdventParser<Int>(file: "day1.txt").inputs() ?? []
    }
    
    func findPair(sum: Int) -> (Int, Int)? {
        var found = Set<Int>()
        for val in input as! [Int] {
            let remainder = sum - val
            if found.contains(remainder) {
                return (val, remainder)
            }

            found.insert(val)
        }
        
        return nil
    }
    
    func partOne() -> Any {
        if let pair = findPair(sum: 2020) {
            return pair.0 * pair.1
        }
        
        return "None"
    }
    
    func partTwo() -> Any {
        for val in input as! [Int] {
            if let pair = findPair(sum: 2020 - val) {
                return pair.0 * pair.1 * val
            }
        }
        
        return "None"
    }
}
