import Foundation

// --- Day 22: Crab Combat ---

guard let url = Bundle.main.url(forResource: "input", withExtension: "txt") else { fatalError()}

//guard let url = Bundle.main.url(forResource: "Day22-exampleRecursive", withExtension: "txt") else { fatalError()}
//guard let url = Bundle.main.url(forResource: "Day22-example", withExtension: "txt") else {fatalError()}
guard let inputFile = try? String(contentsOf: url).lines else {fatalError()}
var input = inputFile.split {$0 == "" }.map {Array($0) }
input.count
print(input)

// init
var one = input[0].compactMap {Int($0)}
var two = input[1].compactMap {Int($0)}

//while !one.isEmpty && !two.isEmpty {
//	func playRound() {
//		let topOne = one.remove(at: 0); let topTwo = two.remove(at: 0)
//		if topOne > topTwo {
//			one.append(contentsOf: [topOne, topTwo])
//		} else {
//			two.append(contentsOf: [topTwo, topOne])
//		}
//	}
//	playRound()
//}
//
//one
//two
//
//let range = Range(1...two.count).reversed()
//let sol = zip(range, two).reduce(0) { $0 + $1.0 * $1.1 }
//
//
//print("Solution part one : ", sol)


// start new game
var game = 0
var winningDeck: [Int] = []
func playGame(deck1 one: [Int], deck2 two: [Int]) -> Int {
	var oneCopy = one; var twoCopy = two; game += 1
	var currentGameHistory: Set<String> = [] //init
	var gamesEnd = false

	while !oneCopy.isEmpty && !twoCopy.isEmpty {
		print("/n-----------Game \(game)----------")
		print("Player 1's deck: ", oneCopy)
		print("Player 2's deck: ", twoCopy)

		// check history!
		let historyHash = (oneCopy.map {String($0)}.joined(separator: ".") + "-"
			+ twoCopy.map {String($0)}.joined(separator: "."))
		if !currentGameHistory.insert(historyHash).inserted {
			print("Cards in history! this game won by player one!")
			gamesEnd = true; break
		} else {
			//print("cards inserted in history")
		}

		let topOne = oneCopy.remove(at: 0); let topTwo = twoCopy.remove(at: 0)

		// check if recursion
		if topOne <= oneCopy.count && topTwo <= twoCopy.count {
			print("Recursive Combat")
			game += 1
			let gameResult = playGame(deck1: Array(oneCopy.prefix(topOne)), deck2: Array(twoCopy.prefix(topTwo)))

			if gameResult == 1 {
				oneCopy.append(contentsOf: [topOne, topTwo])
			} else {
				twoCopy.append(contentsOf: [topTwo, topOne])
			}
			continue
		}

		// if no recursion play the game
		if topOne > topTwo {
			oneCopy.append(contentsOf: [topOne, topTwo])
		} else {
			twoCopy.append(contentsOf: [topTwo, topOne])
		}
	}
	print("...anyway, back to previous game ")
	game -= 1
	if twoCopy.isEmpty || gamesEnd {
		winningDeck = oneCopy
		return 1
	} else {
		winningDeck = twoCopy
		return 2
	}
}

let result = playGame(deck1: one, deck2: two)
result
print(winningDeck)
let range = Range(1...winningDeck.count).reversed()
let score = zip(range, winningDeck).reduce(0) { $0 + $1.0 * $1.1 }

print("score: ",score)
// 8017 not

//
//let range2 = Range(1...6).reversed()
//let score2 = zip(range2, [49, 22, 38, 3, 36, 24]).reduce(0) { $0 + $1.0 * $1.1 }
//score2
