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
	if let regex = rule.getCapturedGroupsFrom(regexPattern: "(\\d+): ([\\w ]+)") {
			var key = rule[0]
			
			//rulesDict[key] =
}

