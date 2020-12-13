import Foundation

//	--- Day 13: Shuttle Search ---

guard let url = Bundle.main.url(forResource: "day13-example3", withExtension: "txt") else { fatalError() }
//guard let url = Bundle.main.url(forResource: "input", withExtension: "txt") else { fatalError() }
guard let input: [String] = try? String(contentsOf: url).lines else {fatalError()}
print(input)

let input1 = 0
var busSchedule = input[1].split(separator: ",")
var busNumbersAndOffsets: [(busNumber: Int, timeOffset: Int)] =
	busSchedule
	.map {String($0)}
	.enumerated()
	.compactMap { (index, element) -> (busNumber: Int, timeOffset: Int)?  in
		if let busNumber = Int(element) {
			let timeOffset = Int(index)
			return (busNumber: busNumber, timeOffset: timeOffset)}
		else {return nil}
	}
print(busNumbersAndOffsets)


func matching(previousTime: Int, busNumberAndOffset: (busNumber: Int, timeOffset: Int)) -> Int {
	let busNumber1 = first.busNumber

	let busNumber2 = busNumberAndOffset.busNumber
	let offset2 = busNumberAndOffset.timeOffset
	while true {

		if (time) % busNumber1 == 0 && (time + offset2) % busNumber2 == 0 {
			print("matched!", time  )
			return time
		}
		time += previousTime
	}
}



print(busNumbersAndOffsets)
let first = busNumbersAndOffsets.remove(at: 0)
print(first)
var previousBusNumber = first.busNumber
print(busNumbersAndOffsets)
var time = 0 // the time my first bus is leaving

var interval = first.busNumber // the interval to check will be same at first
var busNumber = busNumbersAndOffsets[0].busNumber
var offset = busNumbersAndOffsets[0].timeOffset
print("checking ", busNumbersAndOffsets[0])
while true {
	if (time + offset) % busNumber == 0 {
		print("matched!", time  )
		print( time)
		break
	}
	time += interval
}
time

interval = first.busNumber * busNumber
busNumber = busNumbersAndOffsets[1].busNumber
offset = busNumbersAndOffsets[1].timeOffset

print("checking ", busNumbersAndOffsets[1])
while true {
	if (time + offset) % busNumber == 0 {
		print("matched!", time  )
		print( time)
		break
	}
	time += interval
}

interval *= busNumber
busNumber = busNumbersAndOffsets[2].busNumber
offset = busNumbersAndOffsets[2].timeOffset
print("checking ", busNumbersAndOffsets[2])

while true {
	if (time + offset) % busNumber == 0 {
		print("matched!", time  )
		print( time)
		break
	}
	time += interval
}


//time = matching(previousTime: time, busNumberAndOffset: busNumbersAndOffsets[0])
//interval = time * busNumbersAndOffsets[0].busNumber
//time = matching(previousTime: time, busNumberAndOffset: busNumbersAndOffsets[1])


//interval = time * busNumbersAndOffsets[1].busNumber

//for busNumberAndOffset in busNumbersAndOffsets {
//	previousBusNumber = matching(previousBusNumber: previousBusNumber, busNumberAndOffset: busNumberAndOffset)
//}




//
//var nextdepartureTime = earliestDepartureTime
//var departingBusNumbers: [Int] = []
//var busNumberToTake: Int = -1
//while true {
//	departingBusNumbers = availableBusNumbers.filter {
//		print("nextdepartureTime % $0 == 0) ", nextdepartureTime % $0 )
//		return nextdepartureTime % $0 == 0}
//	if !departingBusNumbers.isEmpty { busNumberToTake = departingBusNumbers.first! ; break }
//	nextdepartureTime += 1
//}









//let solution2 =
//print("Solution part 2: ", solution2 ) //



//
//var time = 2
////var time = previousTimestamp
//while true {
//	let busNumber1 = busNumbersAndOffsets[0].busNumber
//	let offset1 = busNumbersAndOffsets[0].timeOffset
//
//	let busNumber2 = busNumbersAndOffsets[1].busNumber
//	let offset2 = busNumbersAndOffsets[1].timeOffset
//	if (time + offset1) % busNumber1 == offset1 && (time + offset2) % busNumber2 == offset2 {
//		print("matched!", time)
//		//return time
//		break
//	}
//	time += busNumber1
//}//	busNumbersAndOffsets.allSatisfy {
//
//	}
