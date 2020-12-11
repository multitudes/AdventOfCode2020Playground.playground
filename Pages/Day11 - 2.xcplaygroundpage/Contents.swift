//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

//	--- Day 11: Seating System ---

guard let url = Bundle.main.url(forResource: "day11-example", withExtension: "txt") else { fatalError() }
//guard let url = Bundle.main.url(forResource: "input", withExtension: "txt") else { fatalError() }
guard let input: [String] = try? String(contentsOf: url).components(separatedBy: .whitespacesAndNewlines) else {fatalError()}

enum SeatState: Character {
	case occupied = "#", empty = "L", floor = ".", padding = " "
	static func toggle(_ seatState: SeatState) -> SeatState {
		if seatState == .occupied {return .empty }
		if seatState == .empty {return .occupied }
		return seatState
	}
}

// create seatmap with padding
func createSeatMapWithPadding() -> [[Character]]{
	var seatMap = input.compactMap { string -> [Character]? in
		if !string.isEmpty {
			let newString = " " + string + " "
			return Array(newString)
		}
		return nil
	}
	let inputColumns = seatMap[0].count
	let padding = Array(repeating: Character(" "), count: inputColumns)
	seatMap.insert(padding, at: 0)
	seatMap.append(padding)
	return seatMap
}

func checkAdjacentsAreOccupied(row i: Int, col k: Int, partTwo: Bool ) -> Int {
	var adjacents = 0
	let directions: [(x: Int, y: Int)] = [(x: -1,y: -1),(x: 0, y: -1),(x: 1,y: -1),(x: -1,y: 0),(x: 1,y: 0),(x: -1,y: 1),(x: 0, y: 1),(x: 1,y: 1)]
	if partTwo {
		for direction in directions {
			var xOffset = direction.x; var yOffset = direction.y
			var step = 0
			while true {
				step += 1
				xOffset = step * direction.x ; yOffset = step * direction.y
				if seatMap[i+yOffset][k+xOffset] == SeatState.padding.rawValue {break}
				if seatMap[i+yOffset][k+xOffset] == SeatState.floor.rawValue {}
				if seatMap[i+yOffset][k+xOffset] == SeatState.empty.rawValue {break}
				if seatMap[i+yOffset][k+xOffset] == SeatState.occupied.rawValue {adjacents += 1; break}
			}
		}
		return adjacents
	} else {
	if seatMap[i-1][k-1] == SeatState.occupied.rawValue { adjacents += 1 }
	if seatMap[i-1][k] == SeatState.occupied.rawValue {adjacents += 1 }
	if seatMap[i-1][k+1] == SeatState.occupied.rawValue {adjacents += 1 }
	if seatMap[i][k-1] == SeatState.occupied.rawValue {adjacents += 1 }
	if seatMap[i][k+1] == SeatState.occupied.rawValue {adjacents += 1 }
	if seatMap[i+1][k-1] == SeatState.occupied.rawValue {adjacents += 1 }
	if seatMap[i+1][k] == SeatState.occupied.rawValue {adjacents += 1 }
	if seatMap[i+1][k+1] == SeatState.occupied.rawValue {adjacents += 1 }
	return adjacents
	}
}

func oneSeatingShuffle(_ seatMap: [[Character]], with currentSeat: SeatState, partTwo: Bool = false ) ->  (nextMap: [[Character]], isSameState: Bool, occupiedSeats: Int) {
	let maxColumns = seatMap[0].count; let maxRows = seatMap.count
	var nextSeatMap = seatMap; var occupiedSeats = 0
	var maxVisibleOccupiedSeats: Int = 4; if partTwo { maxVisibleOccupiedSeats = 5}
	for i in 1..<maxRows - 1 {
		for k in 1..<maxColumns - 1 {
			if seatMap[i][k] == SeatState.occupied.rawValue {occupiedSeats += 1 }
			if ". ".contains(seatMap[i][k]) {continue}
			let adjacents = checkAdjacentsAreOccupied(row: i, col: k, partTwo: partTwo)
			if currentSeat == SeatState.empty {
				if adjacents == 0 {	nextSeatMap[i][k] = SeatState.occupied.rawValue }
			} else if currentSeat == SeatState.occupied {
				if adjacents >= maxVisibleOccupiedSeats  { nextSeatMap[i][k] = SeatState.empty.rawValue }
			}
		}
	}
	for map in nextSeatMap {
		print(map.map { String($0)}.joined())}
			//print("same than last? ",seatMap == nextSeatMap, "occupiedSeats", occupiedSeats)
	return (nextMap: nextSeatMap, isSameState: seatMap == nextSeatMap, occupiedSeats: occupiedSeats)
}

var isSame = false;	var seatState = SeatState.empty; var occupiedSeats = 0
var seatMap:[[Character]] = createSeatMapWithPadding()

// part 1 --
while isSame == false {
	(seatMap, isSame, occupiedSeats) = oneSeatingShuffle(seatMap, with: seatState)
	seatState = SeatState.toggle(seatState)
}
let solution1 = occupiedSeats

// part two
isSame = false;	seatState = SeatState.empty; occupiedSeats = 0
seatMap = createSeatMapWithPadding()

while isSame == false {
	(seatMap, isSame, occupiedSeats) = oneSeatingShuffle(seatMap, with: seatState, partTwo: true)
	seatState = SeatState.toggle(seatState)
}
print("Solution part 1: ", solution1) // 2354
print("Solution part 2: ", occupiedSeats) //2072