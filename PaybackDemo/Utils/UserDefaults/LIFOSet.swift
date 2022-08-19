//
//  LIFOSet.swift
//  PaybackDemo
//
//

import Foundation

struct LIFOSet<T: Equatable & Codable> : Codable {
    private(set) var array: [T] = []

    init(from elements: [T] = [] ) {
        array = elements
    }

    var content: [T] {
        return array
    }

    var isEmpty: Bool {
        return array.isEmpty
    }

    var count: Int {
        return array.count
    }

    func contains(_ element: T) -> Bool {
        return array.contains(element)
    }

    mutating func push(_ element: T) {
        pop(element)
        array.insert(element, at: 0)
    }

    mutating func pop(_ element: T) {
        array.removeAll(where: { $0 == element })
    }

    mutating func pop(_ elements: [T]) {
        array.removeAll(where: elements.contains)
    }

    mutating func popLast() {
        _ = array.popLast()
    }

    mutating func clear() {
        array.removeAll()
    }
}
