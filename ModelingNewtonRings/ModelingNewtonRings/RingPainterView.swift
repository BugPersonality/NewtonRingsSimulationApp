import UIKit
// 1px = 0.078mm = 78000nm
// 1pc = 156000нм
// 1/4 pc = 39000 nm
// 26pc = 1mm

@IBDesignable
class RingPainterView: UIView {
    var lenth: Double = 630.0{
        didSet{
            self.setNeedsDisplay()
        }
    }

    var radius: Double = 1.45 * 1000000000{
        didSet{
            self.setNeedsDisplay()
        }
    }
    
    private func getDarkRadius(n: Int) -> CGFloat{
        let currentDarkRadius = CGFloat(sqrt(Double(n) * lenth * radius) / 39000 )
        
        return currentDarkRadius
    }
    
    private func getLightRadius(n: Int) -> CGFloat{
        let currentLightRadius = CGFloat(sqrt(((Double(n) * 2) + 1) * radius * lenth / 2) / 39000)
        
        return currentLightRadius
    }
    
    func getIntensity(delta: Double) -> Double{
        return 2 + (2 * cos(2 * Double(CGFloat.pi) * delta / lenth))
    }
    
    func calculateDelta(r: Double, n: Int) -> Double{
        return ((r * r / radius) * (Double(n) + lenth / 2))
    }
    
    func getColor(intensity: Double) -> CGColor{
        if lenth > 390 && lenth < 440{ //violet
            let customColor = UIColor(hue: 0.75, saturation: CGFloat(intensity), brightness: 0.5, alpha: 1)
            return customColor.cgColor
        }
        else if lenth >= 440 && lenth < 480{ //blue
            let customColor = UIColor(hue: 0.583, saturation: CGFloat(intensity), brightness: 0.5, alpha: 1)
            return customColor.cgColor
        }
        else if lenth >= 480 && lenth < 510{ // light blue
            let customColor = UIColor(hue: 0.5, saturation: CGFloat(intensity), brightness: 0.5, alpha: 1)
            return customColor.cgColor
        }
        else if lenth >= 510 && lenth < 550{ //green
            let customColor = UIColor(hue: 0.250, saturation: CGFloat(intensity), brightness: 0.5, alpha: 1)
            return customColor.cgColor
        }
        else if lenth >= 550 && lenth < 585{ //yellow
            let customColor = UIColor(hue: 0.167, saturation: CGFloat(intensity), brightness: 0.5, alpha: 1)
            return customColor.cgColor
        }
        else if lenth >= 585 && lenth < 620{ //orange
            let customColor = UIColor(hue: 0.083, saturation: CGFloat(intensity), brightness: 0.5, alpha: 1)
            return customColor.cgColor
        }
        else if lenth >= 620 && lenth <= 770{ //red
            let customColor = UIColor(hue: 1, saturation: CGFloat(intensity), brightness: 0.5, alpha: 1)
            return customColor.cgColor
        }
        else if lenth > 770 { // invisible
            let customColor = UIColor.lightGray
            return customColor.cgColor
        }
        else{ //faintly visible violet
            let customColor = UIColor(hue: 0.75, saturation: 0.3, brightness: 0.7, alpha: 1)
            return customColor.cgColor
        }
    }
    
    private func drawCircular(in rect: CGRect, radius: CGFloat, width: CGFloat, intensity: Double){
        
        let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
        
        let path = UIBezierPath(arcCenter: center, radius: radius,
                                startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: false)

        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = getColor(intensity: intensity)
        shapeLayer.lineWidth = width
        layer.addSublayer(shapeLayer)
    }
    
    private func drawAxis(in rect: CGRect){
        let framePath = UIBezierPath(rect: rect)
        framePath.lineWidth = 2.0
        UIColor.black.setStroke()
        framePath.stroke()
      
        let axisPath = UIBezierPath()
        axisPath.move(to: CGPoint(x: rect.origin.x + rect.width / 2, y: rect.origin.y + rect.height / 2))
        axisPath.addLine(to: CGPoint(x: rect.origin.x + rect.width, y: rect.origin.y + rect.height / 2))
        axisPath.lineWidth = 1.0
        UIColor.black.setStroke()
        axisPath.stroke()
        axisPath.move(to: CGPoint(x: rect.origin.x + rect.width / 2, y: rect.origin.y + rect.height / 2))
        axisPath.addLine(to: CGPoint(x: rect.origin.x + rect.width / 2, y: rect.origin.y + rect.height))
        axisPath.stroke()
        
        var currentX = rect.width / 2
        var currentY = rect.height / 2
        let radius = CGFloat(2)
        
        while currentX <= rect.width{
            let center = CGPoint(x: currentX, y: currentY)
            let path = UIBezierPath(arcCenter: center, radius: radius,
                                    startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: false)

            let shapeLayer = CAShapeLayer()
            shapeLayer.path = path.cgPath
            shapeLayer.fillColor = UIColor.black.cgColor
            shapeLayer.strokeColor = UIColor.black.cgColor
            shapeLayer.lineWidth = radius
            layer.addSublayer(shapeLayer)
            
            currentX += CGFloat(26)
        }
        
        currentX = rect.width / 2
        
        while currentY <= rect.height{
            let center = CGPoint(x: currentX, y: currentY)
            let path = UIBezierPath(arcCenter: center, radius: radius,
                                    startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: false)

            let shapeLayer = CAShapeLayer()
            shapeLayer.path = path.cgPath
            shapeLayer.fillColor = UIColor.black.cgColor
            shapeLayer.strokeColor = UIColor.black.cgColor
            shapeLayer.lineWidth = radius
            layer.addSublayer(shapeLayer)
            
            currentY += CGFloat(26)
        }

    }
    
    override func draw(_ rect: CGRect) {
        let _rect = CGRect(x: 0, y: 0, width: rect.width, height: rect.height)
        
        for i in 1...1000 where i % 2 == 1{
            
            let lightRadius = getLightRadius(n: i)
            let darkRaius = getDarkRadius(n: i)
            
            let widthLight = lightRadius - darkRaius
            
            let delta = calculateDelta(r: Double(lightRadius), n: i)
            let intensity = getIntensity(delta: Double(delta)) / 4
            
            drawCircular(in: _rect, radius: lightRadius, width: widthLight, intensity: intensity)
        }
        
        drawAxis(in: _rect)
    }
}


