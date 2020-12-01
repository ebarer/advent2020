//
//  helper.swift
//  advent2020
//
//  Created by Elliot Barer on 11/30/20.
//

import Foundation

class AdventParser<T> {
    var fileName: String

    init(file: String) {
        fileName = file
    }

    var inputs: [T] {
        let base = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
        let url = URL(fileURLWithPath: self.fileName, relativeTo: base)

        let contents = try! String(contentsOf: url)
        let entries = contents.split(whereSeparator: \.isNewline)

        if T.self == Int.self {
            return entries.map { Int($0) }.compactMap { $0 } as! [T]
        }

        fatalError()
    }
}
