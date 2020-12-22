import Foundation

// --- Day 21: Allergen Assessment ---

//guard let url = Bundle.main.url(forResource: "input", withExtension: "txt") else { fatalError()}
guard let url = Bundle.main.url(forResource: "Day21-example", withExtension: "txt") else {fatalError()}

guard let inputFile = try? String(contentsOf: url).replacingOccurrences(of: ")", with: "").linesNotEmpty else {fatalError()}
var input = inputFile.map { $0.split(separator: " ").map {String($0)}.split { $0 == "(contains"}}
	.map { return (ingredients: Set($0[0]),allergens: Set($0[1]) ) }
input
print(input.description)






print("Solution part one : ")
