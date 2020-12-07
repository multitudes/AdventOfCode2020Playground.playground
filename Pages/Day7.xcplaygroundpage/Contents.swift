//: [Previous](@previous)

import Foundation

//: [Next](@next)

//	--- Day 7: Handy Haversacks ---

//guard let url = Bundle.main.url(forResource: "day7-example", withExtension: "txt") else {fatalError()}
guard let url = Bundle.main.url(forResource: "input", withExtension: "txt") else {fatalError()}
guard let input = try? String(contentsOf: url) else {fatalError()}

var rules = input.lines.compactMap {$0.trimmingCharacters(in: .punctuationCharacters)}

var rulesDict: [String: [String]] = [:]
rules.forEach {
	if let groups = $0.getCapturedGroupsFrom(regexPattern:"([a-z ]+)bags? contain (.+)") {
		let bagRule = groups[0].trimmingCharacters(in: .whitespaces)
		let contents = groups[1].split(separator: ",").map {String($0).trimmingCharacters(in: .whitespaces)}
		//print("contents ", contents)
		for content in contents {
			//print("contentof contents ----------",bagRule,content)
			if let data = content.getCapturedGroupsFrom(regexPattern:"(\\d) (\\w+ \\w+) bags?") {

				let arrayBags = [data[1]]
				//print(arrayBags)
				rulesDict[bagRule, default: []] += arrayBags
				//print(rulesDict.debugDescription)
			}
			if let _ = content.getCapturedGroupsFrom(regexPattern:"(no other) bags") {
				rulesDict[bagRule, default: []] = []
				//print(data)
			}

		}
	}
}

var cache = [String:Bool]()
func containsRecursively(bag: String, in dict: [String:[String]]) -> Bool {
	if bag == "shiny gold" {return true}

	if let res = cache[bag] {print("\ncached!! \(bag)\n");return res}
	let bags = dict[bag] ?? []

	for bag in bags {
		//print("recursion =======", bag)
		if containsRecursively(bag: bag, in: dict) == true {
			return true
		}
		cache[bag] = false
	}
	return false
}

//var a = containsRecursively(bag: "muted yellow", in: rulesDict)
//var a = containsRecursively(bag: "faded blue", in: rulesDict)
//print(a)
//print(rulesDict["faded blue"]?.contains("shiny gold")  )
//rulesDict["faded blue"]
//print(rulesDict.keys, "\n")
//rulesDict["bright white"]
//a = containsRecursively(bag: "bright white", in: rulesDict)
//rulesDict["dark orange"]
//a = containsRecursively(bag: "dark orange", in: rulesDict)
//a = containsRecursively(bag: "light red", in: rulesDict)

var solution: [String] = []
//rulesDict["shiny gold"] = nil
for key in rulesDict.keys {
	if key == "shiny gold" { continue }
	//print("key", key, rulesDict[key]!)
	if containsRecursively(bag: key, in: rulesDict) == true {
		solution.append(key)
	}
}
print(solution)
print(solution.count)
