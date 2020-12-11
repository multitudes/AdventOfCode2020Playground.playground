//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

enum AdventError: Error {case fileNotFound, fileNotValid}

struct FileLinesIterator: IteratorProtocol {
	let lines: [Int]
	var currentLine: Int = 0
	init(filename: String) throws {
		guard let url = Bundle.main.url(forResource: filename, withExtension: nil) else {throw AdventError.fileNotFound}
		let contents: String = try String(contentsOf: url)
		lines = contents.lines.compactMap(Int.init).sorted()
	}
	mutating func next() -> Int? {
		guard currentLine < lines.endIndex else { return nil }
		defer {currentLine += 1}
		return lines[currentLine]
	}
}

var input = try? FileLinesIterator(filename: "input.txt")
var accumulator = 1
var partial: Int? = nil
var jolts: [Int: Int] = [:]
var previousOutput = 0
while true {
	if let adapter = input?.next() {
		let joltage = adapter-previousOutput
		previousOutput = adapter
		jolts[joltage, default: 0] += 1
		// part 2
		if joltage == 3 {accumulator *= partial ?? 1; partial = nil}
		if joltage == 1 {
			if partial == nil {partial = 1; continue}
			if partial == 1 {partial = 2; continue}
			if partial! == 2 {partial! += 2; continue}
			if partial! == 4 {partial! += 3; continue}
		}
		continue
	}
	let jolts1 = jolts[1, default: 0]
	let jolts3 = jolts[3, default: 0] + 1

	let solution = jolts1 * jolts3 //1904
	let solution2 = accumulator * (partial ?? 1) //10578455953408
	print("Solution part 1: ", solution) //1904
	print("Solution part 2: ", solution2) // 10578455953408
	break
}

