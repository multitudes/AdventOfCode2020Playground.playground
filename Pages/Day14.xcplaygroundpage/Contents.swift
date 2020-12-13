import Foundation

//	--- Day 13: Shuttle Search ---

guard let url = Bundle.main.url(forResource: "day13-example2", withExtension: "txt") else { fatalError() }
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

func matching(previousTimestamp: Int, busNumberAndOffset: (busNumber: Int, timeOffset: Int)) -> Int {
	var time = previousTimestamp
	let busNumber1 = previousTimestamp
	let offset1 = 0

	let busNumber2 = busNumberAndOffset.busNumber
	let offset2 = busNumberAndOffset.timeOffset
	while true {

		if (time + offset1) % busNumber1 == offset1 && (time + offset2) % busNumber2 == offset2 {
			print("matched!", time)
			return time
		}
		time += previousTimestamp
	}
}
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

let first = busNumbersAndOffsets.remove(at: 0)
var previousTimestamp = first.busNumber
for busNumberAndOffset in busNumbersAndOffsets {
	previousTimestamp = matching(previousTimestamp: previousTimestamp, busNumberAndOffset: busNumberAndOffset)
}




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



