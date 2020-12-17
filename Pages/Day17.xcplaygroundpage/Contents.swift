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

	//	mutating func twoOrThreeNeighboursActive(cube: Cube) -> Bool {
	//		let currentX:Int = cube.x; let currentY:Int = cube.y; let currentZ:Int = cube.z;
	//		let neighbours: Int = checkForMyActiveNeighbourIn(position: (x: currentX, y: currentY, z: currentZ))
	//		return neighbours == 3 || neighbours == 2
	//	}
	//
	//	mutating func threeNeighboursActive(cube: Cube) -> Bool {
	//		let currentX:Int = cube.x; let currentY:Int = cube.y; let currentZ:Int = cube.z;
	//		let neighbours: Int = checkForMyActiveNeighbourIn(position: (x: currentX, y: currentY, z: currentZ))
	//		return neighbours == 3
	//	}
	//
	//	mutating func runCycle() {
	//
	//		for cube in cubes {
	//			var state : Bool = cube.state
	//			if state {
	//				// state == true , active
	//				//- check if 2-3 active in the vicinity -> remain active
	//				if twoOrThreeNeighboursActive(cube: cube) {
	//					state = true
	//				} else {
	//				// if not then change to inactive
	//					state = false
	//				}
	//				continue
	//			} else {
	//				// state == false , inactive
	//				// - check if 3 active in the vicinity -> change to active
	//				if threeNeighboursActive(cube: cube) {
	//					state = true
	//				} else {
	//				// if not then remain inactive
	//					state = false
	//				}
	//			}
	//			self.nextCycleCubes.append(Cube(x: cube.x, y: cube.y, z: cube.z, state: state))
	//		}
	//		self.cubes = nextCycleCubes
	//	}
	//

	//	mutating func checkForMyActiveNeighbourIn(position: (x: Int, y: Int, z: Int)) -> Int {
	//		var neighbourCount = 0
	//		for x in -1...1 {
	//			for y in -1...1 {
	//				for z in -1...1 {
	//					print("x y z ", x, y, z, "....................")
	//					// this is my current position so skip
	//					if x == 0 && y == 0 && z == 0 { print("continue ");continue }
	//					//create an imaginary cube as neighbour
	//					let cube = Cube(x: (position.x + x), y: (position.y + y), z: (position.z + z))
	//					// if this position is already occupied ( == checks only for position )
	//					if let idx = cubes.firstIndex(of: cube) {
	//						print("same!! ------ index = ", idx)
	//						//if this position's cube is active count it! but not add it
	//						if cubes[idx].state {
	//							neighbourCount += 1
	//							print("active cube!! ------ neighbourCount = ", neighbourCount)
	//						}
	//					}
	//					// if there was nothing at that position then ignore
	//				}
	//			}
	//		}
	//		return neighbourCount
	//	}
	//
	//	func getActiveCubes(in pocket: [Cube]) -> Int {
	//		return pocket.reduce(0) {sum , cube in return cube.state ? sum + 1 : sum  }
	//	}
}

var boot = PocketDimension(input: input)
print(boot.printBootSector())
boot.runCycle()
//boot.getActiveCubes(in: boot.cubes)
//boot.runCycle()
//print(boot.cubes)
//boot.getActiveCubes(in: boot.cubes)


