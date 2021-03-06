import Foundation


//	--- Day 13: Shuttle Search ---

//guard let url = Bundle.main.url(forResource: "day13-example", withExtension: "txt") else { fatalError() }
guard let url = Bundle.main.url(forResource: "input", withExtension: "txt") else { fatalError() }
guard let input: [String] = try? String(contentsOf: url).lines else {fatalError()}
print(input)
let earliest: Int = Int(input[0])!
var next = earliest
let scheduled: [Int] = input[1].split(separator: ",").compactMap {Int($0)}
var departing: [Int] = []

while true {
	departing = scheduled.filter {next % $0 == 0}
	if !departing.isEmpty {
		let myBus = departing.first!
		let solution1 = (next - earliest) * myBus
		print("Solution part 1: ", solution1 ) //222
		break }
	next += 1
}

// -- part two --
let terminal = input[1].split(separator: ",")
var busses: [(number: Int, offset: Int)] =
	terminal.map {String($0)}.enumerated()
		.compactMap { (index, element) -> (number: Int, offset: Int)?  in
			if let number = Int(element) {
				let offset = Int(index)
				return (number: number, offset: offset)}
			else {return nil}
	}

func matching(bus: (number: Int, offset: Int)) -> Int {
	while true {
		if (time + bus.offset) % bus.number == 0 {
			print("matched!", time  )
			interval *= bus.number
			return time
		}
		time += interval
	}
}

let first = busses.remove(at: 0)
var time = 0 // the time my first bus is leaving
var interval = first.number // the interval to check at first

let solution2 = busses.reduce(time) { matching(bus: $1) }

print("Solution part 2: ", solution2 ) //408270049879073






