//
//  day5.swift
//  advent2020
//
//  Created by Elliot Barer on 12/4/20.
//

import Foundation

struct Day5: Day {
    let index: Int
    var input: [Any]
    var passes: [Int : [Int]]
    
    init() {
        index = 5
        let raw = AdventParser<String>(file: "day5.txt").inputs() ?? []
        input = raw.map {
            var pass = $0.replacingOccurrences(of: "F", with: "0")
            pass = pass.replacingOccurrences(of: "B", with: "1")
            pass = pass.replacingOccurrences(of: "L", with: "0")
            pass = pass.replacingOccurrences(of: "R", with: "1")

            let del = pass.index(pass.endIndex, offsetBy: -3)
            let row = String(pass[pass.startIndex..<del])
            let seat = String(pass[del..<pass.endIndex])
            return (Int(row, radix: 2)!, Int(seat, radix: 2)!)
        }
        
        passes = [Int : [Int]]()
        for pass in input as! [(row: Int, seat: Int)] {
            if passes[pass.row] == nil { passes[pass.row] = [Int]() }
            passes[pass.row]!.append(pass.seat)
        }
    }
    
    func partOne() -> Any {
        guard let highestRow: Int = passes.keys.sorted().last,
              let highestSeat: Int = passes[highestRow]!.sorted().last else { return "None" }
        return (highestRow * 8) + highestSeat
    }
    
    func partTwo() -> Any {
        let emptyRow = passes.compactMapValues {
            $0.count != 7 ? nil : $0.sorted()
        }
        
        let row: Int = emptyRow.keys.first!
        guard let seat = emptyRow[row]?.enumerated().first(where: { $0 != $1 })?.offset else { return "None" }
        return (row * 8) + seat
    }
}
