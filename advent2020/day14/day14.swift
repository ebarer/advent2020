//
//  day14.swift
//  advent2020
//
//  Created by Elliot Barer on 12/13/20.
//

import Foundation

struct Day14: Day {
    let index: Int = 14
    var input: [Any]
    
    init() {
        input = AdventParser<String>(file: "day\(index).txt").inputs() ?? []
    }
    
    func initializeMemory(decoder: (_ memory: inout [Int : Int], _ address: Int, _ value : Int, _ mask: String) -> Void) -> [Int : Int] {
        var memory = [Int : Int]()
        
        var mask: String = ""
        for line in input as! [String] {
            let cmd = line.filter({ !$0.isWhitespace }).split(separator: "=")
            if cmd[0] == "mask" {
                mask = String(cmd[1])
            } else {
                let addressString = String(cmd[0])
                guard let match = addressString.substringMatch(pattern: "mem\\[([0-9]+)\\]"),
                      let range = Range(match.range(at: 1), in: addressString),
                      let address = Int(addressString[range]),
                      let value = Int(cmd[1])
                else { continue }

                decoder(&memory, address, value, mask)
            }
        }
        
        return memory
    }
    
    func partOne() -> Any {
        let mem = initializeMemory { (memory, address, value, mask) in
            memory[address] = value.toBinary(mask: mask, ignore: "X").toInt()
        }
        
        return mem.values.reduce(0, +)
    }
    
    func partTwo() -> Any {
        let mem = initializeMemory { (memory, address, value, mask) in
            address.toBinary(mask: mask, ignore: "0").binaryPermutations(replacing: "X").forEach { (binaryAddress) in
                memory[binaryAddress.toInt()] = value
            }
        }
        
        return mem.values.reduce(0, +)
    }
}
