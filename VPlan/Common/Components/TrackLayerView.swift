//
//  TrackLayerView.swift
//  VPlan
//
//  Created by Vinicius Mangueira on 17/05/20.
//  Copyright © 2020 Vinicius Mangueira. All rights reserved.
//

import UIKit

class TrackLayerView: UIView {
    let trackLayer = CAShapeLayer()
    
    var trackColor = CGColor(srgbRed: 0, green: 0, blue: 0, alpha: 0)
      
    convenience init(trackColor: CGColor) {
        self.init()
        self.trackColor = trackColor
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
         super.layoutSubviews()
         layer.addSublayer(trackLayer)
         setupTrackLayer()
     }
    
    fileprivate func setupTrackLayer() {
        let circularPath = UIBezierPath(arcCenter: CGPoint(x: 0, y: 0), radius: 20, startAngle: 0, endAngle: 3 * CGFloat.pi, clockwise: true)
        trackLayer.speed = 0.5
        trackLayer.strokeStart = 0
        trackLayer.path = circularPath.cgPath
        trackLayer.strokeColor = trackColor
        trackLayer.lineWidth = 10
        trackLayer.fillColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor
    }
}

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}


extension CGColor {
    static func random() -> CGColor {
        return CGColor(srgbRed: .random(), green: .random(), blue: .random(), alpha: 1)
    }
}
