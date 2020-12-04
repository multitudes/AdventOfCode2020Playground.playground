//: [Previous](@previous)
//: [Next](@next)
import Foundation

var input: [String] = []
do {
	guard let url = Bundle.main.url(forResource: "input", withExtension: "txt") else {
		fatalError("Input not found")
	}
	let inputString = try String(contentsOf: url)
	input = inputString.lines.split { $0 == "" }.compactMap {Array($0)}.map { $0.joined(separator: " ")}

} catch {
	print(error.localizedDescription)
}

struct Passport {
	var fields: [String:String] = [:]
	var requiredFields: Set = ["ecl","pid","eyr","hcl","byr","iyr","hgt"]
	var optionalField: Set = ["cid"]

	var isValid: Bool {
		requiredFields.isSubset(of: Set(fields.keys)) &&
			optionalField.isSubset(of: Set(fields.keys))
	}

	var areValidNorthPoleCredentials: Bool {
		requiredFields.isSubset(of: Set(fields.keys))
	}

	var validatedCredentials: Bool {
		birthYearIsValid && issueYearIsValid && expirationYearIsValid && heightIsValid && hairColorIsValid && eyeColorIsValid && passportIDValid && countryIDValid
	}
	var birthYearIsValid : Bool {
		let birthYear = fields["byr", default: ""]
		return birthYear.count == 4 && (Int(birthYear) ?? 0 >= 1920) && (Int(birthYear) ?? 0 <= 2002)
	}
	var issueYearIsValid: Bool {
		let issueYear = fields["iyr", default: ""]
		return issueYear.count == 4 && (Int(issueYear) ?? 0 >= 2010) && (Int(issueYear) ?? 0 <= 2020)
	}

	var expirationYearIsValid: Bool {
		let expirationYear = fields["eyr", default: ""]
		return expirationYear.count == 4 && (Int(expirationYear) ?? 0 >= 2020) && (Int(expirationYear) ?? 0 <= 2030)
	}


	var heightIsValid: Bool {
		let height = fields["hgt", default: ""]
		if height.hasSuffix("cm") {
			return (Int(height.prefix(3)) ?? 0) >= 150 && (Int(height.prefix(3)) ?? 0) <= 193
		} else if height.hasSuffix("in") {
			return (Int(height.prefix(2)) ?? 0) >= 59 && (Int(height.prefix(2)) ?? 0) <= 76
		}
		return false
	}

	var hairColorIsValid: Bool {
		let hairColor = fields["hcl", default: ""]
		return hairColor.matches(regex: "^#[abcdef0123456789]{6}$") //"^#(?:[abcdef]{6})|#(?:[\\d]{6})$
	}

	var eyeColorIsValid: Bool {
		let eyeColor = fields["ecl", default: ""]
		return Set(arrayLiteral: eyeColor).isSubset(of: Set(["amb", "blu", "brn", "gry", "grn", "hzl", "oth"]))
	}

	var passportIDValid: Bool {
		let passportID = fields["pid", default: ""]
		return passportID.matches(regex: "^[\\d]{9}$")
	}
	var countryIDValid: Bool {
		return true
	}

	init(passportData: String) {
		let fieldsDataArray = passportData.components(separatedBy: .whitespaces)
		fieldsDataArray.forEach { if let field =  $0.getCapturedGroupsFrom(regexPattern: "(\\w+):([#\\w]+)") { fields[field[0]] = field[1] }
		}
	}
}

let solution1 = input.filter {Passport(passportData: $0).areValidNorthPoleCredentials}.count
print("\nThe solution for the first challenge is: ", solution1)
let solution2 = input.filter {Passport(passportData: $0).validatedCredentials }.count
print("\nThe solution for the second challenge is: ", solution2)
