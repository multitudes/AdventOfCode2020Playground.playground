//: [Previous](@previous)

import Foundation


//: [Next](@next)

guard let url = Bundle.main.url(forResource: "input", withExtension: "txt") else {fatalError()}
//guard let url = Bundle.main.url(forResource: "day9-example", withExtension: "txt") else {fatalError()}
guard let input = try? String(contentsOf: url).lines.compactMap(Int.init) else {fatalError()}

//var input = inputLines
let preamble = 25; var workingQueue = input.prefix(preamble)
var runningIndex = preamble; let count = input.count
while runningIndex < count {
	let next = input[runningIndex]
	if !checksums(queue: workingQueue, with: next).isValid {
		print("Solution part 1: ", next) //18272118
		print("Solution part 2: ", checkForRange(with: next) ?? 0) // 2186361
		break
	}
	workingQueue = workingQueue.dropFirst()
	workingQueue.append(next)
	runningIndex += 1
}

func checkForRange(with invalidNumber: Int) -> Int? {
	for i in 0..<count {
		var partialSum = 0; runningIndex = i
		var subSequence: Array<Int>.SubSequence = []
		while runningIndex < count - 1 {
			let currentNumber = input[runningIndex]
			runningIndex += 1; partialSum += currentNumber
			subSequence.append(currentNumber)
			if partialSum >  invalidNumber {break}
			if partialSum == invalidNumber {
				if subSequence.count == 1 {continue}
				return subSequence.sorted().first! + subSequence.sorted().last!
			}
		}
	}
	return nil
}

//check the workingQ is valid!
func checksums(queue: Array<Int>.SubSequence, with next: Int) -> (isValid:Bool, solution: Int? ) {
	let q = queue.sorted();	let lastIndex = q.count - 1
	var first:Int = 0; var last: Int = lastIndex
	if q[lastIndex] + q[lastIndex-1] < next {return (false, next)}
	while first < last {
		let sum = q[first] + q[last]
		switch sum  {
			case next : return (true, nil)
			case (..<next): first += 1;	continue
			default: last -= 1;	continue
		}
	}
	return (false, next)
}





