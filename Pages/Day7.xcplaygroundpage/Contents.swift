//: [Previous](@previous)

import Foundation

//: [Next](@next)

//	--- Day 7: Handy Haversacks ---

guard let url = Bundle.main.url(forResource: "day7-example", withExtension: "txt") else {fatalError()}
guard let input = try? String(contentsOf: url) else {fatalError()}

//print(input)

var rules = input.lines.compactMap {$0.trimmingCharacters(in: .punctuationCharacters)}
//.split(separator: " ").split {$0 == "contain"} }

var rulesDict: [String: [String]] = [:]
rules.forEach {
	if let groups = $0.getCapturedGroupsFrom(regexPattern:"([a-z ]+)bags? contain (.+)") {
		let bagRule = groups[0].trimmingCharacters(in: .whitespaces)
		let contents = groups[1].split(separator: ",").map {String($0).trimmingCharacters(in: .whitespaces)}

		for content in contents {
			print("contentof contents ----------",bagRule,content)
			if let data = content.getCapturedGroupsFrom(regexPattern:"(\\d) (\\w+ \\w+) bags?") {

				let arrayBags = Array(repeating: data[1], count: Int(data[0]) ?? 0)
				//print(arrayBags)
				rulesDict[bagRule, default: []] += arrayBags
				//print(rulesDict.debugDescription)
			}
			if let _ = content.getCapturedGroupsFrom(regexPattern:"(no other) bags") {
				rulesDict[bagRule, default: []] += ["no other"]
				//print(data)
			}

		}
	}
}

//func containsRecursively(bag: String, in dict: [String:[String]]) -> Bool {
//	let bags = dict[bag] ?? ["No color"]
//	if bags.count == 1 {
//		if bags.contains("shiny gold") {
//			print("ok\n")
//			return true
//		}
//	} else { return false }
//
//	//return dict[bag]?.map {  containsRecursively(bag: $0, in: dict) }
//	for bag in bags {
//		containsRecursively(bag: bag, in: dict)
//	}
//	return false
//}

//var a = containsRecursively(bag: "muted yellow", in: rulesDict)
//a = containsRecursively(bag: "bright white", in: rulesDict)
//a = containsRecursively(bag: "dark orange", in: rulesDict)
//a = containsRecursively(bag: "light red", in: rulesDict)
//var a = containsRecursively(bag: "faded blue", in: rulesDict)
print(rulesDict["faded blue"]?.contains("shiny gold")  )
print(rulesDict.keys, "\n")
//var solution: [String] = []
//for key in rulesDict.keys {
//	print("key", key, rulesDict[key]!)
//	if containsRecursively(bag: key, in: rulesDict) == true {
//		solution.append(key)
//	}
//}

//print(solution)
