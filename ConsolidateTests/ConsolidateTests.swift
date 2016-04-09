//
//  ConsolidateTests.swift
//  ConsolidateTests
//
//  Created by Conrad Koh on 18/2/16.
//  Copyright © 2016 ConradKoh. All rights reserved.
//

import XCTest
@testable import Consolidate

class ConsolidateTests: XCTestCase {
    
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
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testURLParserNormalize(){
        var input = "";
        var output_actual = URLParser.Normalize(input);
        var output_expected = "http://";
        XCTAssertEqual(output_expected, output_actual);
        
        input = "http://www.google.com /abc";
        output_actual = URLParser.Normalize(input);
        output_expected = "http://www.google.com";
        XCTAssertEqual(output_expected, output_actual);
        
        input = "google.com /abc";
        output_actual = URLParser.Normalize(input);
        output_expected = "http://google.com";
        XCTAssertEqual(output_expected, output_actual);

    }
    
}
