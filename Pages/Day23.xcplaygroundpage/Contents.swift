import Foundation

// --- Day 23: Crab Cups ---

//var input = "389125467"  // test!
var input = "872495136"
print(input)

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

	init(input: String) {
		let inputLabels = Array(input.map {Int(String($0))!})
		print(inputLabels)
		for i in 0..<inputLabels.count {
			append(value: inputLabels[i])
		}
	}
	init() {
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
			print("return cup at \(index) ")
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

var game = Cups(input: input)

game.tail?.next = game.currentCup
game.currentCup?.previous = game.tail


func move() {
	print("currentCup \(game.currentCup!.label)")
	game.currentCup?.label
	game.tail?.label
	game.tail?.next?.label

	var pickedCupsArray: [Int] = []
	for i in 1...4 {
		pickedCupsArray.append(game.cupAt(index: i)!.label)
	}
	pickedCupsArray
	let threeCups = Cups()
	var next = game.currentCup?.next
	print("pick up: \(next!.label) ", terminator: "")
	threeCups.append(value: next!.label) //8
	next = next!.next
	print("\(next!.label) ", terminator: "")
	threeCups.append(value: next!.label) //9
	next = next!.next
	print("\(next!.label)")
	threeCups.append(value: next!.label) //1
	next = next!.next // 2
	 next?.label //2
	threeCups.currentCup?.label //8
	threeCups.tail?.label //1

	// make the cut - just taking away the three cups at this stage
	game.currentCup!.next = next
	game.currentCup!.next?.label // 2

	// look for destination cup - (currentLabel - 1) in cups
	let currentLabel = game.currentCup!.label
	var currentLabelMinusOne = currentLabel - 1
	game.destination = nil
	// first I look in the cups I have from next to the current one
	while true {
		// check my destination is more than zero or I start wrapping the highest
		if currentLabelMinusOne == 0 { currentLabelMinusOne = 9 }
		print("looking for", currentLabelMinusOne, "and next is ", next!.label)

		// check for destination
		if currentLabelMinusOne == next!.label {
			game.destination = next
			print("new destination \(next!.label)")
			break
		}
		// here I did one round!
		if game.currentCup == next  {
			print("I did one round!")
			// if not found then I decrease
			currentLabelMinusOne -= 1;
			}
		next = next!.next
	}
//	// if not found then I decrease
//	var i = 1
//	var highest = 0
//	while true {
//		if next == game.currentCup { i += 1}
//		if next!.label > highest {highest = next!.label}
//		if next!.label == currentLabel - i {
//			print("new destination \(next!.label)")
//			game.destination = next
//			break
//		}
//		next = next?.next
//		if (currentLabel - i) <= 0  {
//			while true {
//				if next!.label == highest  {
//					game.destination = next
//					break
//				}
//				next = next!.next
//				//			print(next!.label)
//			}
//			print("new destination \(game.destination!.label)")
//			break
//		}
//	}
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

for i in 0..<100 {
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
