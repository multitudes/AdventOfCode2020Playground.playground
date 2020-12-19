import Foundation

// --- Day 18: Conway Cubes ---

guard let url = Bundle.main.url(forResource: "input", withExtension: "txt") else { fatalError()}
//guard let url = Bundle.main.url(forResource: "Day18-example7---", withExtension: "txt") else { fatalError()}
guard let input = try? String(contentsOf: url).replacingOccurrences(of: " ", with: "").lines else {fatalError()}
print(input)
// not 143056681397659 but 145575710203332
//["1+(2*3)+(4*(5+6))"]

//6 * ((5 * 3 * 2 + 9 * 4) * (8 * 8 + 2 * 3) * 5 * 8) * 2 + (4 + 9 * 5 * 5 + 8) * 4
// 6*   (5*3*11*4)*8*10*3*5*8*(2+(13*5*13))*4
// 38 016 000 * (847) *4
// 38 016 000 * 3388
// ((2+4*9)*(6+9*8+6)+6)+2+4*2
//128 798 208 000
var solution = 0
for line in input {
	print(line)
	let expression = Array(line).map {String($0)}
	solution += Int(evaluate(expression))!
}
print("solution = ", solution)

func evaluate(_ expression: [String] ) -> String {
	let end = expression.count; var idx = 0; var buffer: [String] = []
	while idx < end {
		let token = expression[idx]; idx += 1
		if token == "(" {
			print("recursion! --------------" )
			var openParenthesis = 1
			var firstClosedIndex = end
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
			let subExpression: [String] = Array(expression[idx..<firstClosedIndex])
			print("subExpression-----------------", subExpression)
			buffer.append(evaluate(subExpression))
			idx += subExpression.count + 1
			continue
		}
		if token == "*" {
			print("-----------* ------------------------" )
			buffer.append(token)
			let subExpression: [String] = Array(expression[idx...])
			print("subExpression-----------------", subExpression)
			buffer.append(evaluate(subExpression))
			idx += subExpression.count
			continue
		} else if token == "+" {
			buffer.append(token)
			print("token ", token, "-------- buffer ----- ", buffer)
		} else {
			buffer.append(token)
			print("token ", token, "-------- buffer ----- ", buffer)
		}

		if buffer.count == 3 {
			print("computing \(buffer) ", buffer.joined())
			let computed = compute(buffer.joined())
			buffer = [computed]
			print("result in buffer ",  buffer )
		}
		
	}
	while buffer.count > 3 {
		print("buffer overflow! finishing computing buffer overflow! \(buffer) ", buffer.joined())
		var newBuffer: [String] = []
		newBuffer.append(evaluate(buffer))
		buffer = newBuffer
	}
	print("finishing computing \(buffer) ", buffer.joined())
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
