import Foundation

let input = [14,3,1,0,9,5]
let inputExample1 = [0,3,6]

let startingNumbers = input

var inputIndices = startingNumbers.indices.map {$0 + 1}
// the key is the number / the value last index seen

let tuples = zip(startingNumbers, inputIndices)
var inputDict: [Int: Int] = Dictionary(uniqueKeysWithValues: tuples)
var visitedNumbers: [Int: (idx: Int, previousIdx: Int?)] = inputDict.mapValues { value in
	(idx: value, previousIdx: nil)
}

var idx = inputIndices.count
var last = startingNumbers[idx - 1]
func speakNumber() {
	idx += 1
	if let visited = visitedNumbers[last] {
		if let previousIdx = visited.previousIdx {
			let age = visited.idx - previousIdx
			last = age
			if let visitedAge = visitedNumbers[last] {
				let ageidx = visitedAge.idx
				visitedNumbers[last] = (idx: idx, previousIdx: ageidx)
			} else {
				visitedNumbers[last] = (idx: idx, previousIdx: nil)
			}
		} else {
			last = 0;
			if let visitedZero = visitedNumbers[0] {
				visitedNumbers[0] = (idx: idx, previousIdx: visitedZero.idx)
			}
		}
	}
}

while idx < 2020 {
speakNumber()
}
print("solution to part 1", last) // 614

// 30000000
