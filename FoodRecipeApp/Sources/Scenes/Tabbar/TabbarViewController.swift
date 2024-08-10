//
//  TabbarViewController.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 9/8/2567 BE.
//  Copyright © 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit

class TabbarViewController: UITabBar {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    private var shapeLayer: CALayer?
    
    override func draw(_ rect: CGRect) {
        addShape()
        unselectedItemTintColor = .gray
        tintColor = ._3_DA_0_A_7
    }
    
    override open func sizeThatFits(_ size: CGSize) -> CGSize {
        super.sizeThatFits(size)
        
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height = 100
        
        return sizeThatFits
    }
    
    private func addShape() {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = createPath()
        shapeLayer.strokeColor = UIColor.clear.cgColor
        shapeLayer.fillColor = UIColor.white.cgColor
        shapeLayer.lineWidth = 1.0
        
        // Add shadow
        shapeLayer.shadowColor = UIColor.black.cgColor
        shapeLayer.shadowOffset = CGSize(width: 0, height: 1)
        shapeLayer.shadowOpacity = 0.1
        shapeLayer.shadowRadius = 8
        
        if let oldShapeLayer = self.shapeLayer {
            self.layer.replaceSublayer(oldShapeLayer, with: shapeLayer)
        } else {
            self.layer.insertSublayer(shapeLayer, at: 0)
        }
        
        self.shapeLayer = shapeLayer
    }
    
    func createPath() -> CGPath {
        let height: CGFloat = 21
        let path = UIBezierPath()
        let centerWidth = frame.width / 2
        
        path.move(to: CGPoint(x: 0, y: 0)) // start top left
        path.addLine(to: CGPoint(x: (centerWidth - height * 2), y: 0))
        
        path.addQuadCurve(
            to: CGPoint(x: (centerWidth + height * 2), y: 0),
            controlPoint: CGPoint(x: centerWidth, y: 67)
        ) // center curve
        
        path.addLine(to: CGPoint(x: frame.width, y: 0)) // complete to top right
        path.addLine(to: CGPoint(x: frame.width, y: frame.height)) // bottom right
        path.addLine(to: CGPoint(x: 0, y: frame.height)) // bottom left
        
        path.close()
        
        return path.cgPath
    }
}
