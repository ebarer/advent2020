//
//  day16.swift
//  advent2020
//
//  Created by Elliot Barer on 12/15/20.
//

import Foundation

struct Day16: Day {
    let index: Int = 16
    var input: [Any]
    
    var fieldsDict = [String : [ClosedRange<Int>]]()
    var fieldRanges = [ClosedRange<Int>]()
    var allTickets = [[Int]]()
    var myTicket = [Int]()
    
    init() {
        input = AdventParser<String>(file: "day\(index).txt").inputs() ?? []
        
        var recordMyTicket = false
        var recordTickets = false
        for line in (input as! [String]) {
            let scan = line.split(separator: ":")
            
            if scan.count > 1 { // Get fields
                let fieldName = String(scan[0])
                fieldsDict[fieldName] = [ClosedRange<Int>]()
                let rangeStrings = String(scan[1]).filter({ !$0.isWhitespace }).components(separatedBy: "or")
                for range in rangeStrings {
                    let vals = range.split(separator: "-")
                    fieldsDict[fieldName]?.append(Int(vals[0])!...Int(vals[1])!)
                }
            } else if line == "nearby tickets:" {
                recordTickets = true
            } else if recordTickets {
                let ticket = line.split(separator: ",").map({ Int($0)! })
                allTickets.append(ticket)
            } else if line == "your ticket:" {
                recordMyTicket = true
            } else if recordMyTicket {
                myTicket = line.split(separator: ",").map({ Int($0)! })
            }
        }
        
        fieldRanges = fieldsDict.values.reduce([], +)
    }
    
    func validateTickets() -> (scanningErrorRate: Int, validTickets: [[Int]]) {
        var validTickets = [[Int]]()
        var invalidTicketValues = [Int]()
        
        allTickets.forEach { ticket in
            let invalidValues = ticket.filter { v in !fieldRanges.contains { range in range.contains(v) } }
            invalidTicketValues.append(contentsOf: invalidValues)
            if (invalidValues.count == 0) { validTickets.append(ticket) }
        }
        
        return (invalidTicketValues.reduce(0, +), validTickets)
    }
    
    func fieldIndices(for tickets: [[Int]]) -> [String : Int] {
        var fieldMapping = fieldsDict.mapValues { _ in return Set<Int>(0..<fieldsDict.count) }
        
        // For each ticket, determine possible indices for each value
        tickets.forEach { ticket in
            ticket.enumerated().forEach { (i, v) in
                fieldsDict.filter({ $1.filter({ range in range.contains(v) }).count == 0 }).keys.forEach {
                    fieldMapping[$0]?.remove(i)
                }
            }
        }

        // Reduce the set of possible indices to 1 for each field
        // by removing indices assigned to other fields
        while fieldMapping.values.filter({ $0.count > 1 }).count > 0 {
            fieldMapping.filter({ $0.value.count == 1 })
                        .compactMapValues({ $0.first! })
                        .forEach { (field, index) in
                fieldMapping.filter({ $0.key != field }).forEach { (f, i) in
                    fieldMapping[f] = i.filter({ $0 != index })
                }
            }
        }
        
        return fieldMapping.compactMapValues({ $0.first! })
    }

    func partOne() -> Any {
        return validateTickets().scanningErrorRate
    }
    
    func partTwo() -> Any {
        return fieldIndices(for: validateTickets().validTickets)
                .filter({ $0.key.contains("departure") })
                .reduce(1) { $0 * myTicket[$1.value] }
    }
}
