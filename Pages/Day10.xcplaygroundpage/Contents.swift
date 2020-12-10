//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

enum AdventError: Error {
	case fileNotFound, fileNotValid
}

infix operator ^^
func ^^<I: BinaryInteger>(lhs: I, rhs: I) -> I {
	return I(pow(Double(lhs), Double(rhs)))
}
// --- Day 10: Adapter Array ---

//guard let url = Bundle.main.url(forResource: "input", withExtension: "txt") else {fatalError()}
guard let url = Bundle.main.url(forResource: "day10-example2", withExtension: "txt") else {fatalError()}
guard let input = try? String(contentsOf: url).lines.compactMap(Int.init).sorted() else {fatalError()}

//var jolts: [Int: Int] = [:]
//var previousOutput = 0
//for adapter in input.enumerated() {
//	let joltage = adapter-previousOutput
//	previousOutput = adapter
//	jolts[joltage, default: 0] += 1
//}
//
//jolts[3, default: 0] += 1
//let jolts3 = jolts[3, default: 0]
//let jolts1 = jolts[1, default: 0]
//print(jolts.description)
//
//let solution = jolts1 * jolts3 //1904


// here recursion for every element in the working q
// -> check the range - if one of them is the last element or workking q isempty
// add one to the counter of sequences
var currentAdapter = 0
func checkAdaptersInRange(with currentAdapter: Int) -> Int {
	if currentAdapter == input.last! { return 1 }
	var validSequences = 0
	for i in Range(1...3) {
		if input.contains(currentAdapter + i) {
			validSequences += checkAdaptersInRange(with: currentAdapter + i)
		}
	}
	return validSequences
}

let solution = checkAdaptersInRange(with: currentAdapter)
