//: [Previous](@previous)

import Foundation

//: [Next](@next)


// --- Day 8: Handheld Halting ---

guard let url = Bundle.main.url(forResource: "input", withExtension: "txt") else {fatalError()}
//guard let url = Bundle.main.url(forResource: "day8-example", withExtension: "txt") else {fatalError()}
guard let input = try? String(contentsOf: url).lines else {fatalError()}
let instructions: [(operation: Operation, argument: Int)] = input.compactMap { line in
	if let instructionTuple = line.getCapturedGroupsFrom(regexPattern: "^(\\w{3}) ([+|-]\\d+)") {
		if let operation = Operation(rawValue: instructionTuple[0]) {
		return (operation: operation, argument: Int(instructionTuple[1]) ?? 0)
		}}
	return nil
}
instructions
print(input)
enum Operation: String{
	case acc, jmp, nop
}
var visited: [Int: (operation: Operation, argument: Int)] = [:]
//var visited: [Int: Bool] = [:]
var counter: Int = 0
var accumulator: Int = 0
while true {
	if let alreadyVisited = visited[counter] {
		print("Solution part 1: ",accumulator)
		break
	}
	visited[counter] = (operation: instructions[counter].operation , argument: instructions[counter].argument )
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
//
//	if counter >= 8{
//	print("break", "counter",counter )
//	break
//	}
}



//for (index, line) in instructions.enumerated() {
//	program[index] = (instruction:line.instruction, argument: line.argument)
//}
