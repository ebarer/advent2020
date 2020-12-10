//
//  day10.swift
//  advent2020
//
//  Created by Elliot Barer on 12/8/20.
//

import Foundation

struct Day10: Day {
    let index: Int = 10
    var input: [Any]
    var adapters: [Int]
    
    init() {
        input = AdventParser<Int>(file: "day\(index).txt").inputs() ?? []

        adapters = (input as! [Int]).sorted()
        let deviceJoltage = adapters.last! + 3
        adapters.insert(0, at: 0)
        adapters.append(deviceJoltage)
    }
    
    func partOne() -> Any {
        var diffOne = 0
        var diffThree = 0

        for (a, b) in zip(adapters, adapters.dropFirst()) {
            if b - a == 1 {
                diffOne += 1
            } else if b - a == 3 {
                diffThree += 1
            }
        }
        
        return diffOne * diffThree
    }
    
    func partTwo() -> Any {
        var memoized = [Int: Int]()
        func arrangements(adapter: Int) -> Int {
            if adapter == adapters.last { return 1 }
            if let val = memoized[adapter] { return val }

            var sum = 0
            if let idx = adapters.firstIndex(of: adapter) {
                for nextAdapter in adapters[(idx+1)...] {
                    if nextAdapter > adapter + 3 { break }

                    let val = arrangements(adapter: nextAdapter)
                    sum += val
                    memoized[nextAdapter] = val
                }
            }
            return sum
        }
        
        return arrangements(adapter: adapters.first!)
    }
}



