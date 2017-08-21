//
//  FacialExpression.swift
//  CustomDrawing
//
//  Created by Nishant Hooda on 28/06/17.
//  Copyright © 2017 digix. All rights reserved.
//

import Foundation

struct FacialExpression
{
    enum Eyes: Int {
        case open
        case close
    }
    
    enum Mouth: Int {
        case smile
        case frown
        case grin
        case neutral
        case smirk
        
        var sadder: Mouth {
            return Mouth(rawValue: rawValue - 1) ?? .frown
        }
        
        var happier: Mouth {
            return Mouth(rawValue: rawValue + 1) ?? .smile
        }
    }
    
    var sadder: FacialExpression {
        return FacialExpression(eyes: self.eyes, mouth:self.mouth.sadder)
    }
    
    var happier: FacialExpression {
        return FacialExpression(eyes: self.eyes, mouth:self.mouth.happier)
    }
    
    let eyes:Eyes
    let mouth:Mouth
}
