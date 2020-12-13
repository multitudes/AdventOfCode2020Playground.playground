import Foundation

//	--- Day 14:  ---

//guard let url = Bundle.main.url(forResource: "day13-example7", withExtension: "txt") else { fatalError() }
guard let url = Bundle.main.url(forResource: "input", withExtension: "txt") else { fatalError() }
guard let input: [String] = try? String(contentsOf: url).lines else {fatalError()}
