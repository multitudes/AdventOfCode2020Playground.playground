import Foundation

// --- Day 25

guard let url = Bundle.main.url(forResource: "input", withExtension: "txt") else { fatalError()}
//guard let url = Bundle.main.url(forResource: "Day22-example", withExtension: "txt") else {fatalError()}

guard let inputFile = try? String(contentsOf: url).lines else {fatalError()}
var input = inputFile.split {$0 == "" }.map {Array($0) }
input.count
print(input)

// init
var one = input[0].compactMap {Int($0)}
var two = input[1].compactMap {Int($0)}

while !one.isEmpty && !two.isEmpty {
	func playRound() {
		let topOne = one.remove(at: 0); let topTwo = two.remove(at: 0)
		if topOne > topTwo {
			one.append(contentsOf: [topOne, topTwo])
		} else {
			two.append(contentsOf: [topTwo, topOne])
		}
	}
	playRound()
}

one
two

let range = Range(1...two.count).reversed()
let sol = zip(range, two).reduce(0) { $0 + $1.0 * $1.1 }


print("Solution part one : ", sol)
