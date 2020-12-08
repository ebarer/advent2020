//
//  day8.swift
//  advent2020
//
//  Created by Elliot Barer on 12/6/20.
//

import Foundation

struct Day8: Day {
    let index: Int = 8
    var input: [Any]
    
    init() {
        input = AdventParser<String>(file: "day\(index).txt").inputs() ?? []
//        for ins in input as! [String] {
//            print(ins)
//        }
//        print(seperator())
    }
    
    func executeInstr(num: Int, op: String, val: Int, acc: inout Int) -> Int {
        var offset = 1
        
        switch op {
        case "acc":
            acc += val
        case "jmp":
            offset = val
        case "nop": break
        default: break
        }
        
        return num + offset
    }
    
    func partOne() -> Any {
        var acc: Int = 0
        var instrNum: Int = 0
        var executedInstr = Set<Int>()
        
        repeat {
            let instr = (input as! [String])[instrNum].split(whereSeparator: \.isWhitespace)
            let val = Int(instr[1])!
            let op = String(instr[0])
            
            executedInstr.insert(instrNum)
            instrNum = executeInstr(num: instrNum, op: op, val: val, acc: &acc)
        } while !executedInstr.contains(instrNum)
        
        return acc
    }
    
    func partTwo() -> Any {
        var final_acc: Int = -1
        
        for (i, ins) in (input as! [String]).enumerated() {
            let instr = ins.split(whereSeparator: \.isWhitespace)
            if instr[0] == "acc" {
                continue
            }
        
            var instructions = input as! [String]
            instructions[i] = (instr[0] == "jmp") ? "nop \(instr[1])" : "jmp \(instr[1])"
            
            var acc: Int = 0
            var instrNum: Int = 0
            var executedInstr = Set<Int>()
            
            repeat {
                let instr = instructions[instrNum].split(whereSeparator: \.isWhitespace)
                let val = Int(instr[1])!
                let op = String(instr[0])
                
                executedInstr.insert(instrNum)
                instrNum = executeInstr(num: instrNum, op: op, val: val, acc: &acc)
                
                if instrNum == instructions.count {
                    final_acc = acc
                    break
                }
            } while !executedInstr.contains(instrNum)
        }
        
        return final_acc
    }
}

