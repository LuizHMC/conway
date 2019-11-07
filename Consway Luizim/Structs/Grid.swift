//
//  Grid.swift
//  Consway Luizim
//
//  Created by Luiz Henrique Monteiro de Carvalho on 06/11/19.
//  Copyright © 2019 Luiz Henrique Monteiro de Carvalho. All rights reserved.
//

import Foundation
import SceneKit

class Grid {
    
    var gridSize:Int = 30
    var linhasGrid: [Bool] = []
    var colunasGrid: [[Bool]] = []
    
    func setupGrid() -> [SCNNode] {
        var boxesArrayNodes: [SCNNode] = []
        let geometry = SCNBox(width: 1 , height: 0,
                              length: 1, chamferRadius: 0)
        geometry.firstMaterial?.diffuse.contents = UIColor.red
        geometry.firstMaterial?.specular.contents = UIColor.white
        geometry.firstMaterial?.emission.contents = UIColor.blue
        
        
        
        for xColuna:Int in 0...gridSize {
            linhasGrid = []
            for yLinha:Int in 0...gridSize {
                linhasGrid.append(false)
                let boxCopy = SCNNode(geometry: geometry)
                boxCopy.position.x = Float(xColuna)
                boxCopy.position.z = Float(yLinha)
                boxesArrayNodes.append(boxCopy)
                
            }
            colunasGrid.append(linhasGrid)
        }
        return boxesArrayNodes
    }
}
