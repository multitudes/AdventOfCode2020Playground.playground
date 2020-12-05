//: [Previous](@previous)

import Foundation


//: [Next](@next)


var input: [Int] = []

do {
	guard let fileUrl = Bundle.main.url(forResource: "input", withExtension: "txt") else {
		fatalError("error input not found")
	}
	input = try String(contentsOf: fileUrl).split(separator: "\n").compactMap {Int($0)}.sorted()
	} catch {
	print(error.localizedDescription)
}

var j = input.count - 1
var i = 0
var k = 1
let limit = 2020
var solutionTuple: (Int,Int, Int)
var solution = 0

outerloop: while input[i] + input[j] + input[k] != limit {

	if j <= i { break }
	if input[i] + input[j] < limit {
		let sumFirstTwoExpenses = input[i] + input[j]

		if k == i { k += 1 } else { k = 0 }
		while true {
			//print("i \(i)"," j \(j)"," k \(k) >>>>>>>>>>>>>>>>")

			if k >= input.count - 1 { break }
			if sumFirstTwoExpenses + input[k] == limit {
				solution = input[i] * input[j] * input[k]
				break outerloop
			}
			if sumFirstTwoExpenses + input[k] < limit {
				//print("i \(i)"," j \(j)"," k \(k) >>>>>>>>>>>>>>>>")
				k += 1
				continue
			}
			if sumFirstTwoExpenses + input[k] > limit {
//				print("i \(i)"," j \(j)"," k \(k) >>>>>>>>>>>>>>>>")
//				print("break")
				k = 0
				j -= 1
				i -= 1
				break
			}
		}
		i += 1
		continue
	}
	//print("i \(i)"," j \(j)"," k \(k) >>>>>>>>>>>>>>>>")
	j -= 1
}
//print("\(input[i]) + \(input[j]) + \(input[k]) = ",input[i] + input[j] + input[k] )
solutionTuple = (i, j, k)

solution

//print("\nThe solution for the first challenge is: ", solution1)
print("The solution for the second challenge is: ", solution, "\n")
