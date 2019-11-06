//
//  CreateCubo.swift
//  Consway Luizim
//
//  Created by Luiz Henrique Monteiro de Carvalho on 01/11/19.
//  Copyright © 2019 Luiz Henrique Monteiro de Carvalho. All rights reserved.
//

import Foundation
import SceneKit

class Cubo: SCNNode {
    
    func CreateCubo(x: Float, y: Float, z: Float) -> SCNNode {
        let boxGeometry = SCNBox(width: 1, height: 1, length: 1, chamferRadius: 0)
        let boxNode = SCNNode(geometry: boxGeometry)
        boxNode.position = SCNVector3(x: x, y: y, z: z)
        return boxNode
        
    }
}


