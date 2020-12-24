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

class Cups {
	var currentCup: Cup? = Cup(label: 0)
	var destination: Cup? = Cup(label: 0)
	var tail: Cup?

	//var threeCups: Cups
	init() {

	}

	public func move() {

	}

	public func append(value: Int) {
		let newCup = Cup(label: value)
		if let lastCup = tail {
			newCup.previous = lastCup
			lastCup.next = newCup
		} else {
			currentCup = newCup
		}
		tail = newCup
	}
}

let inputLabels = Array(input.map {Int(String($0))!})
print(inputLabels)

var game = Cups()
for i in 0..<inputLabels.count {
	print("value: \(inputLabels[i]) ")
	game.append(value: inputLabels[i])
}
game.tail?.next = game.currentCup
game.currentCup?.previous = game.tail


game.currentCup?.label
game.tail?.label
game.tail?.next?.label


var cup = game.currentCup?.label

var threeCups = Cups()
var next = game.currentCup?.next
threeCups.append(value: next!.label)
next = next!.next
threeCups.append(value: next!.label)
next = next!.next
threeCups.append(value: next!.label)
next = next!.next
threeCups.currentCup?.label //8
threeCups.tail?.label //1

game.currentCup?.next = next?.next
var currentLabel = game.currentCup!.label
var i = 1
while next != game.tail {
	if next?.label == currentLabel - i {
		game.destination = next
		break
	}
	print(next!.label)
}
game.destination?.label
