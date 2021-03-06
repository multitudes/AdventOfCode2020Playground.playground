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

func moveShipsPosition(amount: Int) {
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
			moveShipsPosition(amount: amount)
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

// part 2

let antiClockwiseVector: (x: Int, y: Int) = (x:-1, y: 1)
let ClockwiseVector: (x: Int, y: Int) = (x:1, y: -1)

func turn(_ degrees: Int, direction vector: (x: Int, y: Int)){
	let times = degrees / 90
	for _ in 0..<times {
		 (waypoint.y, waypoint.x) = (waypoint.x, waypoint.y)
		waypoint.x *= vector.x; waypoint.y *= vector.y;
	}
}

func runPartTwo(_ action: Action, amount: Int) {
	switch action {
		case .forward :
			position.x += waypoint.x * amount
			position.y += waypoint.y * amount
		case .west:
			waypoint.x -= amount
		case .south:
			waypoint.y -= amount
		case .north:
			waypoint.y += amount
		case .east:
			waypoint.x += amount
		case .turnRight:
			turn(amount, direction: ClockwiseVector)
		case .turnLeft:
			turn(amount, direction: antiClockwiseVector)
	}
}

// starting values
position = (0,0)
var waypoint: (x: Int, y: Int) = (10,1)

trajectory.map { runPartTwo($0.action, amount: $0.param )}

print("Solution part 2: ", abs(position.x) + abs(position.y)) //71504
