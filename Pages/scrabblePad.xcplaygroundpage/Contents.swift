import Foundation

//guard let url = Bundle.main.url(forResource: "input", withExtension: "txt") else { fatalError() }
////guard let url = Bundle.main.url(forResource: "input", withExtension: "txt") else { fatalError() }
//guard let input: [String] = try? String(contentsOf: url).lines else {fatalError()}


//
//func pad(string : String, toSize: Int) -> String {
//	var padded = string
//	for _ in 0..<(toSize - string.count) {
//		padded = "0" + padded
//	}
//	return padded
//}
//print(input)
//var bitMask = ""
//var mem: [Int:Int] = [:]
//var partOne = false
//for line in input {
//	if line.prefix(7) == "mask = " {
//		bitMask = String(line.dropFirst(7))
//		print("bitMask ", bitMask)
//		continue
//	} else {
//		if let regexGroup = line.getCapturedGroupsFrom(regexPattern: "^mem\\[(\\d+)\\] = (\\d+)$") {
//			let inputMemoryAddress = Int(regexGroup[0])!; let inputValue = Int(regexGroup[1])!
//			// write to dict
//			if partOne {
//				let orBitMask = Int(bitMask.replacingOccurrences(of: "X", with: "0"), radix: 2)!
//				let andBitMask = Int(bitMask.replacingOccurrences(of: "X", with: "1"), radix: 2)!
//				let valueToWrite = (inputValue | orBitMask) & andBitMask
//				mem[inputMemoryAddress] = valueToWrite
//			} else {
//				var mask = bitMask
//				let memoryAddress = inputMemoryAddress
//				let valueToWrite = inputValue
//				var binaryMemoryAddress = pad(string: String(memoryAddress,radix: 2), toSize: 36 )
//				print("binaryMemoryAddress ",binaryMemoryAddress)
//				//...............000000000000000000000000000000
//				//...............0000000000000000000000000000001
//				//...............000000000000000000000000000000101010
//
//				let countX = mask.reduce(0) {$1 == "X" ? $0 + 1 : $0}
//				let permutations = 2 ** countX
//				var inputBitsChunks: [String] = []
//
//				func extractChunk(binaryMemoryAddress: inout String, mask: inout String) {
//					let ix = binaryMemoryAddress.startIndex
//					// if I get an X starting from left
//					if let fx = mask.firstIndex(of: "X") {
//						//if  X is at first position then append ""
//						if fx == ix {
//							mask.removeFirst(); binaryMemoryAddress.removeFirst()
//							inputBitsChunks.append("")
//							return
//						}
//						// got X not at first position
//						let range = binaryMemoryAddress.index(ix, offsetBy: 0)...binaryMemoryAddress.index(fx, offsetBy: -1)
//						let chunk1 = String(binaryMemoryAddress[range])
//						let chunk2 = String(mask[range])
//						let chunkLength = chunk1.count
//						let resultOrOperation: Int = Int(chunk1, radix: 2)! | Int(chunk2, radix: 2)!
//						let binaryMemoryChunk = String(resultOrOperation, radix: 2)
//						let memoryChunk: String = pad(string:binaryMemoryChunk, toSize: chunkLength)
//						inputBitsChunks.append(memoryChunk)
//						mask.removeSubrange(range); binaryMemoryAddress.removeSubrange(range)
//						mask.removeFirst(); binaryMemoryAddress.removeFirst()
//					} else {
//						// no more X append the remainder
//						print("no more X append the remainder")
//						if mask.isEmpty { inputBitsChunks.append("")} else {
//							let chunkLength = mask.count
//							let resultOrOperation: Int = Int(mask, radix: 2)! | Int(binaryMemoryAddress, radix: 2)!
//							let binaryMemoryChunk = String(resultOrOperation, radix: 2)
//							let memoryChunk: String = pad(string:binaryMemoryChunk, toSize: chunkLength)
//							inputBitsChunks.append(memoryChunk)
//							mask = ""
//							binaryMemoryAddress = ""
//						}
//
//					}
//				}
//
//				while !binaryMemoryAddress.isEmpty {
//					extractChunk(binaryMemoryAddress: &binaryMemoryAddress, mask: &mask)
//				}
//
//				inputBitsChunks
//
//				var permutationsArray: [String] = []
//
//				for i in 0..<permutations{
//					let padded: String = pad(string: String(i, radix: 2), toSize: countX)  // 00010110
//					permutationsArray.append(padded)
//				}
//
//				for element in permutationsArray {
//					var memory: [String] = []
//					for i in 0..<countX {
//						memory.append(inputBitsChunks[i])
//						memory.append(element[i])
//					}
//					if inputBitsChunks.count > countX {
//						memory.append(inputBitsChunks[countX])
//					}
//					let memoryAddress = memory.joined()
//					let memoryAddressBinary = Int(memoryAddress,radix: 2)!
//					mem[memoryAddressBinary] = valueToWrite
//				}
//				print(mem)
//
//			}
//		}}
//}
//
//var solution2  = 0
//solution2 = mem.keys.reduce(solution2) { $0 + mem[$1]! }
//print("Solution part 2: ", solution2)
//
//
//0b000000000000000000000000000000100000
//0b000000000000000000000000000000100001
//0b000000000000000000000000000000100010
//0b000000000000000000000000000000100011
//
//0b000000000000000000000000000000010000
//0b000000000000000000000000000000010001
//0b000000000000000000000000000000010010
//0b000000000000000000000000000000010011
//0b000000000000000000000000000000011000
//0b000000000000000000000000000000011001
//0b000000000000000000000000000000011010
//0b000000000000000000000000000000011011
//
//
//import Foundation
//
//// --- Day 18: Conway Cubes ---
//
////guard let url = Bundle.main.url(forResource: "input", withExtension: "txt") else { fatalError()}
//guard let url = Bundle.main.url(forResource: "Day18-example2", withExtension: "txt") else { fatalError()}
//guard let input = try? String(contentsOf: url).replacingOccurrences(of: " ", with: "").lines else {fatalError()}
//
//
//print(input)
//for line in input {
//	print(line)
//
//	var partial = 0
//	var openExpression: [String] = []
//	var brackets = 0
//	var buffer: [String] = []
//	for char in line {
//		if char == "(" {
//			print("parentheses")
//			openExpression.append(String(char))
//			brackets += 1; continue }
//		buffer.append(String(char))
//		if buffer.count == 3 {
//			let str = buffer.compactMap {String($0)}.joined()
//			print("to evaluate ", str)
//			partial = compute(str); buffer = [String(partial)]
//		}
//		print(openExpression)
//		print(buffer)
//	}
//}
//
func compute(_ string: String) -> Int {
	let exp: NSExpression = NSExpression(format: string)
	return exp.expressionValue(with:nil, context: nil) as! Int
}


var expression = ["d", "d", "e"]
let express = expression[1...2]
expression
let str = "(5 * (4 - 2))"
compute(str)



let stringWithMathematicalOperation: String = "5 + 5 * 5" // Example
let exp: NSExpression = NSExpression(format: stringWithMathematicalOperation)
let result: Int = exp.expressionValue(with:nil, context: nil) as! Int


