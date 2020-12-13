//
//  day13.swift
//  advent2020
//
//  Created by Elliot Barer on 12/12/20.
//

import Foundation

struct Day13: Day {
    let index: Int = 13
    var input: [Any]
    
    init() {
        input = AdventParser<String>(file: "day\(index).txt").inputs() ?? []
    }
    
    func partOne() -> Any {
        let routes = (input[1] as! String).split(separator: ",").compactMap { $0 == "x" ? nil : Int($0) }
        
        let start = Int(input[0] as! String)!
        let earliestRoute = routes.reduce((route: 0, time: Int.max)) { (result, route) in
            let startTime = ((start / route) + 1) * route
            return startTime < result.time ? (route, startTime) : result
        }
        
        return earliestRoute.route * (earliestRoute.time - start)
    }
    
    func partTwo() -> Any {
        let routes = (input[1] as! String).split(separator: ",").enumerated().compactMap { $1 != "x" ? (offset: $0, bus: Int($1)) : nil }

        var mutualStart = 0
        var resolvedRoutes = [Int]()
        while resolvedRoutes.count != routes.count {
            resolvedRoutes = routes.compactMap { (route) in (mutualStart + route.offset) % route.bus! == 0 ? route.bus! : nil }
            if resolvedRoutes.count != routes.count {
                mutualStart += resolvedRoutes.reduce(1) { $0 * $1 }
            }
        }

        return mutualStart
    }
}
