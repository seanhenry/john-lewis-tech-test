//
// Created by Sean Henry on 05/01/2017.
// Copyright (c) 2017 Sean Henry. All rights reserved.
//

import Foundation
import XCTest
@testable import JohnLewis

class URLSchemeFixerTests: XCTestCase {

    // MARK: - fixMissingScheme

    func test_fixMissingScheme_shouldAddScheme_whenMissing() {
        let fixed = URLSchemeFixer.fixMissingScheme(in: "//missing-the-scheme")
        XCTAssertEqual(fixed, "https://missing-the-scheme")
    }

    func test_fixMissingScheme_shouldNotAddScheme_whenOneAlreadyExists() {
        let fixed = URLSchemeFixer.fixMissingScheme(in: "https://already-has-scheme")
        XCTAssertEqual(fixed, "https://already-has-scheme")
    }
}

