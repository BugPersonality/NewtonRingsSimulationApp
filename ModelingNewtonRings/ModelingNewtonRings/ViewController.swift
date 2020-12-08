//
//  ViewController.swift
//  ModelingNewtonRings
//
//  Created by Данил Дубов on 08.12.2020.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var RingPainter: UIIntroductionView!
    @IBOutlet weak var length: UITextField!
    
    @IBOutlet weak var radius: UITextField!
    
    @IBAction func drawRings(_ sender: UIButton) {
        let radiusString = radius.text!
        var radiusDouble = Double(radiusString) ?? 1.77
        
        let lengthString = length.text!
        let lengthDouble = Double(lengthString) ?? 630.0
        
        radiusDouble = radiusDouble * 1000000000
        
        print("\(lengthString) \(lengthDouble) \(radiusString) \(radiusDouble)")
        
        guard let sublayers = RingPainter.layer.sublayers else { return }
                for layer in sublayers {
                    layer.removeFromSuperlayer()
                }
        
        RingPainter.lenth = lengthDouble
        RingPainter.radius = radiusDouble
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        RingPainter.clipsToBounds = true
    }
}
