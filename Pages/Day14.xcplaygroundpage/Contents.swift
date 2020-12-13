import Foundation

//	--- Day 13: Shuttle Search ---

//guard let url = Bundle.main.url(forResource: "day13-example7", withExtension: "txt") else { fatalError() }
guard let url = Bundle.main.url(forResource: "input", withExtension: "txt") else { fatalError() }
guard let input: [String] = try? String(contentsOf: url).lines else {fatalError()}

var terminal = input[1].split(separator: ",")
var busses: [(busNumber: Int, timeOffset: Int)] =
	terminal
		.map {String($0)}
		.enumerated()
		.compactMap { (index, element) -> (busNumber: Int, timeOffset: Int)?  in
			if let busNumber = Int(element) {
				let timeOffset = Int(index)
				return (busNumber: busNumber, timeOffset: timeOffset)}
			else {return nil}
	}

func matching(scheduled: (busNumber: Int, timeOffset: Int)) -> Int {
	let busNumber = scheduled.busNumber
	let offset = scheduled.timeOffset
	while true {
		if (time + offset) % busNumber == 0 {
			print("matched!", time  )
			interval *= busNumber
			return time
		}
		time += interval
	}
}

let first = busses.remove(at: 0)
var time = 0 // the time my first bus is leaving
var interval = first.busNumber // the interval to check at first

for bus in busses {
	time = matching(scheduled: bus)
}
print("Solution part 2: ", time ) //408270049879073
