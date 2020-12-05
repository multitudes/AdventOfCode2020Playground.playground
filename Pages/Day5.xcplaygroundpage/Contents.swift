//: [Previous](@previous)

import Foundation

//: [Next](@next)

let bin = 0b0101100
let seat = 0b101


//Every seat also has a unique seat ID: multiply the row by 8, then add the column. In this example, the seat has ID 44 * 8 + 5 = 357.
let binSpace = "FBFBBFFRLR"
struct BoardingPass {
	var row = 0
	var column = 0
	public var seatID = 0
	var decoding: [(String,String)] = [("F","0"),("B","1"),("R","1"),("L","0")]
	init(_ binarySpace: String) {
		var binString = binarySpace
		decoding.map { binString.replace($0.0, with: $0.1)  }
		//print(binString)
		if let row = Int(binString.prefix(7), radix: 2),
		   let column = Int(binString.suffix(3), radix: 2) {
			self.row = row
			self.column = column
			self.seatID = self.row * 8 + self.column
		}
	}
}

extension String {
	mutating func replace(_ search: String, with replacement: String) {
		self = self.replacingOccurrences(of: search, with: replacement)
	}
}
let testInput = BoardingPass(binSpace)
testInput.row
testInput.column
testInput.seatID

var input: [String] = []
do {
	guard let url = Bundle.main.url(forResource: "input", withExtension: "txt") else {
		fatalError("Input file not found")
	}
	let inputString = try String(contentsOf: url)
	input = inputString.components(separatedBy: .newlines)
	input.removeAll { $0.isEmpty }
}
let seats = input.map {BoardingPass($0).seatID}
let solution1 = seats.reduce(0) {max($0, $1)}
print("solution part 1 is \(solution1)")

let minSeatNumber = input.map {BoardingPass($0).seatID}.reduce(Int.max) {min($0, $1)}
let maxSeatNumber = solution1
let contiguousSet = Set(minSeatNumber...maxSeatNumber)
if let solution2 = contiguousSet.subtracting(Set(seats)).first  {
	print("solution part 2 is \(solution2)")
}  else {
	print("No seats available for you!! ")
}


//607
