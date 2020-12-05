//: [Previous](@previous)

import Foundation

//: [Next](@next)

// --- Day 5: Binary Boarding ---

guard let url = Bundle.main.url(forResource: "input", withExtension: "txt")
	else {fatalError("Input file not found")}
guard let inputString = try? String(contentsOf: url)
	else { fatalError("Input file not found") }
var input = inputString.components(separatedBy: .newlines)
input.removeAll { $0.isEmpty }

func getSeatID(_ inputString: String) -> Int? {
	if let seatID = Int(Array(inputString).reduce(""){ result, c in
		result + ("FL".contains(c) ? "0" : "1")},radix:  2) {
			return seatID
	} else { print("\nError, invalid seatID received!"); return nil}
}
let seats = input.compactMap {getSeatID($0)}

let maxSeatNumber = seats.reduce(0) {max($0, $1)}
print("solution part 1 is \(maxSeatNumber)")
// 980

let minSeatNumber = seats.reduce(Int.max) {min($0, $1)}
let contiguousSet = Set(minSeatNumber...maxSeatNumber)
if let solution2 = contiguousSet.subtracting(Set(seats)).first  {
	print("solution part 2 is \(solution2)")
}  else {
	print("No seats available for you!! ")
}
//607
