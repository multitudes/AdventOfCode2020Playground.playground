//: [Previous](@previous)

import Foundation

//: [Next](@next)

//	--- Day 6: Custom Customs ---

guard let url = Bundle.main.url(forResource: "input", withExtension: "txt") else {fatalError()}
//guard let url = Bundle.main.url(forResource: "Day6-example", withExtension: "txt") else {fatalError()}
guard let input = try? String(contentsOf: url) else {fatalError()}

let groups = input.split(omittingEmptySubsequences: false, whereSeparator: \.isWhitespace)
// ["abc", "", "a", "b", "c", "", "ab", "ac", "", "a", "a", "a", "a", "", "b"]
let forms = groups.split(whereSeparator: { $0.isEmpty}).map {Array($0).map {Array($0)} }
// [ArraySlice(["abc"]), ArraySlice(["a", "b", "c"]), ArraySlice(["ab", "ac"]) ...
var sets = forms.map {Set($0)}
//[Set([["a", "b", "c"]]), Set([["a"], ["c"], ["b"]]), Set([["a", "c"], ["a", "b"]]), Set([["a"]]), Set([["b"]])]

let solution = sets.map {Set($0.reduce([], +)).count}.reduce(0, +)
solution //6590

let solution2 = sets.reduce(0) { sum, set in
	let intersection = set.reduce(Set(set.first!)) { res,subSet in
		res.intersection(subSet) }
	return sum + intersection.count
}
solution2 //3288





