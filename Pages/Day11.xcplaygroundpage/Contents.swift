//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)


//	--- Day 11: Seating System ---

guard let url = Bundle.main.url(forResource: "day11-example", withExtension: "txt") else { fatalError() }
guard let input: [String] = try? String(contentsOf: url).lines else {fatalError()}

input
enum SeatState { case occupied, empty, floor }
struct Position: Equatable, Hashable { var x: Int; var y: Int }
class Seat: Equatable, Hashable {
	static func == (lhs: Seat, rhs: Seat) -> Bool {
		lhs.position == rhs.position
	}
	init(position: Position, seatState: SeatState){
		self.position = position
		self.seatState = seatState
	}
	var seatState: SeatState
	var position: Position //(x: Int, y: Int)
}
struct SeatMap {
	var seats: [Seat] = []
	var adjacents: [Seat:[Seat]] = [:]
	func addAjacents(for seat: Seat) {
		for _ in 0...7 {

		}
	}
	init(input: [String]) {
		var rowCount = input.count;	var colCount = input[0].count
		for (idxRow,row) in input.enumerated() {
			for (idxCol, char) in row.enumerated() {
				let seatState: SeatState = char == "L" ? SeatState.occupied : SeatState.floor
				let seat = Seat(seatState: seatState, position: Position(x: idxCol, y: idxRow))
				self.seats.append(seat)
				//addAjacents(for: seat)

				for _ in 0...7 {
					if row[idxCol - 1][idxRow-1] == "L" {adjacents[seat]?.append(Seat(seatState: seatState, position: Position(x: idxCol, y: idxRow)))}
					if row[idxCol - 1][idxRow] == "L" {}
					if row[idxCol - 1][idxRow+1] == "L" {}
					if row[idxCol - 1][idxRow-1] == "L" {}
				}
				print(seat)
			}
		}
	}
}
var newSeatMap = SeatMap(input: input)

for row in input {
	let seatRow = row.replacingOccurrences(of: "L", with: "#")
	print(seatRow)
}

