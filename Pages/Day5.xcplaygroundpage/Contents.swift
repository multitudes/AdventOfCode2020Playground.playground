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
	init(binarySpace: String) {
		var binString = binarySpace
		decoding.map { binString.replace($0.0, with: $0.1)  }
		print(binString)
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
let testInput = BoardingPass(binarySpace: binSpace)
testInput.row
testInput.column
testInput.seatID

