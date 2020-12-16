import Foundation

// --- Day 16: Ticket Translation ---

guard let url = Bundle.main.url(forResource: "input", withExtension: "txt") else { fatalError()}
//guard let url = Bundle.main.url(forResource: "Day16-example2", withExtension: "txt") else { fatalError()}
guard let input = try? String(contentsOf: url).lines else {fatalError()}

//conditions ["class: 1-3 or 5-7", "row: 6-11 or 33-44", "seat: 13-40 or 45-50"]
let conditions = input.split { $0 == "your ticket:"}[0]

// ["7,1,14", "nearby tickets:", "7,3,47", ... ]
let tickets = Array(input.split { $0 == "your ticket:"}[1])

// [7, 1, 14]
let myTicket = tickets[0].split(separator: ",").compactMap { Int($0)}
print("myTicket",myTicket) // [7, 1, 14]

// [[7, 3, 47], [40, 4, 50], [55, 2, 20], [38, 6, 12]]
let nearbyTickets = tickets.split { $0 == "nearby tickets:"}[1].map {$0.split(separator: ",").compactMap { Int($0)}}

//print("conditions", conditions)
//print("myTicket", myTicket)
//print("Nearby Tickets", nearbyTickets)

// create dictionary
var fields: [String: (Set<Int>, Set<Int>)] = [:]
for condition in conditions {
	//print("\n",condition)
	if let field = condition.getCapturedGroupsFrom(regexPattern: "^([\\w ]+): (\\d+)-(\\d+) or (\\d+)-(\\d+)$") {
		let fieldName = field[0]; let a = Int(field[1])!; let b = Int(field[2])!; let c = Int(field[3])!; let d = Int(field[4])!;
		let set1 = Set(a...b); let set2 = Set(c...d)
		fields[fieldName] = (set1, set2)
		//print("fieldName \n", set1,"\n", set2)
		//print(fields.description)
	}
}
func checkFieldKeyContains(value fieldValue: Int, key: String) -> Bool {
	let set1 = fields[key]!.0; let set2 = fields[key]!.1
	if set1.union(set2).contains(fieldValue) {
		return true
	}
	return false
}
//
func returnNotValid(in ticket: [Int]) -> Int {
	var notValid: [Int] = []
	outerloop : for fieldValue in ticket {
		//print(fieldValue)
		for key in fields.keys {
			//print(key)
			if checkFieldKeyContains(value: fieldValue, key: key) {
				continue outerloop
			}
		}
		notValid.append(fieldValue)
	}
	//print(notValid)
	return notValid.reduce(0,+)
}

var validTickets: [[Int]] = []
var solution = 0

var allFieldsValue: [[Int]] = []

nearbyTickets.forEach {
	let notValid = returnNotValid(in: $0)
	if notValid != 0 {
		solution += notValid
	} else {
		validTickets.append($0)
	}
}
solution



// --- part two --- got the valid tickets now

func checkFieldKeyContains(set: Set<Int>, key: String) -> Bool {
	let set1 = fields[key]!.0; let set2 = fields[key]!.1
	if (set1.union(set2)).isSuperset(of: set) {
		return true
	}
	return false
}


print(fields.keys)
var fieldsInSequence: [Int: Set<Int>] = [:]
var arrayOfMatchingArray: [[String]] = []
var dictOfMatchingFieldsAndIndices: [String: Set<Int>] = [:]
for sequence in 0..<fields.keys.count {
	print("sequence ", sequence)
	for ticket in validTickets {
		var field = fieldsInSequence[sequence, default: []]
		field.insert(ticket[sequence])
		fieldsInSequence[sequence] = field
	}
	print("sequence filled", fieldsInSequence[sequence]!)
	// what is this sequence matching?
	var matchingSet: Set<Int> = []
	for key in fields.keys {
		if checkFieldKeyContains(set: fieldsInSequence[sequence]! , key: key) {
			matchingSet = dictOfMatchingFieldsAndIndices[key, default: []]
			matchingSet.insert(sequence)
			dictOfMatchingFieldsAndIndices[key] = matchingSet
		}
	}
	print("dictOfMatchingFieldsAndIndices",dictOfMatchingFieldsAndIndices)
}

dictOfMatchingFieldsAndIndices["class"]?.count
var sortedByValuetuples = dictOfMatchingFieldsAndIndices.sorted { $0.1.count < $1.1.count}

print(sortedByValuetuples)//[(key: "seat", value: Set([2])), (key: "class", value: Set([1, 2])), (key: "row", value: Set([0, 1, 2]))]

print("sortedByValuetuples.count", sortedByValuetuples.count)


for idx in 0..<sortedByValuetuples.count {
	print("idx ================= ", idx)

	if sortedByValuetuples[idx].value.count == 1 {
		let value = sortedByValuetuples[idx].value.first!
		print("value ", value)
		for kdx in (idx+1)..<sortedByValuetuples.count {
			if sortedByValuetuples[kdx].value.contains(value) {
				print("contains \(value)")
				let valueSet: Set<Int> = [value]
				//print("valueSet ", valueSet)
				sortedByValuetuples[kdx].value.subtract(valueSet)
				print(sortedByValuetuples[kdx].value)
			}
		}
	}
}
print(sortedByValuetuples.description)


// i have a bug where class returns and index of [] and I do not why
// all other indexes are matched and could get the solution as below!

101*211*103*107*179*61
// solution 2564529489989



//var sortedAgain = sortedByValuetuples.map { ($0.value.first!, $0.key) }

//print(sortedAgain.sorted {$0.0 < $1.0})

//had to finish with pen and paper because of a small bug
/*
"arrival location", value: Set([         11])), (key:
"seat", value: Set([                     14])), (key:
"route", value: Set([                    10,])), (key:
"arrival station", value: Set([           2])), (key:
"type", value: Set([                     17])), (key:
"duration", value: Set([                  8])), (key:
"zone", value: Set([                     12])), (key:

"departure platform", value: Set([        1])), (key:
"departure location", value: Set([       18])), (key:
"departure time", value: Set([            5])), (key:
"departure station", value: Set([         3])), (key:
"departure track", value: Set([])), (key:  has to be 7!
"departure date", value: Set([            0])), (key:

"wagon", value: Set([                    15])), (key:
"arrival platform", value: Set([         16
"train", value: Set([                     6])), (key:
"row", value: Set([                       4,
"arrival track", value: Set([            13
"price", value: Set([                    19

Class!! 9
*/
