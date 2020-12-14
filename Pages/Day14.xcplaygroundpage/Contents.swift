import Foundation

//	--- Day 14: Docking Data ---

guard let url = Bundle.main.url(forResource: "day14-example", withExtension: "txt") else { fatalError() }
//guard let url = Bundle.main.url(forResource: "input", withExtension: "txt") else { fatalError() }
guard let input: [String] = try? String(contentsOf: url).lines else {fatalError()}

var mask = ""
var mem: [Int:Int] = [:]
var partOne = false
for line in input {
	if line.prefix(7) == "mask = " {
		mask = String(line.dropFirst(7))
		continue
	}
	if let regexGroup = line.getCapturedGroupsFrom(regexPattern: "^mem\\[(\\d+)\\] = (\\d+)$") {
		let dictKey = Int(regexGroup[0])!; let inputValue = Int(regexGroup[1])!
		// write to dict
		if partOne {
			let orBitMask = Int(mask.replacingOccurrences(of: "X", with: "0"), radix: 2)!
			let andBitMask = Int(mask.replacingOccurrences(of: "X", with: "1"), radix: 2)!
			let valueToWrite = (inputValue | orBitMask) & andBitMask
			mem[dictKey] = valueToWrite
		} else {
			
		}
	}
}
var solution1  = 0
solution1 = mem.keys.reduce(solution1) { $0 + mem[$1]! }
print("Solution part 1: ", solution1)







//let a = Int("000000000000000000000000000000001011", radix: 2)
//let b = Int("000000000000000000000000000001000000", radix: 2)
//let c = a! | b!


//print(String(1000435, radix: 2))

extension String {
	mutating func replace(_ search: String, with replacement: String) {
		self = self.replacingOccurrences(of: search, with: replacement)
	}
	func replacing(_ search: String, with replacement: String) -> String {
		self.replacingOccurrences(of: search, with: replacement)
	}
}

