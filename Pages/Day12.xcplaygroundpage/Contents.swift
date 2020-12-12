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
	static func turn(_ degrees: Int){
		if let currentDirection = allCases.firstIndex(of: facing) {
			let idx = (currentDirection + allCases.count + (degrees / 90)) % allCases.count
			facing = Direction(rawValue: idx)!
		}
	}
}

func moveShip(amount: Int) {
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

func run(_ action: Action, amount: Int) {
	switch action {
		case .forward :
			moveShip(amount: amount)
		case .west:
			position.x -= amount
		case .south:
			position.y -= amount
		case .north:
			position.y += amount
		case .east:
			position.x += amount
		case .turnRight:
			Direction.turn(amount)
		case .turnLeft:
			Direction.turn(-amount)
	}
}

var position: (x: Int, y: Int) = (0,0)

trajectory.map {run($0.action, amount: $0.param)}

print("Solution part 1: ", abs(position.x) + abs(position.y)) //2057
