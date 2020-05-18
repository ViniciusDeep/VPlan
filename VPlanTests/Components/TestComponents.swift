//
//  TestComponents.swift
//  VPlanTests
//
//  Created by Vinicius Mangueira on 18/05/20.
//  Copyright © 2020 Vinicius Mangueira. All rights reserved.
//

import XCTest
@testable import VPlan

class TestComponents: XCTestCase {

    func testTrackLayer() {
        let color = CGColor.random()
        
        let trackLayer = TrackLayerView(trackColor: color)
        
        trackLayer.layoutSubviews()
        trackLayer.setupTrackLayer()
        InteractionButton().layoutSubviews()
        
        XCTAssertEqual(trackLayer.trackColor, color)
        XCTAssertEqual(trackLayer.trackLayer.strokeColor, color)
    }
}
