//
//  EffortCalculatorTests.swift
//  EffortCalculatorTests
//
//  Created by Nikhil Muskur on 28/09/18.
//  Copyright © 2018 Nikhil Muskur. All rights reserved.
//

import XCTest
@testable import EffortCalculator

class EffortCalculatorTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
		
		XCTAssert(Wage.calculateHours(withWage: 34, forItemPrice: 20) == 1)
		XCTAssert(Wage.calculateHours(withWage: 0, forItemPrice: 20) == 0)
		XCTAssert(Wage.calculateHours(withWage: 25, forItemPrice: 100) == 4)
		XCTAssert(Wage.calculateHours(withWage: 50, forItemPrice: 20) == 1)
		
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
