//: [Previous](@previous)

import Foundation

//: [Next](@next)


// --- Day 8: Handheld Halting ---

guard let url = Bundle.main.url(forResource: "input", withExtension: "txt") else {fatalError()}
//guard let url = Bundle.main.url(forResource: "day8-example", withExtension: "txt") else {fatalError()}
guard let input = try? String(contentsOf: url).lines else {fatalError()}
let instructions: [(operation: Operation, argument: Int)] = input.compactMap { line in
	if let capturedGroups = line.getCapturedGroupsFrom(regexPattern: "^(\\w{3}) ([+|-]\\d+)") {
		if let operation = Operation(capturedGroups[0]) {
			return (operation: operation, argument: Int(capturedGroups[1]) ?? 0)
		}}
	return nil
}
print(instructions) //[(operation: acc, argument: -17), (operation: nop, argument: 318),
//print(input)
enum Operation: String, CustomStringConvertible {
	case acc, jmp, nop
	init?(_ rawValue:String) {
		self.init(rawValue:rawValue)
	}
	var description : String { return self.rawValue }
}
//var visited: [Int: (operation: Operation, argument: Int)] = [:]
var visited: [Int: Bool] = [:]
var counter: Int = 0
var accumulator: Int = 0
while true {
	if visited[counter] != nil {
		break
	}
	visited[counter] = true
	switch instructions[counter].operation {
		case .nop:
			print("nop")
			counter += 1
		case .acc:
			print("acc")
			accumulator += instructions[counter].argument
			counter += 1
		case .jmp:
			print("jmp")
			counter += instructions[counter].argument
	}
	print("counter", counter, "acc", accumulator)
}
print("Solution part 1: ",accumulator) //1394

//print(visited.debugDescription)

// --- part two ---

outerloop : for (key,_)  in instructions.enumerated() {
	// make a copy of  instructions
	var instructionsCopy: [(operation: Operation, argument: Int)] = instructions
	// change one key!
	let operation = instructionsCopy[key].operation
	switch operation {
		case .nop:
			instructionsCopy[key].operation = .jmp
		case .jmp:
			instructionsCopy[key].operation = .nop
		default:
			continue
	}
	accumulator = 0
	counter = 0
	visited = [:]
	while true {
		if counter == instructions.count  { break outerloop }
		if counter >= instructions.count + 1 { print("out of bounds\n\n\n"); continue outerloop }
		if visited[counter] == true {
			break
		}
		visited[counter] = true
		switch instructionsCopy[counter].operation {
			case .nop:
				counter += 1
			case .acc:
				accumulator += instructionsCopy[counter].argument
				counter += 1
			case .jmp:
				counter += instructionsCopy[counter].argument
		}
		print("counter", counter, "acc", accumulator)
	}
}
print("solution2: \(accumulator)")
print("end")
