import Foundation

// --- Day 17: Conway Cubes ---

//guard let url = Bundle.main.url(forResource: "input", withExtension: "txt") else { fatalError()}
guard let url = Bundle.main.url(forResource: "Day17-example", withExtension: "txt") else { fatalError()}
guard let input = try? String(contentsOf: url) else {fatalError()}

struct Cube: Equatable, Hashable {
	let x,y,z: Int
	static func ==(lhs: Cube, rhs: Cube) -> Bool {
		return lhs.x == rhs.x && lhs.y == rhs.y && lhs.z == rhs.z
	}

}

struct PocketDimension {
	var actives : Set<Cube> = []
	var inactives: Set<Cube> = []
	var nextActives : Set<Cube> = []
	var nextInactives: Set<Cube> = []
	static var cycles = 0
	init(input: String) {
		let bootSector = input.lines
		for (yIndex, y) in bootSector.enumerated() {
			print(y)
			for (xIndex,x)  in y.enumerated() {
				if x == "#" { actives.insert(Cube(x: xIndex, y: yIndex, z: 0))} else {
					inactives.insert(Cube(x: xIndex, y: yIndex, z: 0)); continue}
			}
		}
	}

	func printBootSector() {
		for z in -Self.cycles...Self.cycles {
			print("\nLayer \(z)")
			for y in -10...10 {
				for x in -10...10 {
					let cube = Cube(x: x, y: y, z: z)
					if actives.contains(cube) {print("#", terminator: "")} else {print(".",terminator: "")}
				}
				print("\n", terminator: "")
			}
		}
	}

	mutating func runCycle() {
		for cube in actives {
			var count = 0
			for z in -1...1 {
				for y in -1...1 {
					for x in -1...1 {
						//print("x y z ", x, y, z, "....................")
						// this is my current position so skip
						if x == 0 && y == 0 && z == 0 { continue }
						//create an imaginary cube as neighbour
						let cube = Cube(x: (cube.x + x), y: (cube.y + y), z: (cube.z + z))
						// if this position is not already active append inactive
						if actives.contains(cube) {
							count += 1
						} else {
							inactives.insert(cube)
						}
					}
				}
			}
			if 2...3 ~= count { nextActives.insert(cube) } else {
				nextInactives.insert(cube)
			}
		}

		for cube in inactives {
			var count = 0
			for z in -1...1 {
				for y in -1...1 {
					for x in -1...1 {
						//print("x y z ", x, y, z, "....................")
						// this is my current position so skip
						if x == 0 && y == 0 && z == 0 { continue }
						//create an imaginary cube as neighbour
						let cube = Cube(x: (cube.x + x), y: (cube.y + y), z: (cube.z + z))
						// if this position is not already active append inactive
						if actives.contains(cube) {
							count += 1
						} else {
							nextInactives.insert(cube)
						}
					}
				}
			}
			if count == 3 {nextActives.insert(cube)} else {nextInactives.insert(cube)}
		}
		actives = nextActives
		nextActives = []
		inactives = nextInactives
		nextInactives = []
		Self.cycles += 1
		printBootSector()
	}

}

var boot = PocketDimension(input: input)
print(boot.printBootSector())
boot.runCycle()
boot.runCycle()
boot.runCycle()
boot.runCycle()
boot.runCycle()
boot.runCycle()
boot.actives.count
//boot.getActiveCubes(in: boot.cubes)
//boot.runCycle()
//print(boot.cubes)
//boot.getActiveCubes(in: boot.cubes)


