import Foundation

// --- Day 18: Conway Cubes ---

//guard let url = Bundle.main.url(forResource: "input", withExtension: "txt") else { fatalError()}
guard let url = Bundle.main.url(forResource: "Day17-example", withExtension: "txt") else { fatalError()}
guard let input = try? String(contentsOf: url) else {fatalError()}
