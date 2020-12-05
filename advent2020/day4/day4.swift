//
//  day4.swift
//  advent2020
//
//  Created by Elliot Barer on 12/3/20.
//

import Foundation

struct Day4: Day {
    let index: Int = 4
    var input: [Any]
    
    init() {
        input = (AdventParser<String>(file: "day\(index).txt").inputs(split: false)?[0] ?? "").components(separatedBy: "\n\n").map { entry in
            let fields = entry.split(whereSeparator: \.isWhitespace)
            var passport = [String:String]()
            
            fields.forEach {
                let val = $0.components(separatedBy: ":")
                passport[val[0]] = val[1]
            }

            return passport
        }
    }
    
    func validPassports(validation: ([String:String]) -> Bool) -> Int {
        var count = 0
        for passport in input as! Array<[String:String]> {
            if validation(passport) { count += 1 }
        }
        return count
    }
    
    func partOne() -> Any {
        return validPassports { (passport) -> Bool in
            return passport.keys.count == 8 || passport.keys.count == 7 && !passport.keys.contains("cid")
        }
    }
    
    func partTwo() -> Any {
        return validPassports { (passport) -> Bool in
            var validKeyCount = 0
            for key in passport.keys {
                switch key {
                case "byr":
                    guard let val = passport[key], let byr = Int(val) else { return false }
                    if byr.inClosedRange(1920, 2002) { validKeyCount += 1 }
                
                case "iyr":
                    guard let val = passport[key], let iyr = Int(val) else { return false }
                    if iyr.inClosedRange(2010, 2020) { validKeyCount += 1 }
                
                case "eyr":
                    guard let val = passport[key], let eyr = Int(val) else { return false }
                    if eyr.inClosedRange(2020, 2030) { validKeyCount += 1 }

                case "hcl":
                    guard let val = passport[key] else { return false }
                    if val.substringMatch(pattern: "^#[0-9a-f]{6}$") != nil { validKeyCount += 1 }
                
                case "ecl":
                    guard let val = passport[key] else { return false }
                    if ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"].contains(val) { validKeyCount += 1 }
                    
                case "hgt":
                    guard let val = passport[key],
                          let match = val.substringMatch(pattern: "^([0-9]{2,3})(cm|in){1}$"),
                          let hgtRange = Range(match.range(at: 1), in: val), let hgt = Int(val[hgtRange]),
                          let unitRange = Range(match.range(at: 2), in: val) else { return false }
                    
                    let bounds: (lower: Int, upper: Int) = String(val[unitRange]) == "in" ? (59, 76) : (150, 193)
                    if hgt.inClosedRange(bounds.lower, bounds.upper) { validKeyCount += 1}
                    
                case "pid":
                    guard let pid = passport[key], Int(pid) != nil else { return false }
                    if pid.count == 9 { validKeyCount += 1 }
                    
                case "cid":
                    continue
                    
                default: continue
                }
            }

            return validKeyCount >= 7
        }
    }
}
