//
//  FaceIt.swift
//  CustomDrawing
//
//  Created by Nishant Hooda on 27/06/17.
//  Copyright © 2017 digix. All rights reserved.
//

import UIKit

@IBDesignable
class FaceIt: UIView {
    
    @IBInspectable
    var scale: CGFloat = 0.9 { didSet { setNeedsDisplay() } }
    
    @IBInspectable
    var smileCurvature:Double = 0.5 { didSet { setNeedsDisplay() } }
    
    @IBInspectable
    var eyesOpen: Bool = true { didSet { setNeedsDisplay() } }
    
    func changeScale(byReactingTo pinchRecognizer: UIPinchGestureRecognizer)
    {
        switch pinchRecognizer.state {
        case .changed,.ended:
            scale *= pinchRecognizer.scale
            pinchRecognizer.scale = 1
        default:
            break
        }
    }
    
    private var skullRadius:CGFloat
    {
        return min(bounds.width, bounds.height) / 2 * scale
    }
    
    private var skullCentre:CGPoint
    {
        return CGPoint(x: bounds.midX, y: bounds.midY)
    }

    enum Eye    {
        case left
        case right
    }
    
    private func pathForEye(_ eye: Eye) -> UIBezierPath
    {
        func centreOfEye(_ eye: Eye) -> CGPoint
        {
            let eyeOffset = skullRadius / Ratios.skullRadiusToEyeOffset
            var eyeCentre = skullCentre
            eyeCentre.y -= eyeOffset
            eyeCentre.x += ((eye == .left) ? -1 : 1) * eyeOffset
            return eyeCentre
        }
        let eyeRadius = skullRadius / Ratios.skullRadiusToEyeRadius
        let eyeCentre = centreOfEye(eye)
        let path: UIBezierPath
        if eyesOpen
        {
            path = UIBezierPath(arcCenter: eyeCentre, radius: eyeRadius, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true)
        }else {
            path = UIBezierPath()
            path.move(to: CGPoint(x: eyeCentre.x - eyeRadius, y: eyeCentre.y))
            path.addLine(to: CGPoint(x: eyeCentre.x + eyeRadius, y: eyeCentre.y))
        }
        
        path.lineWidth = 2
        return path
    }
    
    private func pathForMouth() -> UIBezierPath
    {
        let mouthWidth = skullRadius / Ratios.skullRadiusToMouthWidth
        let mouthHeight = skullRadius / Ratios.skullRadiusToMouthHeight
        let mouthOffset = skullRadius / Ratios.skullRadiusToMouthOffset
        
        let mouthRect = CGRect(x: skullCentre.x - mouthWidth/2, y: skullCentre.y + mouthOffset, width: mouthWidth, height: mouthHeight)
        
        let start = CGPoint(x: mouthRect.minX, y: mouthRect.midY)
        let end = CGPoint(x: mouthRect.maxX, y: mouthRect.midY)
        
        let smileOffset = CGFloat(max(-1,min(smileCurvature,1))) * mouthRect.height //limit it between -1 and 1
        
        let cp1 = CGPoint(x: start.x + mouthRect.width/3, y: start.y + smileOffset)
        let cp2 = CGPoint(x: end.x - mouthRect.width/3, y: start.y + smileOffset)
        
        let path = UIBezierPath()
        path.move(to: start)
        path.addCurve(to: end, controlPoint1: cp1, controlPoint2: cp2)
        return path
    }
    
    private func pathForSkull() -> UIBezierPath
    {
        let path = UIBezierPath()
        path.addArc(withCenter: skullCentre, radius: skullRadius, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: false)
        path.lineWidth = 3.0
        return path
    }
    
    private struct Ratios   {
        static let skullRadiusToEyeOffset: CGFloat = 3
        static let skullRadiusToEyeRadius: CGFloat = 10
        static let skullRadiusToMouthWidth: CGFloat = 1
        static let skullRadiusToMouthHeight: CGFloat = 3
        static let skullRadiusToMouthOffset: CGFloat = 3
    }

    override func draw(_ rect: CGRect) {
        // Drawing code
        UIColor.red.setStroke()
        UIColor.yellow.setFill()
        pathForSkull().stroke()
        pathForSkull().fill()
        UIColor.black.setStroke()
        UIColor.white.setFill()
        pathForEye(.left).stroke()
        pathForEye(.left).fill()
        pathForEye(.right).stroke()
        pathForEye(.right).fill()
        pathForMouth().stroke()
    }
}
