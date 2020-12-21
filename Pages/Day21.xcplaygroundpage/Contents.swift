import Foundation

// --- Day 21: Allergen Assessment ---

//guard let url = Bundle.main.url(forResource: "input", withExtension: "txt") else { fatalError()}
guard let url = Bundle.main.url(forResource: "Day20-example", withExtension: "txt") else {fatalError()}

guard let inputFile = try? String(contentsOf: url).lines else {fatalError()}
var input = inputFile.split {$0 == "" }.map {Array($0) }
input.count
print(input)




print("Solution part one : ")
