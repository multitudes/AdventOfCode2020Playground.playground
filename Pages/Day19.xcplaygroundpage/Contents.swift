import Foundation

// --- Day 19: Monster Messages ---

guard let url = Bundle.main.url(forResource: "input", withExtension: "txt") else { fatalError()}
//guard let url = Bundle.main.url(forResource: "Day19-example", withExtension: "txt") else {fatalError()}
guard let inputFile = try? String(contentsOf: url).lines else {fatalError()}
let input = inputFile.split {$0 == "" }
let rules = input[0]
let messages = input[1]
print(rules)
print(messages)
var rulesDict: [Int: String] = [:]

for rule in rules {
	if let regex = rule.getCapturedGroupsFrom(regexPattern: "(\\d+):[ \"]{1,2}(\\w)[\"]{1}") {
		print("base")
		let key = Int(regex[0])!
		let expr = " " + regex[1] + " "
		print(key, expr)
		rulesDict[key] = expr
	} else if let regex = rule.getCapturedGroupsFrom(regexPattern: "(\\d+):(.+)") {
		let key = Int(regex[0])!
		var expr = regex[1]
		expr = ("(" + expr + " )")//.replacingOccurrences(of: " ", with: "")
		print(key, expr)
		rulesDict[key] = expr
	}
}
//rulesDict.description
rulesDict[5]
var ruleZero = (rulesDict[0] ?? "")//.replacingOccurrences(of: " ", with: "")
print("\n-----------\n")
//ruleZero = "( a ( 2 3 | 3 2 ) b )"
func createRegex(from ruleZero: String) -> String {
	let arrayRules = ruleZero.split(separator: " ").map {String($0)}
	var regexPattern = arrayRules
	for (idx,rule) in arrayRules.enumerated() {
		if rule == "(" || rule == ")" || rule == "a" || rule == "b" || rule == "|" {continue}
		print("rules",rule)
		if let itemToResolve = rulesDict[Int(String(rule))!] {
			print(itemToResolve)
			regexPattern[idx] = itemToResolve
		}
	}
	print(regexPattern)
	return regexPattern.joined(separator: " ")
}

var regexPattern = ruleZero
while !regexPattern.allSatisfy({"ab()| ".contains($0)}) {

regexPattern = createRegex(from: regexPattern)
//regexPattern = createRegex(from: regexPattern)
//regexPattern = createRegex(from: regexPattern)
}
print(regexPattern)
regexPattern = "^" + regexPattern.replacingOccurrences(of:" ", with: "") + "$"
print("regexPattern", regexPattern)
guard let regex = try? NSRegularExpression(pattern: regexPattern) else { fatalError("invalid regex expression \n") }

var count = 0
for message in messages {
	let range = NSRange(location: 0, length: message.utf16.count)
	if regex.firstMatch(in: message, options: [], range: range) != nil { count += 1}
	//if message.matches(regex: regexPattern){count += 1}
}
count
//
//"ababbb".matches(regex: regexPattern)
//"bababa".matches(regex: regexPattern)
//"abbbab".matches(regex: regexPattern)
//"aaabbb".matches(regex: regexPattern)
//"aaaabbb".matches(regex: regexPattern)
