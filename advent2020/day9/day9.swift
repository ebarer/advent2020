//
//  day9.swift
//  advent2020
//
//  Created by Elliot Barer on 12/8/20.
//

import Foundation

struct Day9: Day {
    let index: Int = 9
    var input: [Any]
    let lookback = 25
    
    init() {
        input = AdventParser<Int>(file: "day\(index).txt").inputs() ?? []
    }
    
    var values: [Int] {
        return input as! [Int]
    }
    
    func isValidXmas(val: Int, window: ArraySlice<Int>) -> Bool {
        for a in window {
            for b in window.dropFirst() {
                if a + b == val {
                    return true
                }
            }
        }
        return false
    }
    
    func partOne() -> Any {
        for i in (lookback+1)..<input.count {
            let val = values[i]
            if !isValidXmas(val: val, window: values[i-lookback..<i]) {
                return val
            }
        }
        return -1
    }

    func contiguousWindow(target: Int) -> ArraySlice<Int> {
        for (i, a) in values.enumerated() {
            var endIndex = i
            var sum = a
            while endIndex < values.count && sum < target {
                endIndex += 1
                sum += values[endIndex]
                if sum == target {
                    return values[i..<endIndex]
                }
            }
        }
        
        return []
    }
    
    func partTwo() -> Any {
        let window = contiguousWindow(target: partOne() as! Int)
        guard window.count > 0, let min = window.min(), let max = window.max() else { return -1 }
        return min + max
    }
}

