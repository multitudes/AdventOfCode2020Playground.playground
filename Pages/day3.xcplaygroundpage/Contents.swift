//: [Previous](@previous)

import Foundation


//: [Next](@next)

var input: [String] = []

do {
	guard let url = Bundle.main.url(forResource: "input", withExtension: "txt") else { fatalError("File not found")}
	let inputString = try String(contentsOf: url)
	input = inputString.split(separator: "\n").compactMap {String($0) }
}

//let inputFile: String =
	"""
..##.......
#...#...#..
.#....#..#.
..#.#...#.#
.#...##..#.
..#.##.....
.#.#.#....#
.#........#
#.##...#...
#...##....#
.#..#...#.#
"""

enum Location: Character {
	case open = "."
	case tree = "#"
	case checkedTree = "🌲"
	case checkedOpen = "⛷"
}

	func jump(from position:(x: Int, y: Int), with offset: (x: Int, y: Int)) -> (Int,Int) {
		return (x: position.x + offset.x, y: position.y + offset.y)
	}

	func descend(slope input: [String] ,with stride: (x: Int, y: Int)) -> Int {
		var trees = 0
		var position: (x: Int, y: Int ) = (0,0)
		var row: [Character]

		while position.y < input.count {
			row = Array(input[position.y])
			if row[position.x] == Location.open.rawValue {
				row[position.x] = Location.checkedOpen.rawValue
				print(String(row.map {String($0)}.joined()))
			} else if row[position.x] == Location.tree.rawValue {
				row[position.x] = Location.checkedTree.rawValue
				print(String(row.map {String($0)}.joined()))
				trees += 1
			}
			position = jump(from: position, with: stride )
			position.x = position.x % row.count
		}

		return trees
	}
	let stride = (x: 3, y: 1)
	let solution1 = descend(slope: input, with: stride)

	let strides: [(Int,Int)] = [(x: 1, y: 1),(x: 3, y: 1),(x: 5, y: 1),(x: 7, y: 1),(x: 1, y: 2)]
	let solution2 = strides.map { descend(slope: input, with: $0)}.reduce(1, *)

print("\nThe solution for the first challenge is: ", solution1)
print("The solution for the second challenge is: ", solution2, "\n")
