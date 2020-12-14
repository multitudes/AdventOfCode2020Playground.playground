//
//  String+Ext.swift
//  
//
//  Created by Laurent B on 02/12/2020.
//

import Foundation

infix operator **

public func **<I: BinaryInteger>(lhs: I, rhs: I) -> I {
	return I(pow(Double(lhs), Double(rhs)))
}

public func **<I: BinaryInteger, F: BinaryFloatingPoint>(lhs: I, rhs: F) -> F {
	return F(pow(Double(lhs),Double(rhs)))
}

public func **<I: BinaryInteger, F: BinaryFloatingPoint>(lhs: F, rhs: I) -> F {
	return F(pow(Double(lhs),Double(rhs)))
}

public func **<F: BinaryFloatingPoint>(lhs: F, rhs: F) -> F {
	return F(pow(Double(lhs),Double(rhs)))
}
