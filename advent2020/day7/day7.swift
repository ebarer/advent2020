//
//  day7.swift
//  advent2020
//
//  Created by Elliot Barer on 12/6/20.
//

import Foundation

struct Content {
    let name: String
    let count: Int
}

struct Day7: Day {
    let index: Int = 7
    var input: [Any]
    var rules: [String : [Content]]
    
    init() {
        input = AdventParser<String>(file: "day\(index).txt").inputs() ?? []
        rules = (input as! [String]).reduce(into: [String : [Content]]()) { (rules, rawLine) in
            let line = rawLine.components(separatedBy: "bag")
            
            let bag = line[0].trimmingCharacters(in: .whitespaces)
            
            var contents = [Content]()
            for content in line.dropFirst() {
                if let match = content.substringMatch(pattern: "([0-9]+)\\s([a-z\\s]+)\\,?"),
                   let nameRange = Range(match.range(at: 2), in: content),
                   let countRange = Range(match.range(at: 1), in: content),
                   let count = Int(content[countRange])
                {
                    let name = String(content[nameRange]).trimmingCharacters(in: .whitespaces)
                    contents.append(Content(name: name, count: count))
                }
            }

            rules[bag] = contents
        }
    }
    
    func containsBag(_ name: String, rule: [Content]) -> Bool {
        for bag in rule {
            if bag.name == name {
                return true
            } else {
                if let rule = rules[bag.name], containsBag(name, rule: rule) {
                    return true
                }
            }
        }
        
        return false
    }
    
    func containedBagCount(name: String) -> Int {
        guard let rule = rules[name] else { return 1 }
        return rule.reduce(0) { $0 + $1.count + $1.count * containedBagCount(name: $1.name) }
    }
        
    func partOne() -> Any {
        return rules.reduce(0, { $0 + (containsBag("shiny gold", rule: $1.value) ? 1 : 0) })
    }
    
    func partTwo() -> Any {
        return containedBagCount(name: "shiny gold")
    }
}

