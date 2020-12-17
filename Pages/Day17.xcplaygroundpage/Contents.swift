import Foundation

// --- Day 17: Conway Cubes ---

//guard let url = Bundle.main.url(forResource: "input", withExtension: "txt") else { fatalError()}
guard let url = Bundle.main.url(forResource: "Day17-example", withExtension: "txt") else { fatalError()}
guard let input = try? String(contentsOf: url) else {fatalError()}

print(input)
struct Cube {
	let x,y,z: Int
	var state: Bool
}
struct PocketDimension {
	private var cubes : [Cube] = []
	init(input: String) {
		let bootSector = input.lines
		for (yIndex, y) in bootSector.enumerated() {
			print(y)
			for (xIndex,x)  in y.enumerated() {
				let state = x == "#" ? true : false
				cubes.append(Cube(x: xIndex, y: yIndex, z: 0, state: state))
			}
		}
	}
	func runCycle() {

	}

	func getActiveCubes() -> Int {
		return self.cubes.reduce(0) {sum , cube in return cube.state ? sum + 1 : sum  }
	}
}

let boot = PocketDimension(input: input)
//print(boot.cubes.description)
boot.getActiveCubes()
