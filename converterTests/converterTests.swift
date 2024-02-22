//
//  converterTests.swift
//  converterTests
//
//  Created by Julio Cesar Guzman Villanueva on 2/20/24.
//

import XCTest
@testable import converter

final class converterTests: XCTestCase {
    func testSpatialVideo() async throws {
        let path = Bundle.init(for: type(of: self)).path(forResource: "input", ofType: "mp4")!
        let inputURL = URL.init(filePath: path)
        let data = try Data(contentsOf: inputURL)
        let url = try await converter.spatialVideo(with: data)
        print(url)
    }
}
