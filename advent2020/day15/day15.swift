//
//  day15.swift
//  advent2020
//
//  Created by Elliot Barer on 12/14/20.
//

import Foundation

struct Day15: Day {
    let index: Int = 15
    var input: [Any]
    
    init() {
        input = AdventParser<String>(file: "day\(index).txt").inputs() ?? []
    }
    
    func memoryGame(turns iterations: Int) -> Int {
        let startingNumbers: [Int] = (input as! [String]).first!.split(separator: ",").map { Int($0)! }

        var orderSpoken = [Int: [Int]]()
        var lastNumber: Int = -1
        for turn in 0..<iterations {
            var num: Int = 0
            if turn < startingNumbers.count {
                num = startingNumbers[turn]
            } else if let turns = orderSpoken[lastNumber], turns.count == 2 {
                num = turns[0] - turns[1]
            }
            
            if orderSpoken[num] == nil {
                orderSpoken[num] = [turn, turn]
            } else {
                let tmp = orderSpoken[num]![0]
                orderSpoken[num]![0] = turn
                orderSpoken[num]![1] = tmp
            }

            lastNumber = num
        }

        return lastNumber
    }
    
    func partOne() -> Any {
        return memoryGame(turns: 2020)
    }
    
    func partTwo() -> Any {
        return memoryGame(turns: 30000000)
    }
}

