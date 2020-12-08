//
//  UIIntroductionView.swift
//  ModelingNewtonRings
//
//  Created by Данил Дубов on 08.12.2020.
//

import UIKit

@IBDesignable
class UIIntroductionView: UIView {

    var lenth: Double = 630.0{
        didSet{
            self.setNeedsDisplay()
        }
    }

    var radius: Double = 1.22 * 1000000000{
        didSet{
            self.setNeedsDisplay()
        }
    }
    
    
    // 1px = 0.078mm = 78000nm
    // 1pc = 156000нм
    // 1/4 pc = 39000 nm

    private func getDarkRadius(n: Int) -> CGFloat{
        let currentDarkRadius = CGFloat(sqrt(Double(n) * lenth * radius) / 39000)
        
        return currentDarkRadius
    }
    
    private func getLightRadius(n: Int) -> CGFloat{
        let currentLightRadius = CGFloat(sqrt(((Double(n) * 2) + 1) * radius * lenth / 2) / 39000)
        
        return currentLightRadius
    }
    
    private func drawCircular(in rect: CGRect, radius: CGFloat, width: CGFloat){
        
        let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
        
        let path = UIBezierPath(arcCenter: center, radius: radius,
                                startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: false)

        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.green.cgColor
        shapeLayer.lineWidth = width
        layer.addSublayer(shapeLayer)
    }
    
    override func draw(_ rect: CGRect) {
        let _rect = CGRect(x: 0, y: 0, width: rect.width, height: rect.height)
        
        for i in 1...100 where i % 2 == 1{
            
            let lightRadius = getLightRadius(n: i)
            let darkRaius = getDarkRadius(n: i)
            let widthLight = lightRadius - darkRaius
            
            print(lightRadius)
            print(darkRaius)
            print(widthLight)
            print()
            
            drawCircular(in: _rect, radius: lightRadius, width: widthLight)
        }
    }
}


