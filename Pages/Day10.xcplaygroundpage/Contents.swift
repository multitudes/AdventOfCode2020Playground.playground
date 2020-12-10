//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

enum AdventError: Error {
	case fileNotFound, fileNotValid
}

// --- Day 10: Adapter Array ---

guard let url = Bundle.main.url(forResource: "input", withExtension: "txt") else {fatalError()}
//guard let url = Bundle.main.url(forResource: "day10-example2", withExtension: "txt") else {fatalError()}
guard let input = try? String(contentsOf: url).lines.compactMap(Int.init).sorted() else {fatalError()}

var jolts: [Int: Int] = [:]
var previousOutput = 0

for adapter in input {
	let joltage = adapter-previousOutput
	previousOutput = adapter
	jolts[joltage, default: 0] += 1
}
jolts[3, default: 0] += 1
let jolts3 = jolts[3, default: 0]
let jolts1 = jolts[1, default: 0]
print(jolts.description)

let solution = jolts1 * jolts3 //1904

