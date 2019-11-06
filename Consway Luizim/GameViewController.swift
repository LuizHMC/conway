//
//  GameViewController.swift
//  Consway Luizim
//
//  Created by Luiz Henrique Monteiro de Carvalho on 31/10/19.
//  Copyright © 2019 Luiz Henrique Monteiro de Carvalho. All rights reserved.
//

/*
Qualquer célula viva com menos de dois vizinhos vivos morre de solidão.
Qualquer célula viva com mais de três vizinhos vivos morre de superpopulação.
Qualquer célula viva com dois ou três vizinhos vivos continua no mesmo estado para
a próxima geração.

Qualquer célula morta com exatamente três vizinhos vivos se torna uma célula viva.
*/

import UIKit
import QuartzCore
import SceneKit

class GameViewController: UIViewController {
    
    let scene = SCNScene()
    lazy var sceneView = self.view as! SCNView
    
    var gridSize:Int = 30//tamanho da grid
    
    var stepButton: UIButton!//botão para dar o passo
    var linhasGrid: [Bool] = []//linhas da grid original
    var colunasGrid: [[Bool]] = []//grid original
    var colunasNextGenGrid: [[Bool]] = []//grid auxiliar para setar a nova geração
    var countVizinhos:Int = 0//contador de vizinhos para a lógica
    var arrayCubos = [SCNNode]()//array de cubos scnodes para saber a referencia deles
    
    override func viewDidLoad() {
        setupCamera()//camera setada
        setupGrid()//grid inicial setada
        createButton()//botao posicionado
        let BoxCreator = UITapGestureRecognizer(target: self, action: #selector(BoxCreator(_:)))
        
        
        sceneView.addGestureRecognizer(BoxCreator) //action de criar box ao clicar na grid
        super.viewDidLoad()
    }
    
    func setupCamera(){
        
        //criando cena
        let cameraReference = SCNNode()
        cameraReference.position = SCNVector3(x: 0, y: 0, z: 0)
        scene.rootNode.addChildNode(cameraReference)
        
        
        //camera
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        scene.rootNode.addChildNode(cameraNode)
        
        //colocar camera
        cameraNode.position = SCNVector3(x: (Float(gridSize/2)), y: 30, z: (Float(gridSize/2)))
        let lookConstraint = SCNLookAtConstraint(target: cameraReference)
        cameraNode.constraints = [lookConstraint]
        
        //luz
        sceneView.autoenablesDefaultLighting = true
        sceneView.allowsCameraControl = true
        sceneView.showsStatistics = true
        sceneView.scene = scene
    }
    
    func setupGrid(){
        let geometry = SCNBox(width: 1 , height: 0,
                              length: 1, chamferRadius: 0)
        geometry.firstMaterial?.diffuse.contents = UIColor.red
        geometry.firstMaterial?.specular.contents = UIColor.white
        geometry.firstMaterial?.emission.contents = UIColor.blue
        
        let boxmatriz = SCNNode(geometry: geometry)
        
        
        for xColuna:Int in 0...gridSize {
            linhasGrid = []
            for yLinha:Int in 0...gridSize {
                linhasGrid.append(false)
                let boxCopy = boxmatriz.copy() as! SCNNode
                boxCopy.position.x = Float(xColuna)
                boxCopy.position.z = Float(yLinha)
                scene.rootNode.addChildNode(boxCopy)
            }
            colunasGrid.append(linhasGrid)
        }
    }
    
    
    
    
    
    @objc func BoxCreator(_ gestureRecognize: UIGestureRecognizer) {//Coloca box na grid
        let scnView = self.view as! SCNView
        let p = gestureRecognize.location(in: scnView)
        let hitResults = scnView.hitTest(p, options: [:])
        if hitResults.count > 0 {
            let result = hitResults[0]
            let boxNode = Cubo().CreateCubo(x: result.node.position.x, y: 0.5, z: result.node.position.z)
            colunasGrid[Int(result.node.position.x)][Int(result.node.position.z)] = true
            scene.rootNode.addChildNode(boxNode)
            arrayCubos.append(boxNode)
        }
    }
    
    
    func createButton(){ //Cria botão na tela.
        let buttonStep = UIButton()
        let viewHeight = self.view.frame.height
        let viewWidth = self.view.frame.width
        buttonStep.frame = CGRect(x: viewWidth - 100, y: viewHeight - 100, width: 50, height: 50)
        buttonStep.backgroundColor = .brown
        buttonStep.addTarget(self, action:#selector(stepButtonAction), for: .touchUpInside)//chama a action do botão
        sceneView.addSubview(buttonStep)
    }
    
    
    @objc func stepButtonAction(_ gestureRecognize: UIGestureRecognizer) {
        
        
        //copiar matriz inicial para a nova antes de verificar os vizinhos e regras
        colunasNextGenGrid = colunasGrid
    
        for xColunas:Int in 0...gridSize {
            
            for zLinhas:Int in 0...gridSize {
                
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
                
                countVizinhos = 0
                
            }
        }
        
        //remove os cubos da tela e do array de cubos
        for removeIndex:Int in 0...(arrayCubos.count - 1) {
            arrayCubos[removeIndex].removeFromParentNode()
        }
        arrayCubos.removeAll()
        
        
        //Coloca os cubos na nova cena a partir da nova matriz atualizada
        for xColunaLoop:Int in 0...gridSize{
            for zLinhasLoop:Int in 0...gridSize{
                if colunasNextGenGrid[Int(xColunaLoop)][Int(zLinhasLoop)] == true {
                    let boxNode = Cubo().CreateCubo(x: Float(xColunaLoop), y: 0.5, z: Float(zLinhasLoop))
                    scene.rootNode.addChildNode(boxNode)
                    arrayCubos.append(boxNode)
                }
            }
        }
        //a matriz antiga é finalmente atualizada
        colunasGrid = colunasNextGenGrid
        
        
        
        

    }
    
    
    
    //remover os child nodes do array de nodes com for
    //zerar o array. Array.removeall
    //criar um for duplo percorrendo a matriz nova se a pos for true cria quadrado add na cena e no vetor
    
    
    
    
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
}
