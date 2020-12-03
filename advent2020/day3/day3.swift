//
//  day3.swift
//  advent2020
//
//  Created by Elliot Barer on 12/2/20.
//

import Foundation

struct Slope {
    let x: Int
    let y: Int
}

struct Day3: Day {
    var index: Int
    var input: [Any]
    let rowWidth: Int
        
    init() {
        index = 3
        input = AdventParser<String>(file: "day3.txt").inputs ?? []
        rowWidth = (input as! [String])[0].count
    }
    
    func treeCount(slope: Slope) -> Int {
        var treeCount = 0
        
        var x = 0
        for y in stride(from: 0, to: input.count, by: slope.y) {
            if (input[y] as! String)[x] == "#" {
                treeCount += 1
            }
            x = (x + slope.x) % rowWidth;
        }
        
        return treeCount
    }
    
    func partOne() -> Any {
        return treeCount(slope: Slope(x: 3, y: 1))
    }
    
    func partTwo() -> Any {
        let slopes = [
            Slope(x: 1, y: 1),
            Slope(x: 3, y: 1),
            Slope(x: 5, y: 1),
            Slope(x: 7, y: 1),
            Slope(x: 1, y: 2)
        ]
        
        return slopes.reduce(1) { $0 * treeCount(slope: $1) }
    }
}
