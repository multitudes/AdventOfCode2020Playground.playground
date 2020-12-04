//: [Previous](@previous)

import Foundation

//: [Next](@next)

var input: [String] = []

do {
	guard let fileUrl = Bundle.main.url(forResource: "input", withExtension: "txt") else {
		print("error input not found")
		fatalError()
	}
	let inputString = try String(contentsOf: fileUrl)
	input = inputString.split(separator: "\n").compactMap { String($0)}
	//input = [1721, 979, 366, 299, 675, 1456]
	//input = [1, 2, 5, 7, 9, 12]
} catch {
	print(error.localizedDescription)
}

struct Password {
	let frequency: ClosedRange<Int>
	let char: Character
	let string: String
	let pos1: Int?
	let pos2: Int?

	var isValid: Bool {
		self.frequency ~= self.string.reduce(0) {
			$1 == self.char ? $0 + 1 : $0
		}
	}

	var isValidForNewPolicy: Bool {
		if let pos1 = pos1, let pos2 = pos2 {
			return (string[pos1-1] == char) != (string[pos2-1] == char)
		}
		return false
	}
	init(_ password: String) {
		let res = password.groups(for:"(\\d+)-(\\d+) ([a-z]). ([a-z]+)")
		self.frequency = Int(res[1])!...Int(res[2])!
		self.char = Character(res[3])
		self.string = res[4]
		self.pos1 = Int(res[1])
		self.pos2 = Int(res[2])
	}
}

extension String {
	func groups(for regexPattern: String) -> [String] {
		do {
			let text = self
			let regex = try NSRegularExpression(pattern: regexPattern)
			let matches = regex.matches(in: text,
										range: NSRange(text.startIndex..., in: text))
			return matches.map { match in
				return (0..<match.numberOfRanges).map {
					let rangeBounds = match.range(at: $0)
					guard let range = Range(rangeBounds, in: text) else {
						return ""
					}
					return String(text[range])
				}
			}.flatMap { $0 }
		} catch let error {
			print("invalid regex: \(error.localizedDescription)")
			return []
		}
	}

	subscript(idx: Int) -> Character {
		Character(extendedGraphemeClusterLiteral: self[index(startIndex, offsetBy: idx)])
	}
	subscript(idx: Int) -> String {
		String(self[index(startIndex, offsetBy: idx)])
	}
}


let password = Password(input[0])
password.string
password.char
password.frequency
password.isValid

let startTime = CFAbsoluteTimeGetCurrent()
print("Using PLAYGROUNDS \n")

let solution = input.filter { Password($0).isValid }.count
print("The solution for the first challenge is: ", solution, "\n")
let timeElapsed = CFAbsoluteTimeGetCurrent() - startTime

let startTime2 = CFAbsoluteTimeGetCurrent()
let solution2 = input.filter { Password($0).isValidForNewPolicy }.count
print("The solution for the second challenge is: ", solution2, "\n")
let timeElapsed2 = CFAbsoluteTimeGetCurrent() - startTime2


print("Time elapsed for the challenge 1 is: \(timeElapsed, specifier: "%.2f") seconds")
print(String("Time elapsed for the challenge 2 is: \(timeElapsed2, specifier: "%.2f") seconds"))

extension String.StringInterpolation {
	mutating func appendInterpolation(_ number: Double, specifier: String){
		appendLiteral(String(format:"%.2f", number))
	}
}



