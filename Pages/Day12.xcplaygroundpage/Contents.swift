import Foundation


//	--- Day 12: Rain Risk ---

guard let url = Bundle.main.url(forResource: "day12-example", withExtension: "txt") else { fatalError() }
//guard let url = Bundle.main.url(forResource: "input", withExtension: "txt") else { fatalError() }
guard let input: [String] = try? String(contentsOf: url).components(separatedBy: .whitespacesAndNewlines).dropLast() else {fatalError()}

var trajectory: [(action: Character, param: Int)] = input.map {
	let instruction = Array($0)
	let parameter = instruction[1...]
	return (action: instruction.first!, param: Int(String(parameter))! ) }

enum Direction: Int, CaseIterable {
	case east, south, west, north
	static var aHead = Direction.east
	static func turn(_ turning: String, degrees: Int){
		if turning == "left" {
			if let currentDirection = allCases.firstIndex(of: aHead) {
				let idx = (currentDirection + allCases.count - (degrees / 90)) % allCases.count
				aHead = Direction(rawValue: idx)!
				print(aHead)
			}
		}
		if turning == "right" {
			if let currentDirection = allCases.firstIndex(of: aHead) {
				let idx = (currentDirection + allCases.count + (degrees / 90)) % allCases.count
				aHead = Direction(rawValue: idx)!
				print(aHead)
			}}
	}
}

var position: (x: Int, y: Int) = (0,0)

func move(_ action: Character, amount: Int) {
	switch action {
		case "F":
			// move forward by action
			switch Direction.aHead {
				case .north:
					position.y += amount
				case .south:
					position.y -= amount
				case .east:
					position.x += amount
				case .west:
					position.x -= amount
			}
		case "W":
			position.x -= amount
		case "S":
			position.y -= amount
		case "N":
			position.y += amount
		case "E":
			position.x += amount
		default:
			<#code#>
	}
}



print(Direction.allCases)
Direction.turn("left", degrees: 90)
Direction.turn("right", degrees: 90)

var directionToHead = Direction.east
Direction.aHead = .south
switch Direction.aHead {
	case .north:
		print("Lots of planets have a north")
	case .south:
		print("Watch out for penguins")
	case .east:
		print("Where the sun rises")
	case .west:
		print("Where the skies are blue")
}



//print("Solution part 1: ", solution1) //
//print("Solution part 2: ", solution2) //

enum Action: Character {
	case forward = "F"
}
