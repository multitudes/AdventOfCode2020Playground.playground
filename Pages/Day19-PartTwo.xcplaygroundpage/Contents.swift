import Foundation

// --- Day 19: Monster Messages ---

guard let url = Bundle.main.url(forResource: "input2", withExtension: "txt") else { fatalError()}
//guard let url = Bundle.main.url(forResource: "Day19-example2updated", withExtension: "txt") else {fatalError()}
//guard let url = Bundle.main.url(forResource: "Day19-example2updated", withExtension: "txt") else {fatalError()}
guard let inputFile = try? String(contentsOf: url).lines else {fatalError()}

let input = inputFile.split {$0 == "" }
let rules = input[0]
let messages = input[1]
var rulesDict: [Int: String] = [:]

for rule in rules {
	if let regex = rule.getCapturedGroupsFrom(regexPattern: "(\\d+):[ \"]{1,2}(\\w)[\"]{1}") {
		let key = Int(regex[0])!
		let expr = " " + regex[1] + " "
		rulesDict[key] = expr
	} else if let regex = rule.getCapturedGroupsFrom(regexPattern: "(\\d+):(.+)") {
		let key = Int(regex[0])!
		var expr = regex[1]
		expr = ("(" + expr + " )")//.replacingOccurrences(of: " ", with: "")
		rulesDict[key] = expr
	}
}
//print(rulesDict.description)

func createRegex(from ruleZero: String) -> String {
	let arrayRules = ruleZero.split(separator: " ").map {String($0)}
	var regexPattern = arrayRules
	for (idx,rule) in arrayRules.enumerated() {
		if rule == "(" || rule == ")" || rule == "a" || rule == "b" || rule == "|" || rule == "){1,}" || rule == "){1,}" || rule == "){2,}"  {continue}
		print("rules",rule)
		if let itemToResolve = rulesDict[Int(String(rule))!] {
			print(itemToResolve)
			regexPattern[idx] = itemToResolve
		}
	}
	return regexPattern.joined(separator: " ")
}

var regexPattern = (rulesDict[42] ?? "")
print(regexPattern)
while !regexPattern.allSatisfy({"ab()| ".contains($0)}) {
regexPattern = createRegex(from: regexPattern)
}
var regexPattern42First = regexPattern  + "{1,}"
var regexPattern42Second = regexPattern  + "{x}"

regexPattern = (rulesDict[31] ?? "")
while !regexPattern.allSatisfy({"ab()| ".contains($0)}) {
regexPattern = createRegex(from: regexPattern)
}
var regexPattern31 = regexPattern  + "{x}"

regexPattern = regexPattern42First + regexPattern42Second + regexPattern31
print(regexPattern)
let regexPatternX = "^" + regexPattern.replacingOccurrences(of:" ", with: "") + "$"
regexPattern = regexPatternX.replacingOccurrences(of:"x", with: "1")
print(regexPattern)

guard let regex = try? NSRegularExpression(pattern: regexPattern) else { fatalError("invalid regex expression \n") }
var count = 0
for message in messages {
	let range = NSRange(location: 0, length: message.utf16.count)
	if regex.firstMatch(in: message, options: [], range: range) != nil {
		count += 1
		continue
	}
	else {
		for i in 2...6 {
			print("alternative regex!! ===== \n\n")
			let regexPattern2 = regexPatternX.replacingOccurrences(of:"x", with: String(i))
			guard let regex = try? NSRegularExpression(pattern: regexPattern2) else { fatalError("invalid regex expression \n") }
			if regex.firstMatch(in: message, options: [], range: range) != nil {
				count += 1
				continue
			}
		}
	}
}
print("Solution part two : ", count)

