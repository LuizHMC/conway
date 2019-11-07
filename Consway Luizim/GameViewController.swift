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
    

    
    var stepButton: UIButton!//botão para dar o passo
    var colunasNextGenGrid: [[Bool]] = []//grid auxiliar para setar a nova geração
    
    var arrayCubos = [SCNNode]()//array de cubos scnodes para saber a referencia deles
    
    
    
    var grid = Grid()
    lazy var matriz = Matriz(grid: grid)
    
    override func viewDidLoad() {
        setupCamera()//camera setada
        setupGrid()//grid inicial setada
        createButton()//botao posicionado
        let BoxCreator = UITapGestureRecognizer(target: self, action: #selector(BoxCreator(_:)))
        
        
        sceneView.addGestureRecognizer(BoxCreator) //action de criar box ao clicar na grid
        super.viewDidLoad()
    }
    
    func setupCamera() {
        
        //criando cena
        let cameraReference = SCNNode()
        cameraReference.position = SCNVector3(x: 0, y: 0, z: 0)
        scene.rootNode.addChildNode(cameraReference)
        
        
        //camera
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        scene.rootNode.addChildNode(cameraNode)
        
        //colocar camera
        cameraNode.position = SCNVector3(x: (Float(grid.gridSize/2)), y: 30, z: (Float(grid.gridSize/2)))
        let lookConstraint = SCNLookAtConstraint(target: cameraReference)
        cameraNode.constraints = [lookConstraint]
        
        //luz
        sceneView.autoenablesDefaultLighting = true
        sceneView.allowsCameraControl = true
        sceneView.showsStatistics = true
        sceneView.scene = scene
    }
    
    func setupGrid(){
        let arraySCNodesGrid = grid.setupGrid()
        
        for node in arraySCNodesGrid {
            scene.rootNode.addChildNode(node)
        }
        
    }
    
    
    
    
    
    @objc func BoxCreator(_ gestureRecognize: UIGestureRecognizer) {//Coloca box na grid
        let scnView = self.view as! SCNView
        let p = gestureRecognize.location(in: scnView)
        let hitResults = scnView.hitTest(p, options: [:])
        if hitResults.count > 0 {
            let result = hitResults[0]
            let boxNode = Cubo().CreateCubo(x: result.node.position.x, y: 0.5, z: result.node.position.z)
            grid.colunasGrid[Int(result.node.position.x)][Int(result.node.position.z)] = true
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
        
       
        colunasNextGenGrid = matriz.matrizNova()
        
        //remove os cubos da tela e do array de cubos
        for removeIndex:Int in 0...(arrayCubos.count - 1) {
            arrayCubos[removeIndex].removeFromParentNode()
        }
        arrayCubos.removeAll()
        
        
        //Coloca os cubos na nova cena a partir da nova matriz atualizada
        for xColunaLoop:Int in 0...grid.gridSize{
            for zLinhasLoop:Int in 0...grid.gridSize{
                if colunasNextGenGrid[Int(xColunaLoop)][Int(zLinhasLoop)] == true {
                    let boxNode = Cubo().CreateCubo(x: Float(xColunaLoop), y: 0.5, z: Float(zLinhasLoop))
                    scene.rootNode.addChildNode(boxNode)
                    arrayCubos.append(boxNode)
                }
            }
        }
        //a matriz antiga é finalmente atualizada
        grid.colunasGrid = colunasNextGenGrid
        
    }
    
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
