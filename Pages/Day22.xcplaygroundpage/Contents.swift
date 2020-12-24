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
var currentGameHistory: Set<String> = [] //init

func playGame(deck1 one: [Int], deck2 two: [Int]) -> (winner: Int, gamesEnded: Bool, winningDeck: [Int]) {
	var gamesEnd = false
	var oneCopy = one; var twoCopy = two
	var currentGameHistory: Set<String> = [] //init

	while !oneCopy.isEmpty && !twoCopy.isEmpty {
		print("Player 1's deck: ", oneCopy)
		print("Player 2's deck: ", twoCopy)
		//print("currentGameHistory ", currentGameHistory)

		// check history!
		let historyHash = (oneCopy.map {String($0)}.joined(separator: ".") + "-"
			+ twoCopy.map {String($0)}.joined(separator: "."))

		if !currentGameHistory.insert(historyHash).inserted {
			print("Cards in history! game won by player one!")
			print(historyHash)
			print("winningDeck: ",oneCopy )
			gamesEnd = true
			break
		} else {print("cards inserted in history")}


		let topOne = oneCopy.remove(at: 0); let topTwo = twoCopy.remove(at: 0)

		// check if recursion
		if topOne <= oneCopy.count && topTwo <= twoCopy.count {
			print("Recursive Combat")
			let gameResult = playGame(deck1: Array(oneCopy.prefix(topOne)), deck2: Array(twoCopy.prefix(topTwo)))
			if gameResult.gamesEnded {
				gamesEnd = true
				oneCopy.insert(topOne, at: 0)
				break
				}
			if gameResult.winner == 1 {
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

	if twoCopy.isEmpty || gamesEnd {
		return (winner: 1, gamesEnded: gamesEnd, winningDeck: oneCopy)
	} else {
		return (winner: 2, gamesEnded: false, winningDeck: twoCopy) }
}

let result = playGame(deck1: one, deck2: two)
result.winner
print(result.winningDeck)
let range = Range(1...result.winningDeck.count).reversed()
let score = zip(range, result.winningDeck).reduce(0) { $0 + $1.0 * $1.1 }

print("score: ",score)
// 8017 not


let range2 = Range(1...6).reversed()
let score2 = zip(range2, [49, 22, 38, 3, 36, 24]).reduce(0) { $0 + $1.0 * $1.1 }
score2
