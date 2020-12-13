import Foundation


//	--- Day 13: Shuttle Search ---

//guard let url = Bundle.main.url(forResource: "day13-example", withExtension: "txt") else { fatalError() }
guard let url = Bundle.main.url(forResource: "input", withExtension: "txt") else { fatalError() }
guard let input: [String] = try? String(contentsOf: url).lines else {fatalError()}
print(input)

var earliestDepartureTime: Int = Int(input[0])!
let availableBusNumbers: [Int] = input[1].split(separator: ",").compactMap {Int($0)}

var nextdepartureTime = earliestDepartureTime
var departingBusNumbers: [Int] = []
var busNumberToTake: Int = -1
while true {
	departingBusNumbers = availableBusNumbers.filter {
		print("nextdepartureTime % $0 == 0) ", nextdepartureTime % $0 )
		return nextdepartureTime % $0 == 0}
	if !departingBusNumbers.isEmpty { busNumberToTake = departingBusNumbers.first! ; break }
	nextdepartureTime += 1
}
let solution1 = (nextdepartureTime-earliestDepartureTime) * busNumberToTake
print("Solution part 1: ", solution1 ) //222



