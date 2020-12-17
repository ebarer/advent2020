//
//  helper.swift
//  advent2020
//
//  Created by Elliot Barer on 11/30/20.
//

import Foundation

// MARK: Advent Day

protocol Day {
    var index: Int { get }
    var input: [Any] { get }
    func partOne() -> Any
    func partTwo() -> Any
}

extension Day {
    var description: String {
        let dayIndex = "Day \(self.index)".padding(toLength: 9, withPad: " ", startingAt: 0)
        let partOne = "\(self.partOne())".padding(toLength: 20, withPad: " ", startingAt: 0)
        let partTwo = "\(self.partTwo())".padding(toLength: 20, withPad: " ", startingAt: 0)
        return "| \(dayIndex)| \(partOne)| \(partTwo)|"
    }
}

// MARK:- Print Helpers

func printHeader(title: Bool = true) {
    let headerDay = "Day".padding(toLength: 9, withPad: " ", startingAt: 0)
    let headerPart1 = "Part 1".padding(toLength: 20, withPad: " ", startingAt: 0)
    let headerPart2 = "Part 2".padding(toLength: 20, withPad: " ", startingAt: 0)
    
    if title {
        print("# Advent of Code 2020")
        print("https://adventofcode.com/2020")
    }
    
    print("\n| \(headerDay)| \(headerPart1)| \(headerPart2)|")
    print("|:\(String(repeating: "-", count: 9))|\(String(repeating: "-", count: 20)):|\(String(repeating: "-", count: 20)):|")
}

func printInvalid() {
    print("| Invalid Date \(String(repeating: " ", count: 40))|")
}

// MARK:-

struct AdventParser<T> {
    var fileName: String

    init(file: String) {
        fileName = file
    }

    func inputs(split: Bool = true) -> [T]? {
        let base = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
        let url = URL(fileURLWithPath: self.fileName, relativeTo: base)

        guard let contents = try? String(contentsOf: url) else {
            print("Error getting contents")
            return nil
        }
        
        if (!split) {
            return [contents] as? [T]
        }

        let entries = contents.split(whereSeparator: \.isNewline)

        if T.self == Int.self {
            return entries.map { Int($0) }.compactMap { $0 } as? [T]
        }
        
        if T.self == String.self {
            return entries.map { String($0) } as? [T]
        }

        return nil
    }
}

// MARK:- Extensions

extension Int {
    func inClosedRange(_ lower: Int, _ upper: Int) -> Bool {
        return ClosedRange(uncheckedBounds:(lower, upper)).contains(self)
    }

    func toBinary(mask: String, ignore: Character) -> [Character] {
        var bits = Array(String(self, radix: 2).padded(to: mask.count))
        mask.enumerated().compactMap({ return $0.element != ignore ? $0 : nil }).forEach {
            bits[$0.offset] = $0.element
        }
        return bits
    }

    func permutations<T>() -> [[T]]{
        var permutations = [[T]]()
        for i in 0..<Int(pow(2, Double(self))) {
            let p: [T] = Array(String(i, radix: 2).padded(to: self)).map {
                switch T.self {
                case is Int.Type:
                    return Int(String($0))! as! T
                case is Character.Type:
                    return $0 as! T
                default:
                    return $0 as! T
                }
            }
            permutations.append(p)
        }
        return permutations
    }
}

extension Array where Element: Equatable {
    func binaryPermutations(replacing c: Element) -> [[Element]] {
        let replacingBits = self.enumerated().compactMap { return $0.element == c ? $0.offset : nil }
        return (replacingBits.count.permutations() as [[Element]]).map {
            var permutation = self
            for (i, v) in $0.enumerated() {
                permutation[replacingBits[i]] = v
            }
            return permutation
        }
    }
}

extension Array where Element == Character {
    func toInt() -> Int {
        return Int(String(self), radix: 2)!
    }
}

extension Dictionary {
    mutating func merge(dict: [Key: Value]){
        for (k, v) in dict {
            updateValue(v, forKey: k)
        }
    }
}

extension String {
    var range: NSRange {
        return NSRange(location: 0, length: self.count)
    }
    
    func substringMatch(pattern: String) -> NSTextCheckingResult? {
        guard let regex = try? NSRegularExpression(pattern: pattern) else { return nil }
        return regex.firstMatch(in: String(self), options: [], range: self.range)
    }

    func padded(to size: Int) -> String {
        let dif = size - self.count
        return String(repeating: "0", count: dif) + self
    }
}

extension StringProtocol {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
}
