//
//  logica.swift
//  Consway Luizim
//
//  Created by Luiz Henrique Monteiro de Carvalho on 06/11/19.
//  Copyright © 2019 Luiz Henrique Monteiro de Carvalho. All rights reserved.
//

import Foundation
import SceneKit

class Matriz {
    
    
    var colunasNextGenGrid: [[Bool]] = []
    
    var grid : Grid
    
    init (grid: Grid){
        self.grid = grid
    }
    
    var countVizinhos:Int = 0
    
    
    
    func matrizNova() -> [[Bool]]  {
        
        //CONTA VIZINHOS-----
        
        var gridSize = grid.gridSize
        var colunasGrid = grid.colunasGrid
        colunasNextGenGrid = colunasGrid
        var countVizinhos = 0
        //countVizinhos:Int
        
            for xColunas:Int in 0...gridSize {
                
                
                
                for zLinhas:Int in 0...gridSize {
                    countVizinhos = 0
                    //canto esquerdo superior
                    if xColunas == 0 && zLinhas == 0 {
                        if colunasGrid[xColunas+1][zLinhas] == true {
                            countVizinhos += 1
                        }
                        if colunasGrid[xColunas+1][zLinhas+1] == true {
                            countVizinhos += 1
                        }
                        if colunasGrid[xColunas][zLinhas+1] == true {
                            countVizinhos += 1
                        }
                    }//ok
                    
                    //canto direito superior
                    if xColunas == gridSize && zLinhas == 0{
                        if colunasGrid[xColunas-1][zLinhas] == true {
                            countVizinhos += 1
                        }
                        if colunasGrid[xColunas-1][zLinhas+1] == true {
                            countVizinhos += 1
                        }
                        if colunasGrid[xColunas][zLinhas+1] == true {
                            countVizinhos += 1
                        }
                    }//ok
                    
                    //canto esquerdo inferior
                    if xColunas == 0 && zLinhas == gridSize{
                        if colunasGrid[xColunas][zLinhas-1] == true {
                            countVizinhos += 1
                        }
                        if colunasGrid[xColunas+1][zLinhas-1] == true {
                            countVizinhos += 1
                        }
                        if colunasGrid[xColunas+1][zLinhas] == true {
                            countVizinhos += 1
                        }
                    }//ok
                    
                    //canto direito inferior
                    if xColunas == gridSize && zLinhas == gridSize{
                        if colunasGrid[xColunas-1][zLinhas] == true {
                            countVizinhos += 1
                        }
                        if colunasGrid[xColunas-1][zLinhas-1] == true {
                            countVizinhos += 1
                        }
                        if colunasGrid[xColunas][zLinhas-1] == true {
                            countVizinhos += 1
                        }
                    }//ok
                    
                    //linha superior
                    if xColunas > 0 && xColunas < gridSize && zLinhas == 0{
                        if colunasGrid[xColunas-1][zLinhas] == true {
                            countVizinhos += 1
                        }
                        if colunasGrid[xColunas-1][zLinhas+1] == true {
                            countVizinhos += 1
                        }
                        if colunasGrid[xColunas][zLinhas+1] == true {
                            countVizinhos += 1
                        }
                        if colunasGrid[xColunas+1][zLinhas+1] == true {
                            countVizinhos += 1
                        }
                        if colunasGrid[xColunas+1][zLinhas] == true {
                            countVizinhos += 1
                        }
                    }//ok
                    
                    //linha esquerda
                    if zLinhas > 0 && zLinhas < gridSize && xColunas == 0{
                        if colunasGrid[xColunas][zLinhas-1] == true {
                            countVizinhos += 1
                        }
                        if colunasGrid[xColunas+1][zLinhas-1] == true {
                            countVizinhos += 1
                        }
                        if colunasGrid[xColunas+1][zLinhas] == true {
                            countVizinhos += 1
                        }
                        if colunasGrid[xColunas+1][zLinhas+1] == true {
                            countVizinhos += 1
                        }
                        if colunasGrid[xColunas][zLinhas+1] == true {
                            countVizinhos += 1
                        }
                    }//ok
                    
                    //linha direita
                    if zLinhas > 0 && zLinhas < gridSize && xColunas == gridSize{
                        if colunasGrid[xColunas][zLinhas-1] == true {
                            countVizinhos += 1
                        }
                        if colunasGrid[xColunas-1][zLinhas-1] == true {
                            countVizinhos += 1
                        }
                        if colunasGrid[xColunas-1][zLinhas] == true {
                            countVizinhos += 1
                        }
                        if colunasGrid[xColunas-1][zLinhas+1] == true {
                            countVizinhos += 1
                        }
                        if colunasGrid[xColunas][zLinhas+1] == true {
                            countVizinhos += 1
                        }
                    }//ok
                    
                    //linha inferior
                    if xColunas > 0 && xColunas < gridSize && zLinhas == gridSize{
                        if colunasGrid[xColunas-1][zLinhas] == true {
                            countVizinhos += 1
                        }
                        if colunasGrid[xColunas-1][zLinhas-1] == true {
                            countVizinhos += 1
                        }
                        if colunasGrid[xColunas][zLinhas-1] == true {
                            countVizinhos += 1
                        }
                        if colunasGrid[xColunas+1][zLinhas-1] == true {
                            countVizinhos += 1
                        }
                        if colunasGrid[xColunas+1][zLinhas] == true {
                            countVizinhos += 1
                        }
                    }//ok
                    
                    //Meio
                    if xColunas > 0 && xColunas < gridSize && zLinhas >= 1 && zLinhas < gridSize{
                        if colunasGrid[xColunas-1][zLinhas-1] == true {
                            countVizinhos += 1
                        }
                        if colunasGrid[xColunas][zLinhas-1] == true {
                            countVizinhos += 1//
                        }
                        if colunasGrid[xColunas+1][zLinhas-1] == true {
                            countVizinhos += 1//
                        }
                        if colunasGrid[xColunas+1][zLinhas] == true {
                            countVizinhos += 1
                        }
                        if colunasGrid[xColunas+1][zLinhas+1] == true {
                            countVizinhos += 1
                        }
                        if colunasGrid[xColunas][zLinhas+1] == true {
                            countVizinhos += 1
                        }
                        if colunasGrid[xColunas-1][zLinhas+1] == true {
                            countVizinhos += 1
                        }
                        if colunasGrid[xColunas-1][zLinhas] == true {
                            countVizinhos += 1
                        }
                    }//ok
                    
                    
                    
                    //Regras
                    //Caso celula esteja viva
                    if colunasGrid[xColunas][zLinhas] == true {
                        if countVizinhos < 2 {
                            colunasNextGenGrid[Int(xColunas)][Int(zLinhas)] = false
                        }
                        if countVizinhos > 3 {
                            colunasNextGenGrid[Int(xColunas)][Int(zLinhas)] = false
                        }
                        if (countVizinhos == 2 || countVizinhos == 3) {
                            colunasNextGenGrid[Int(xColunas)][Int(zLinhas)] = colunasGrid[Int(xColunas)][Int(zLinhas)]
                        }
                    }
                    //Caso celula esteja morta
                    if colunasGrid[xColunas][zLinhas] == false {
                        if countVizinhos == 3 {
                            colunasNextGenGrid[Int(xColunas)][Int(zLinhas)] = true
                        }
                        else{
                            colunasNextGenGrid[Int(xColunas)][Int(zLinhas)] = colunasGrid[Int(xColunas)][Int(zLinhas)]
                        }
                        
                    }
                }
            }
        
        return colunasNextGenGrid
            
            
    }
}
