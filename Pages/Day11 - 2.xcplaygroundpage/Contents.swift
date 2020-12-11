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

func checkAdjacentsAreOccupied(row i: Int, col k: Int) -> Int {
	var adjacents = 0
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

func oneSeatingShuffle(_ seatMap: [[Character]], with currentSeat: SeatState ) ->  (nextMap: [[Character]], isSameState: Bool, occupiedSeats: Int) {
	let maxColumns = seatMap[0].count; let maxRows = seatMap.count
	var nextSeatMap = seatMap; var occupiedSeats = 0
	for i in 1..<maxRows - 1 {
		for k in 1..<maxColumns - 1 {
			if seatMap[i][k] == SeatState.occupied.rawValue {occupiedSeats += 1 }
			if ". ".contains(seatMap[i][k]) {continue}
			let adjacents = checkAdjacentsAreOccupied(row: i, col: k)
			if currentSeat == SeatState.empty {
				if adjacents == 0 {	nextSeatMap[i][k] = SeatState.occupied.rawValue }
			} else if currentSeat == SeatState.occupied {
				if adjacents >= 4  { nextSeatMap[i][k] = SeatState.empty.rawValue }
			}
		}
	}
	for map in nextSeatMap {
		print(map.map { String($0)}.joined())}
	print("same than last? ",seatMap == nextSeatMap, "occupiedSeats", occupiedSeats)
	return (nextMap: nextSeatMap, isSameState: seatMap == nextSeatMap, occupiedSeats: occupiedSeats)
}

var isSame = false
var seatState = SeatState(rawValue: "L")!
var occupiedSeats = 0
while isSame == false {
	(seatMap, isSame, occupiedSeats) = oneSeatingShuffle(seatMap, with: seatState)
	seatState = SeatState.toggle(seatState)
}
print("solution: ", occupiedSeats)


