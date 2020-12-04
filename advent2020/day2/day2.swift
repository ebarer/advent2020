//
//  day2.swift
//  advent2020
//
//  Created by Elliot Barer on 12/1/20.
//

import Foundation

struct Day2: Day {
    var index: Int
    var input: [Any]
    
    init() {
        index = 2
        let raw = AdventParser<String>(file: "day2.txt").inputs() ?? []
        input = raw.map { (record) -> (password: String, required: Character, range: [Int]) in
            let components = record.split(whereSeparator: \.isWhitespace)
            let password: String = String(components[2])
            let required: Character = components[1][0]
            let range = components[0].split(separator: "-").map { Int($0)! }
            return (password, required, range)
        }
    }
    
    func countValidPasswords(handler: (_ record: (p: String, c: Character, r: [Int])) -> Bool) -> Int {
        let records = input as! [(String, Character, [Int])]
        return records.reduce(0) { (accumulator, record) -> Int in
            accumulator + (handler(record) ? 1 : 0)
        }
    }
    
    func partOne() -> Any {
        return countValidPasswords { (password, requiredCharacter, range) -> Bool in
            var characterCount = 0
            for c in password {
                if c == requiredCharacter {
                    characterCount += 1
                }
            }

            return characterCount >= range[0] && characterCount <= range[1]
        }
    }
    
    func partTwo() -> Any {
        return countValidPasswords { (password, requiredCharacter, range) -> Bool in
            let firstCharMatch = password[range[0] - 1] == requiredCharacter
            let secondCharMatch = password[range[1] - 1] == requiredCharacter
            
            return (firstCharMatch || secondCharMatch) && !(firstCharMatch && secondCharMatch)
        }
    }
}
