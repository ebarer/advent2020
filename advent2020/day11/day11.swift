//
//  day11.swift
//  advent2020
//
//  Created by Elliot Barer on 12/10/20.
//

import Foundation

struct Day11: Day {
    let index: Int = 11
    var input: [Any]
    var seating: [[Character]]
    
    init() {
        input = AdventParser<String>(file: "day\(index).txt").inputs() ?? []
        seating = (input as! [String]).map {
            var v = Array($0)
            v.insert("-", at: 0)
            v.append("-")
            return v
        }

        let border: [Character] = Array(repeating: "-", count: seating[0].count)
        seating.insert(border, at: 0)
        seating.append(border)
    }
    
    func search(seats: [[Character]], p: (x: Int, y: Int), tolerance: Int, lattitude: ClosedRange<Int>) -> Int {
        var numOccupied = 0
        for y in -1...1 {
            for x in -1...1 {
                if x == 0 && y == 0 { continue }

                for step in lattitude {
                    let testSeat = seats[p.x + step * x][p.y + step * y]
                    if testSeat != "." {
                        numOccupied += testSeat == "#" ? 1 : 0
                        if numOccupied >= tolerance { return numOccupied }
                        break
                    }
                }
            }
        }
        return numOccupied
    }
    
    func populatedSeats(_ seats: [[Character]], tolerance: Int, lattitude: ClosedRange<Int>) -> Int {
        var newArrangement = seats
        var oldArrangement: [[Character]]
        repeat {
            oldArrangement = newArrangement

            for (i,row) in oldArrangement.enumerated() {
                for (j,seat) in row.enumerated() {
                    if seat == "." || seat == "-" { continue }
                    
                    
                    let numOccupied = search(seats: oldArrangement, p: (x: i, y: j), tolerance: tolerance, lattitude: lattitude)
                    if numOccupied == 0 {
                        newArrangement[i][j] = "#"
                    } else if seat == "#" && numOccupied >= tolerance {
                        newArrangement[i][j] = "L"
                    }
                }
            }
        } while newArrangement != oldArrangement
        
        return newArrangement.reduce(0) { $0 + $1.filter { $0 == "#" }.count }
    }
    
    func partOne() -> Any {
        return populatedSeats(seating, tolerance: 4, lattitude: 1...1)
    }
    
    func partTwo() -> Any {
        return populatedSeats(seating, tolerance: 5, lattitude: 1...seating[0].count)
    }
}

