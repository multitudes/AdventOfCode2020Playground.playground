//: [Previous](@previous)

import Foundation


var inputBitsChunks: [String] = []
var mask =                "10100111"
var binaryMemoryAddress = "01010110"
if mask.isEmpty { inputBitsChunks.append("")} else {
	let chunkLength = mask.count
	let resultOrOperation: Int = Int(mask, radix: 2)! | Int(binaryMemoryAddress, radix: 2)!
	let binaryMemoryChunk = String(resultOrOperation, radix: 2)
	let memoryChunk: String = pad(string:binaryMemoryChunk, toSize: chunkLength)
	inputBitsChunks.append(memoryChunk)
	mask = ""
	binaryMemoryAddress = ""
}



func pad(string : String, toSize: Int) -> String {
	var padded = string
	for _ in 0..<(toSize - string.count) {
		padded = "0" + padded
	}
	return padded
}
