//
//  day6.swift
//  advent2020
//
//  Created by Elliot Barer on 12/5/20.
//

import Foundation

struct Day6: Day {
    let index: Int = 6
    var input: [Any]
    
    init() {
        input = (AdventParser<String>(file: "day\(index).txt").inputs(split: false)?[0] ?? "").components(separatedBy: "\n\n")
    }
    
    func partOne() -> Any {
        return (input as! [String]).map({ Set(Array($0.replacingOccurrences(of: "\n", with: ""))) }).reduce(0) { $0 + $1.count }
    }
    
    func partTwo() -> Any {
        return (input as! [String]).reduce(0) { (count, group) -> Int in
            let answers = group.split(whereSeparator: \.isWhitespace)
            let peopleCount = answers.count

            let results = answers.map { Array($0) }.reduce([], +).reduce(into: [String: Int](), {
                $0[String($1)] = ($0[String($1)] ?? 0) + 1
            }).compactMapValues { (count) -> Int? in
                count == peopleCount ? count : nil
            }

            return count + results.reduce(0) { $0 + $1.key.count}
        }
    }
}

