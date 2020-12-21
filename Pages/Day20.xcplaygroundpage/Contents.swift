import Foundation

// --- Day 20: ---

//guard let url = Bundle.main.url(forResource: "input", withExtension: "txt") else { fatalError()}
guard let url = Bundle.main.url(forResource: "Day20-example", withExtension: "txt") else {fatalError()}

guard let inputFile = try? String(contentsOf: url).lines else {fatalError()}
var input = inputFile.split {$0 == "" }.map {Array($0) }
input.count
print(input)

struct Tile {
	var a = [".........."]
	var b = [".........."]
	var c = [".........."]
	var d = [".........."]

	var matchingA: [Tile] = []
	var matchingB: [Tile] = []
	var matchingC: [Tile] = []
	var matchingD: [Tile] = []

	var name: String = ""

	mutating func flipHorizontally() {
		// a and c are reversed and b and d swapped
	}

	mutating func flipVertically() {
		// b and d are reversed and a and c swapped
	}
	mutating func rotateLeft() {
		// a is now d , b is now a etc
	}
	mutating func rotateRight() {
		// a is now b etc
	}
}

class Photo {
	var matrix: [[Tile]] = []
	init(_ input: [[String]]) {
		//self.tiles =
	}
	func addTile(_ tile: Tile) {

	}
	func getTile(_ x: Int, y: Int) {

	}
}






print("Solution part one : ")
