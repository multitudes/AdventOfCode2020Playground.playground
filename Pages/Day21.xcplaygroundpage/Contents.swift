import Foundation

// --- Day 21: Allergen Assessment ---

//guard let url = Bundle.main.url(forResource: "input", withExtension: "txt") else { fatalError()}
guard let url = Bundle.main.url(forResource: "Day21-example", withExtension: "txt") else {fatalError()}

guard let inputFile = try? String(contentsOf: url).replacingOccurrences(of: "[,)]", with: "", options: .regularExpression).linesNotEmpty else {fatalError()}
var input = inputFile.map { $0.split(separator: " ").map {String($0) }
	.split { $0 == "(contains"}}
	.map { return (ingredients: Set($0[0]),allergens: Set($0[1]) ) }
input.sort {$0.allergens.count < $1.allergens.count}

print(input.description)
var solutionCount = 0
var k = -1
while !input.isEmpty {
	k = k < input.count - 1 ? k + 1 : 0
	let currentElement = input[k]
	if currentElement.allergens.isEmpty {
		solutionCount += currentElement.ingredients.count
		input.remove(at: k)
		continue }
	if currentElement.allergens.count > 1 { continue }
	if currentElement.ingredients.count == 1 && currentElement.allergens.count == 1 {
		print("remove everywhere ")
		removeEverywhere(ingredientFound: currentElement.ingredients.first!, allergen: currentElement.allergens.first!)
		input.remove(at: k)
		continue
	}
	// loop from the next element to end and look for an intersection.
	for i in 0..<input.count where i != k {
		let element = input[i]
		//look for an intersection and if found remove the ingredient and element
		checkForAllergenAndRemove(currentElement, in: element)
	}

}

let solutionPartOne = solutionCount


//input
func checkForAllergenAndRemove(_ currentElement: (ingredients: Set<String>, allergens: Set<String>), in element: (ingredients: Set<String>, allergens: Set<String>)) {
	// check if allergen in sorted list. I know it cannot be empty!
	let currentAllergen = currentElement.allergens.first!
	print("looking for allergen ", currentAllergen)

	if element.allergens.contains(currentAllergen)  {
		print("this contains : \(currentAllergen) ",element)
		let ingredientFound = element.ingredients.intersection(currentElement.ingredients).first!
		print("ingredientFound", ingredientFound)
		removeEverywhere(ingredientFound: ingredientFound, allergen: currentAllergen)
	} else { return }
}

print(input.description)
// not 2021 too low - 2086 too low


print("Solution part one : ", solutionPartOne)


func removeEverywhere(ingredientFound: String, allergen: String) {
	for j in 0..<input.count {
		if input[j].ingredients.contains(ingredientFound)
			&& input[j].allergens.contains(allergen) {
			print("removing input[\(j)]", ingredientFound, allergen)
			input[j].ingredients.remove(ingredientFound)!
			input[j].allergens.remove(allergen)!
			print("removed" )
			//print(element.ingredients)
		} else if input[j].ingredients.contains(ingredientFound) {
			print("removing input[\(j)]", ingredientFound)
			input[j].ingredients.remove(ingredientFound)!
		}
	}
}
