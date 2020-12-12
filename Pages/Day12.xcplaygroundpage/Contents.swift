import Foundation


//	--- Day 12: Rain Risk ---

guard let url = Bundle.main.url(forResource: "day12-example", withExtension: "txt") else { fatalError() }
//guard let url = Bundle.main.url(forResource: "input", withExtension: "txt") else { fatalError() }
guard let input: [String] = try? String(contentsOf: url).components(separatedBy: .whitespacesAndNewlines).dropLast() else {fatalError()}

input

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

struct Position {
	var x: Int = 0; var y: Int = 0

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
