//: [Previous](@previous)

import Foundation

//: [Next](@next)

//	--- Day 7: Handy Haversacks ---

guard let url = Bundle.main.url(forResource: "input", withExtension: "txt") else {fatalError()}
guard let input = try? String(contentsOf: url) else {fatalError()}
var rules = input.lines.compactMap {$0.trimmingCharacters(in: .punctuationCharacters)}
var rulesDict: [String: [(numberOfBags:Int, bagType: String)]] = [:]
rules.forEach {
	if let groups = $0.getTrimmedCapturedGroupsFrom(regexPattern:"([a-z ]+)bags? contain (.+)") {
		let key = groups[0]
		let contents = groups[1].split(separator: ",").map {String($0)}
		contents.forEach { content in
			if let data = content.getTrimmedCapturedGroupsFrom(regexPattern:"(\\d) (\\w+ \\w+) bags?") {
				let dataTuple: (numberOfBags:Int, bagType: String) = (numberOfBags: Int(data[0]) ?? 0, bagType: data[1])
				rulesDict[key, default: []] += [dataTuple]
			}
		}
	}
}

var cache = [String:Bool]()
func containsRecursively(bag: String, in dict: [String: [(numberOfBags: Int, bagType: String)]]) -> Bool {
	if bag == "shiny gold" {return true}
	if let result = cache[bag] {return result}
	let bags = dict[bag, default: []]
	for bag in bags {
		if containsRecursively(bag: bag.bagType, in: dict) == true {
			return true
		}
		cache[bag.bagType] = false
	}
	return false
}

var solution: [String] = []
rulesDict.keys.forEach { key in
	if key != "shiny gold" {
		if containsRecursively(bag: key, in: rulesDict) == true {
			solution.append(key)
		}
	}
}

print(solution.count) // 161

// another way
let solutionCount = rulesDict.keys.reduce(0) { count, key in
	if key != "shiny gold" && containsRecursively(bag: key, in: rulesDict) == true { return count + 1
	} else { return count }
}

var shinyCache = [String:Int]()

func countBagsInside(for bag: String, in dict: [String: [(numberOfBags: Int, bagType: String)]]) -> Int {
	if let cached = shinyCache[bag] {
		return cached }
	let contentsOfBag = dict[bag, default: []]
	if contentsOfBag.isEmpty { return 0 }
	let total = contentsOfBag.reduce(0) {subTotal, element in
		subTotal + element.numberOfBags + (element.numberOfBags * countBagsInside(for: element.bagType, in: dict))
	}
	shinyCache[bag] = total
	return total
}

let count = countBagsInside(for: "shiny gold", in: rulesDict)
print(count)
//30899

