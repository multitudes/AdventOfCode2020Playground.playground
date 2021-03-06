import Foundation

// --- Day 23: Crab Cups ---

var input = "389125467"  // test!
//var input = "872495136"
print(input)
let inputLabels = Array(input.map {Int(String($0))!})
print(inputLabels)

class Cup: Equatable {
	static func == (lhs: Cup, rhs: Cup) -> Bool {
		lhs.label == rhs.label
	}
	var label: Int
	init(label: Int) {
		self.label = label
	}
	var next: Cup?
	var previous: Cup?
}

class Cups: CustomStringConvertible {
	var currentCup: Cup?
	var destination: Cup?
	var tail: Cup?
	var cupOne: Cup?
	var cupCount = 0

	init(input: [Int]) {
		for ii in 0..<input.count {
			self.append(value: input[ii])
		}
	}

	public func move() {
	}

	public func cupAt(index: Int) -> Cup? {
	  // index has to be bigger than zero
	  if index >= 0 {
		// I start with head, my current cup
		var cup = currentCup
		var i = index
		// decrementing of i steps until I get
		while cup != nil {
		  if i == 0 {
			//print("return cup at \(index) ")
			return cup }
		  i -= 1
		  cup = cup!.next
		}
	  }
		// not found
	  return nil
	}

	public func append(value: Int) {
		cupCount += 1
		let newCup = Cup(label: value)
		if let lastCup = tail {
			newCup.previous = lastCup
			lastCup.next = newCup
		} else {
			currentCup = newCup
		}
		tail = newCup

	}

	public func contains(_ label: Int) -> Bool {
		var node = currentCup
			while node != nil {
				if node?.label == label { return true }
				node = node!.next
			}
		return false
	}

	public var description: String {
		var text = ""
		var node = currentCup
		for _ in 0..<cupCount {
			text += "\(node!.label)"
			node = node!.next
		}
		return text
	}
}

var game = Cups(input: inputLabels)

game.tail?.next = game.currentCup
game.currentCup?.previous = game.tail


func move() {
	print("currentCup \(game.currentCup!.label)")
//	game.currentCup?.label
//	game.tail?.label
//	game.tail?.next?.label
//	game.cupAt(index: 0)!.label // currentcup
	var pickedCupsArray: [Int] = []
	for i in 1...3 {
		pickedCupsArray.append(game.cupAt(index: i)!.label)
	}
	pickedCupsArray
	let threeCups = Cups(input: pickedCupsArray)
	var next = game.cupAt(index: 4)!
	next.label
//	threeCups.description
//	threeCups.currentCup?.label //8
//	threeCups.tail?.label //1

	// make the cut - just taking away the three cups at this stage
	game.currentCup!.next = next
	game.currentCup!.next?.label // 2

	// look for destination cup - (currentLabel - 1) in cups
	var currentLabelMinusOne = game.currentCup!.label - 1
	game.destination = nil
	// first I look in the cups I have from next to the current one
	while true {
		// check my destination is more than zero or I start wrapping the highest
		if currentLabelMinusOne == 0 { currentLabelMinusOne = 9 }
		print("looking for", currentLabelMinusOne, "and next is ", next.label)
		// check if currentLabelMinusOne is in picked up cups if so decrease
		if threeCups.contains(currentLabelMinusOne) {
			print("contained in picked cups!")
			// if found then I decrease
			currentLabelMinusOne -= 1; continue
		}
		// check for destination
		if currentLabelMinusOne == next.label {
			game.destination = next
			print("new destination \(next.label)")
			break
		}
		// here I did one round!
		if game.currentCup == next  {
			print("I did one round!")
			// if not found then I decrease
			currentLabelMinusOne -= 1;
			}
		next = next.next!
	}

	// inserting my threeCups list
	let cut = game.destination!.next
	//print("inserting between \(game.destination!.label) and \(cut!.label)")
	game.destination?.next = threeCups.currentCup
	threeCups.tail?.next = cut

	// new currentcup is right on the next cup
	game.currentCup = game.currentCup?.next
	print("new current cup \(game.currentCup!.label)")
	game.currentCup?.label
}

for i in 0..<10 {
print("-- move \(i + 1) --")
move()
	print(game.description)
}
//
var solution = game.description + game.description
let startIndex = solution.startIndex
let i = solution.firstIndex(of: "1")!

solution.removeSubrange(startIndex...i)
let k = solution.lastIndex(of: "1")!
solution.removeSubrange(k...)
print("solution ", solution)
//
//game.cupAt(index: 20)?.label
