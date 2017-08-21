//
//  EmotionsViewController.swift
//  CustomDrawing
//
//  Created by Nishant Hooda on 02/07/17.
//  Copyright © 2017 digix. All rights reserved.
//

import UIKit

class EmotionsViewController: UIViewController {

        // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var destinationViewController = segue.destination
        if let navigationController = destinationViewController as? UINavigationController  {
            destinationViewController = navigationController.visibleViewController ?? destinationViewController
        }
        if let faceViewController = destinationViewController as? FaceViewController,
           let identifier = segue.identifier,
           let emotion = emotionalFaces[identifier] {
                faceViewController.expression = emotion
        }
    }
    
    private let emotionalFaces: Dictionary<String,FacialExpression> = [
        "sad" : FacialExpression(eyes: .close, mouth:.frown),
        "happy" : FacialExpression(eyes: .open, mouth: .smile),
        "worried" : FacialExpression(eyes: .open, mouth: .smirk)
    ]

}
