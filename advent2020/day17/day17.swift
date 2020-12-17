//
//  day17.swift
//  advent2020
//
//  Created by Elliot Barer on 12/16/20.
//

import Foundation

struct Cube: CustomStringConvertible {
    var x: Int
    var y: Int
    var z: Int
    var w: Int
    
    var description: String {
        return "(\(x), \(y), \(z), \(w))"
    }
}

extension Cube: Hashable {
    static func == (lhs: Cube, rhs: Cube) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y && lhs.z == rhs.z && lhs.w == rhs.w
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(x)
        hasher.combine(y)
        hasher.combine(z)
        hasher.combine(w)
    }
}

struct Day17: Day {
    let index: Int = 17
    var input: [Any]
    var startingGrid = [Cube]()
    
    init() {
        input = AdventParser<String>(file: "day\(index).txt").inputs() ?? []
        (input as! [String]).enumerated().forEach { (row) in
            row.element.enumerated().filter({ $0.element == "#" }) .forEach { (cube) in
                startingGrid.append(Cube(x: cube.offset, y: row.offset, z: 0, w: 0))
            }
        }
    }
    
    func findNeighbors(grid: [Cube], dim: Int) -> [Cube : Int] {
        var neighbors = [Cube : Int]()
        grid.forEach { (cube) in
            for x in -1...1 {
                for y in -1...1 {
                    for z in -1...1 {
                        if dim == 3 {
                            if x == 0, y == 0, z == 0 { continue }
                            neighbors.increment(cube: Cube(x: cube.x+x, y: cube.y+y, z: cube.z+z, w: 0))
                        } else if dim == 4 {
                            for w in -1...1 {
                                if x == 0, y == 0, z == 0, w == 0 { continue }
                                neighbors.increment(cube: Cube(x: cube.x+x, y: cube.y+y, z: cube.z+z, w: cube.w+w))
                            }
                        }
                    }
                }
            }
        }

        return neighbors
    }
    
    func executeCycles(num: Int, dim: Int, startingGrid: [Cube]) -> Int {
        var grid = startingGrid
        for _ in 0..<num {
            var activeGrid = [Cube]()
            findNeighbors(grid: grid, dim: dim).forEach { (cube, activeNeighbors) in
                if activeNeighbors == 3 {
                    activeGrid.append(cube)
                } else if activeNeighbors == 2 && grid.contains(cube) {
                    activeGrid.append(cube)
                }
            }
            grid = activeGrid
        }
        return grid.count
    }
    
    func partOne() -> Any {
        return executeCycles(num: 6, dim: 3, startingGrid: startingGrid)
    }
    
    func partTwo() -> Any {
        return executeCycles(num: 6, dim: 4, startingGrid: startingGrid)
    }
}

extension Dictionary where Key == Cube, Value == Int {
    mutating func increment(cube: Cube) {
        let val = 1 + ((self[cube] != nil) ? self[cube]! : 0)
        updateValue(val, forKey: cube)
    }
}
