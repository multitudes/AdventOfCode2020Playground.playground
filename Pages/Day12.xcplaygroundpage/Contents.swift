import Foundation


//	--- Day 12: Rain Risk ---

//guard let url = Bundle.main.url(forResource: "day12-example", withExtension: "txt") else { fatalError() }
guard let url = Bundle.main.url(forResource: "input", withExtension: "txt") else { fatalError() }
guard let input: [String] = try? String(contentsOf: url).components(separatedBy: .whitespacesAndNewlines).dropLast() else {fatalError()}

var trajectory: [(action: Action, param: Int)] = input.map {
	let instruction = Array($0)
	let action = instruction.first!
	let parameter = instruction[1...]
	return (action: Action(rawValue: action)!, param: Int(String(parameter))! )
}

enum Action: Character {
	case forward = "F"; case north = "N"; case south = "S"; case east = "E"; case west = "W"
	case turnRight = "R"; case turnLeft = "L";
}

enum Direction: Int, CaseIterable {
	case east, south, west, north
	static var facing = Direction.east
	static func turnLeft(_ degrees: Int){
		if let currentDirection = allCases.firstIndex(of: facing) {
			let idx = (currentDirection + allCases.count - (degrees / 90)) % allCases.count
			facing = Direction(rawValue: idx)!
			//print(facing)
		}}
	static func turnRight(_ degrees: Int){
		if let currentDirection = allCases.firstIndex(of: facing) {
			let idx = (currentDirection + allCases.count + (degrees / 90)) % allCases.count
			facing = Direction(rawValue: idx)!
			//print(facing)
		}
	}
}

func move(_ direction: Direction, amount: Int) {
	switch Direction.facing {
		case .north:
			position.y += amount
		case .south:
			position.y -= amount
		case .east:
			position.x += amount
		case .west:
			position.x -= amount
	}
}

func decode(_ action: Action, amount: Int) {
	switch action {
		case .forward :
			// move forward
			move(Direction.facing, amount: amount)
		case .west:
			position.x -= amount
		case .south:
			position.y -= amount
		case .north:
			position.y += amount
		case .east:
			position.x += amount
		case .turnRight:
			Direction.turnRight(amount)
		case .turnLeft:
			Direction.turnLeft(amount)
	}
}


var position: (x: Int, y: Int) = (0,0)

for instruction in trajectory {
	decode(instruction.action, amount: instruction.param)
}
print(position)
let manhattanDistance = abs(position.x) + abs(position.y)

//
//
//
//print(Direction.allCases)
//Direction.turnLeft(90)
//Direction.turnRight(90)

//var directionToHead = Direction.east
//Direction.facing = .south
//switch Direction.facing {
//	case .north:
//		print("Lots of planets have a north")
//	case .south:
//		print("Watch out for penguins")
//	case .east:
//		print("Where the sun rises")
//	case .west:
//		print("Where the skies are blue")
//}
//


//print("Solution part 1: ", solution1) //
//print("Solution part 2: ", solution2) //


