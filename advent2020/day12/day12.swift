//
//  day12.swift
//  advent2020
//
//  Created by Elliot Barer on 12/11/20.
//

import Foundation

enum Direction : Int {
    case East = 0
    case North = 90
    case West = 180
    case South = 270
    
    init(c: Character) {
        switch c {
        case "E":
            self.init(rawValue: Direction.East.rawValue)!
        case "N":
            self.init(rawValue: Direction.North.rawValue)!
        case "W":
            self.init(rawValue: Direction.West.rawValue)!
        default:
            self.init(rawValue: Direction.South.rawValue)!
        }
    }
    
    mutating func rotate(deg: Int, ccw: Bool) {
        self = Direction(rawValue: (self.rawValue + deg * (ccw ? 1 : -1) + 360) % 360)!
    }
}

extension CGPoint {
    //    (-1, 2) ^
    //                 > (2, 1)
    //              X
    //   (-2, -1) <
    //                v (1, -2)
    mutating func rotate(dir: Direction, val: Int, ccw: Bool) {
        let rotation = ccw ? val : 360 - val
        if rotation == 90 {
            self = CGPoint(x: -1 * self.y, y: self.x)
        } else if rotation == 180 {
            self = CGPoint(x: -1 * self.x, y: -1 * self.y)
        } else if rotation == 270 {
            self = CGPoint(x: self.y, y: -1 * self.x)
        }
    }
    
    mutating func move(dir: Direction, val: CGFloat) {
        switch dir {
        case .East:
            self.x += CGFloat(val)
        case .North:
            self.y += CGFloat(val)
        case .West:
            self.x -= CGFloat(val)
        case .South:
            self.y -= CGFloat(val)
        }
    }
    
    mutating func moveTo(waypoint: CGPoint, val: CGFloat) {
        self.x += waypoint.x * val
        self.y += waypoint.y * val
    }
}

struct Day12: Day {
    let index: Int = 12
    var input: [Any]
    var instructions: [(action: Character, value: Int)]
    
    init() {
        input = AdventParser<String>(file: "day\(index).txt").inputs() ?? []
        instructions = (input as! [String]).compactMap { (action: $0.first!, value: Int($0.dropFirst())! ) }
    }
    
    func partOne() -> Any {
        var dir = Direction.East
        var pos = CGPoint(x: 0, y: 0)
        
        for instr in instructions {
            switch instr.action {
            case "N": fallthrough
            case "S": fallthrough
            case "E": fallthrough
            case "W":
                pos.move(dir: Direction(c: instr.action), val: CGFloat(instr.value))
            case "F":
                pos.move(dir: dir, val: CGFloat(instr.value))
            case "L":
                dir.rotate(deg: instr.value, ccw: true)
            case "R":
                dir.rotate(deg: instr.value, ccw: false)
            default:
                break
            }
            
        }
        
        return Int(abs(pos.x) + abs(pos.y))
    }
    
    func partTwo() -> Any {
        var dir = Direction.East
        var waypointPos = CGPoint(x: 10, y: 1)
        var pos = CGPoint(x:0, y:0)
        
        for instr in instructions {
            switch instr.action {
            case "N": fallthrough
            case "S": fallthrough
            case "E": fallthrough
            case "W":
                waypointPos.move(dir: Direction(c: instr.action), val: CGFloat(instr.value))
                break
            case "F":
                pos.moveTo(waypoint: waypointPos, val: CGFloat(instr.value))
                break
            case "L":
                dir.rotate(deg: instr.value, ccw: true)
                waypointPos.rotate(dir: dir, val: instr.value, ccw: true)
            case "R":
                dir.rotate(deg: instr.value, ccw: false)
                waypointPos.rotate(dir: dir, val: instr.value, ccw: false)
            default:
                break
            }
        }
        
        return Int(abs(pos.x) + abs(pos.y))
    }
}
