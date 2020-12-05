//
//  day5.swift
//  advent2020
//
//  Created by Elliot Barer on 12/4/20.
//

import Foundation

struct Day5: Day {
    let index: Int = 5
    var input: [Any]
    
    init() {
        input = (AdventParser<String>(file: "day\(index).txt").inputs() ?? []).map {
            let pass = $0.replacingOccurrences(of: "F", with: "0")
                         .replacingOccurrences(of: "B", with: "1")
                         .replacingOccurrences(of: "L", with: "0")
                         .replacingOccurrences(of: "R", with: "1")

            let del = pass.index(pass.endIndex, offsetBy: -3)
            let row = Int(String(pass[pass.startIndex..<del]), radix: 2)
            let seat = Int(String(pass[del..<pass.endIndex]), radix: 2)
            return (row, seat)
        }
    }
    
    var passes: [Int : [Int]] {
        return (input as! [(row: Int, seat: Int)]).reduce(into: [Int: [Int]](), {
            if $0[$1.row] == nil { $0[$1.row] = [Int]() }
            $0[$1.row]!.append($1.seat)
        })
    }
    
    func partOne() -> Any {
        guard let highestRow: Int = passes.keys.sorted().last,
              let highestSeat: Int = passes[highestRow]!.sorted().last else { return "-" }
        return (highestRow * 8) + highestSeat
    }
    
    func partTwo() -> Any {
        let emptyRow = passes.compactMapValues {
            $0.count != 7 ? nil : $0.sorted()
        }
        
        let row: Int = emptyRow.keys.first!
        guard let seat = emptyRow[row]?.enumerated().first(where: { $0 != $1 })?.offset else { return "-" }
        return (row * 8) + seat
    }
}

