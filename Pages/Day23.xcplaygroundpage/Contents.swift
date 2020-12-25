import Foundation

// --- Day 23: Crab Cups ---


var input = "389125467"  // test!
//var input = 872495136
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
	//var threeCups: Cups
	init() {}

	public func move() {

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
//		while node != nil && node != currentCup {
//			text += "\(node!.label)"
//			node = node!.next
//
//		}
		return text
	}
}

let inputLabels = Array(input.map {Int(String($0))!})
print(inputLabels)

var game = Cups()
for i in 0..<inputLabels.count {
	game.append(value: inputLabels[i])
}
game.tail?.next = game.currentCup
game.currentCup?.previous = game.tail


func move() {
	print("currentCup \(game.currentCup!.label)")
	game.currentCup?.label
	game.tail?.label
	game.tail?.next?.label

	let threeCups = Cups()
	var next = game.currentCup?.next
	print("pick up: \(next!.label) ", terminator: "")
	threeCups.append(value: next!.label)
	next = next!.next
	print("\(next!.label) ", terminator: "")
	threeCups.append(value: next!.label)
	next = next!.next
	print("\(next!.label)")
	threeCups.append(value: next!.label)
	next = next!.next
	next?.label
	threeCups.currentCup?.label //8
	threeCups.tail?.label //1

	threeCups.tail?.next = next
	// make the cut
	game.currentCup!.next = next
	game.currentCup!.next?.label
	let currentLabel = game.currentCup!.label
	game.destination = nil
	var i = 1
	var highest = 0
	while true {
		if next == game.currentCup { i += 1}
		if next!.label > highest {highest = next!.label}
		if next!.label == currentLabel - i {
			print("new destination \(next!.label)")
			game.destination = next
			break
		}
		next = next?.next
		if (currentLabel - i) <= 0  {
			while true {
				if next!.label == highest  {
					game.destination = next
					break
				}
				next = next!.next
				//			print(next!.label)
			}
			print("new destination \(game.destination!.label)")
			break
		}
	}

	let cut = game.destination!.next
	//print("inserting between \(game.destination!.label) and \(cut!.label)")
	game.destination?.next = threeCups.currentCup
	threeCups.tail?.next = cut

	game.currentCup = game.currentCup?.next
	print("new current cup \(game.currentCup!.label)")
	game.currentCup?.label
}

for i in 0..<10 {
print("-- move \(i + 1) --")
move()
	print(game.description)
}

var solution = game.description + game.description
let startIndex = solution.startIndex
let i = solution.firstIndex(of: "1")!

solution.removeSubrange(startIndex...i)
let k = solution.lastIndex(of: "1")!
solution.removeSubrange(k...)
print("solution ", solution)

