//
//  ios15testTests.swift
//  ios15testTests
//
//  Created by Alexander v. Below on 01.07.21.
//

import XCTest
@testable import ios15test

class ios15testTests: XCTestCase {

    var sut = ViewController()

    func testFeatureKey() throws {
        let result = sut.featureKey
        XCTAssertEqual(result, .type)
    }

}
