//
//  helper.swift
//  advent2020
//
//  Created by Elliot Barer on 11/30/20.
//

import Foundation

protocol Day {
    var index: Int { get }
    var input: [Any] { get }
    func partOne() -> Any
    func partTwo() -> Any
}

extension Day {
    var description: String {
        let dayIndex = "| Day \(self.index)".padding(toLength: 9, withPad: " ", startingAt: 0)
        let partOne = "| \(self.partOne())".padding(toLength: 20, withPad: " ", startingAt: 0)
        let partTwo = "| \(self.partTwo())".padding(toLength: 20, withPad: " ", startingAt: 0)
        return "\(seperator())\(dayIndex) \(partOne) \(partTwo)|"
    }
}

func seperator() -> String {
    return "+\(String(repeating: "-", count: 50))+\n"
}

class AdventParser<T> {
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

extension StringProtocol {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
    
    var range: NSRange {
        return NSRange(location: 0, length: self.count)
    }
    
    func substringMatch(pattern: String) -> NSTextCheckingResult? {
        guard let regex = try? NSRegularExpression(pattern: pattern) else { return nil }
        return regex.firstMatch(in: String(self), options: [], range: self.range)
    }
}

extension Int {
    func inClosedRange(_ lower: Int, _ upper: Int) -> Bool {
        return ClosedRange(uncheckedBounds:(lower, upper)).contains(self)
    }
}
