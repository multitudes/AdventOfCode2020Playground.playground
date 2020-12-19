import Foundation

// --- Day 19: Monster Messages ---

//guard let url = Bundle.main.url(forResource: "input", withExtension: "txt") else { fatalError()}
guard let url = Bundle.main.url(forResource: "Day18-example", withExtension: "txt") else { fatalError()}
guard let input = try? String(contentsOf: url).replacingOccurrences(of: " ", with: "").lines else {fatalError()}
print(input)

