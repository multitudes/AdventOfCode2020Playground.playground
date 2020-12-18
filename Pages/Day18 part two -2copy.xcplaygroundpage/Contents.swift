import Foundation

// --- Day 18: Conway Cubes ---

//guard let url = Bundle.main.url(forResource: "input", withExtension: "txt") else { fatalError()}
guard let url = Bundle.main.url(forResource: "Day18-example6", withExtension: "txt") else { fatalError()}
guard let input = try? String(contentsOf: url).replacingOccurrences(of: " ", with: "").lines else {fatalError()}
print(input)

//["1+(2*3)+(4*(5+6))"]
var solution = 0
for line in input {
	print(line)
	var expression = Array(line).map {String($0)}
	solution += Int(evaluate(expression))!
}
print("solution = ", solution)

func evaluate(_ expression: [String] ) -> String {
	let start = 0; let end = expression.count
	var idx = start; var buffer: [String] = []
	while idx < end {
		let token = expression[idx]; idx += 1
		if token == "(" {
			print("recursion! --------------" )
			var openParenthesis = 1
			var lastOpenIndex = idx; var firstClosedIndex = end
			for i in idx..<end {
				print(i,expression[i])
				if expression[i] == "(" {
					openParenthesis += 1
				} else if expression[i] == ")" {
					if openParenthesis == 1 { firstClosedIndex = i; break } else {
						openParenthesis -= 1
					}
				} else {continue}
			}
			let subExpression: [String] = Array(expression[lastOpenIndex..<firstClosedIndex])
			print("subExpression-----------------", subExpression)
			buffer.append(evaluate(subExpression))
			idx += subExpression.count + 1
			continue
		}
		buffer.append(token)
		print("token ", token, "-------- buffer ----- ", buffer)
		if buffer.count == 3 {
			print("computing ", buffer.joined())
			let computed = compute(buffer.joined())
			buffer = [computed]
			print("result in buffer ",  buffer )
		}
	}
	let computed = compute(buffer.joined())
	return computed
}

func compute(_ string: String) -> String {
	let exp: NSExpression = NSExpression(format: string)
	return String(exp.expressionValue(with:nil, context: nil) as! Int)
}

let str = "(5 * (4 - 2))"
compute(str)






let stringWithMathematicalOperation: String = "5 + 5 * 5" // Example
let exp: NSExpression = NSExpression(format: stringWithMathematicalOperation)
let result: Int = exp.expressionValue(with:nil, context: nil) as! Int
