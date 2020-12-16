import Foundation

// --- Day 16: Ticket Translation ---

guard let url = Bundle.main.url(forResource: "input", withExtension: "txt") else { fatalError()}
//guard let url = Bundle.main.url(forResource: "Day16-example1", withExtension: "txt") else { fatalError()}
guard let input = try? String(contentsOf: url).lines else {fatalError()}

//conditions ["class: 1-3 or 5-7", "row: 6-11 or 33-44", "seat: 13-40 or 45-50"]
let conditions = input.split { $0 == "your ticket:"}[0]

// ["7,1,14", "nearby tickets:", "7,3,47", ... ]
let tickets = Array(input.split { $0 == "your ticket:"}[1])

// [7, 1, 14]
let myTicket = tickets[0].split(separator: ",").compactMap { Int($0)}
print(myTicket) // [7, 1, 14]

// [[7, 3, 47], [40, 4, 50], [55, 2, 20], [38, 6, 12]]
let nearbyTickets = tickets.split { $0 == "nearby tickets:"}[1].map {$0.split(separator: ",").compactMap { Int($0)}}

print("conditions", conditions)
print("myTicket", myTicket)
print("Nearby Tickets", nearbyTickets)

// create dictionary
var fields: [String: (Set<Int>, Set<Int>)] = [:]
for condition in conditions {
	print("\n",condition)
	if let field = condition.getCapturedGroupsFrom(regexPattern: "^([\\w]+): (\\d+)-(\\d+) or (\\d+)-(\\d+)$") {
		let fieldName = field[0]; let a = Int(field[1])!; let b = Int(field[2])!; let c = Int(field[3])!; let d = Int(field[4])!;
		let set1 = Set(a...b); let set2 = Set(c...d)
		fields[fieldName] = (set1, set2)
		//print(fieldName, set1, set2)
		//print(fields.description)
	}
}

//
func returnNotValid(in myTicket: [Int]) -> Int {
	var notValid: [Int] = []
	outerloop : for number in myTicket {
		print(number)
		for key in fields.keys {
			print(key)
			let set1 = fields[key]!.0; let set2 = fields[key]!.1
			//print(set1.union(set2).contains(7))
			if set1.union(set2).contains(number) {
				continue outerloop
			}
		}
		notValid.append(number)
	}
	print(notValid)
	return notValid.reduce(0,+)
}

var solution = 0
nearbyTickets.forEach {
	solution += returnNotValid(in: $0)
}
solution
