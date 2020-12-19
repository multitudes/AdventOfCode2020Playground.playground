import Foundation

// --- Day 18: Conway Cubes ---

guard let url = Bundle.main.url(forResource: "input", withExtension: "txt") else { fatalError()}
//guard let url = Bundle.main.url(forResource: "Day18-example", withExtension: "txt") else { fatalError()}
guard let input = try? String(contentsOf: url).replacingOccurrences(of: " ", with: "").lines else {fatalError()}
print(input)

var solution = 0
for line in input {
	print(line)
	var expression = Array(line).map {String($0)}
	solution += Int(evaluate(&expression))!
}
print("solution = ", solution)

func evaluate(_ expression: inout [String]) -> String {
	print(expression)
	var buffer: [String] = []
	while !expression.isEmpty {
		var token = expression.removeFirst()
		print("token ", token, "-------- buffer ----- ", buffer)
		if token == "(" {
			print("recursion!", "evaluate ", expression )
			buffer.append(evaluate(&expression))
			continue
		}
		if buffer.count == 3 {
			print("computing ", buffer.joined())
			let computed = compute(buffer.joined())
			buffer = [computed]
			print("result in buffer ",  buffer, expression )
		}
		if token == ")"  {
			// back from recursion
			print("back from recursion ! with  ",   buffer.first!  )
			return buffer.first!
		}
		if token != ")" || token != "(" {
			buffer.append(token)}

	}
	print(buffer)
	if buffer.count == 3 {
		print("computing ", buffer.joined())
		let computed = compute(buffer.joined())
		buffer = [computed]
		print("result in buffer ",  buffer, expression )
	}
	return buffer[0]
}

func compute(_ string: String) -> String {
	let exp: NSExpression = NSExpression(format: string)
	return String(exp.expressionValue(with:nil, context: nil) as! Int)
}
