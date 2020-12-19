import Foundation

// --- Day 19: Monster Messages ---

//guard let url = Bundle.main.url(forResource: "input", withExtension: "txt") else { fatalError()}
guard let url = Bundle.main.url(forResource: "Day18-example", withExtension: "txt") else { fatalError()}
guard let inputFile = try? String(contentsOf: url).lines else {fatalError()}
let input = inputFile.split {$0 == "" }
let rules = input[0]
let messages = input[1]
print(rules)
print(messages)
var rulesDict: [Int: String] = [:]

for rule in rules {
	if let regex = rule.getCapturedGroupsFrom(regexPattern: "(\\d+): ([\\d ]+)$") {
		var key = Int(regex[0])!
		var expr = regex[1]
		rulesDict[key] = expr
	}
	if let regex = rule.getCapturedGroupsFrom(regexPattern: "(\\d+): ([\\d ]+)$") {
		var key = Int(regex[0])!
		var expr = regex[1]
		rulesDict[key] = expr
	}
}
rulesDict.description
