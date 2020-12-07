//
//  String+Ext.swift
//  
//
//  Created by Laurent B on 02/12/2020.
//

import Foundation


public extension String.StringInterpolation {
	mutating func appendInterpolation(_ number: Double, specifier: String){
		appendLiteral(String(format:"%.3f", number))
	}
}


public extension String {

	var lines: [String] {
		components(separatedBy: .newlines)
	}

	var passportFields: [String] {
		let lines = self.components(separatedBy: .newlines)
		return lines.split { $0 == "" }.compactMap {Array($0)}.map { $0.joined(separator: " ")}
	}

	func getCapturedGroupsFrom(regexPattern: String)-> [String]? {
		let text = self
		let regex = try? NSRegularExpression(pattern: regexPattern)

		let match = regex?.firstMatch(in: text, range: NSRange(text.startIndex..., in: text))

		if let match = match {
			return (0..<match.numberOfRanges).compactMap {
				$0 > 0 ? String(text[Range(match.range(at: $0), in: text)!]) : nil
			}
		}
		return nil
	}

	func getTrimmedCapturedGroupsFrom(regexPattern: String)-> [String]? {
		let text = self
		let regex = try? NSRegularExpression(pattern: regexPattern)

		let match = regex?.firstMatch(in: text, range: NSRange(text.startIndex..., in: text))

		if let match = match {
			return (0..<match.numberOfRanges).compactMap {
				if let range = Range(match.range(at: $0), in: text) {
					return $0 > 0 ? String(text[range]).trimmingCharacters(in: .whitespaces) : nil
				}
				return nil
			}
		}
		return nil
	}
	func matches(regex: String, options: NSRegularExpression.Options = []) -> Bool {
			do {
				let regex = try NSRegularExpression(pattern: regex, options: options)
				let matches = regex.matches(in: self, range: NSRange(location: 0, length: self.utf16.count))
				return matches.count > 0
			} catch {
				return false
			}
		}

	subscript(idx: Int) -> Character {
		Character(extendedGraphemeClusterLiteral: self[index(startIndex, offsetBy: idx)])
	}
	
	subscript(idx: Int) -> String {
		String(self[index(startIndex, offsetBy: idx)])
	}
}
