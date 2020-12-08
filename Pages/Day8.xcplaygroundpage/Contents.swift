//: [Previous](@previous)

import Foundation

//: [Next](@next)


// --- Day 8: Handheld Halting ---

enum Operation: String, CustomStringConvertible {
	case acc, jmp, nop
	init?(_ rawValue:String) {
		self.init(rawValue:rawValue)
	}
	var description : String { return self.rawValue }
}

guard let url = Bundle.main.url(forResource: "input", withExtension: "txt") else {fatalError()}
//guard let url = Bundle.main.url(forResource: "day8-example", withExtension: "txt") else {fatalError()}
guard let input = try? String(contentsOf: url).lines else {fatalError()}
var instructions: [(operation: Operation, argument: Int)] = input.compactMap { line in
	if let capturedGroups = line.getCapturedGroupsFrom(regexPattern: "^(\\w{3}) ([+|-]\\d+)") {
		if let operation = Operation(capturedGroups[0]) {
			return (operation: operation, argument: Int(capturedGroups[1]) ?? 0)
		}}
	return nil
}
func runBootCode(bootCode instructions: inout [(operation: Operation, argument: Int)]) -> (infiniteLoop: Bool, accumulator: Int) {
	var visited: [Int: Bool] = [:];	var counter: Int = 0; var accumulator: Int = 0
	while true {
		if counter == instructions.count {
			return (infiniteLoop: false, accumulator: accumulator) }
		if visited[counter] != nil {break} else {visited[counter] = true}
		switch instructions[counter].operation {
			case .nop: counter += 1
			case .acc: accumulator += instructions[counter].argument
				counter += 1
			case .jmp: counter += instructions[counter].argument
		}
	}
	return (infiniteLoop: true, accumulator: accumulator)
}

var accumulator = runBootCode(bootCode: &instructions).accumulator
print("Solution part 1: ", accumulator) //1394

// --- part two ---

outerloop : for (key,_)  in instructions.enumerated() {
	var instructionsCopy: [(operation: Operation, argument: Int)] = instructions
	let operation = instructionsCopy[key].operation
	switch operation {
		case .nop: instructionsCopy[key].operation = .jmp
		case .jmp: instructionsCopy[key].operation = .nop
		default: continue
	}
	let result = runBootCode(bootCode: &instructionsCopy)
	if result.infiniteLoop == true {
		continue outerloop } else { accumulator = result.accumulator }
}
print("Solution part 2: \(accumulator)")//1626
