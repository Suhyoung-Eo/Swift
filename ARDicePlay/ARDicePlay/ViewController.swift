//
//  ViewController.swift
//  ARDicePlay
//
//  Created by Suhyoung Eo on 2021/11/01.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    var diceArray = [SCNNode]()
    
    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = false

        sceneView.autoenablesDefaultLighting = true
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        configuration.planeDetection = .horizontal

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    //MARK: - Dice Rendering Method
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let touch = touches.first {
            let touchLocation = touch.location(in: sceneView)
            
            if let query = sceneView.raycastQuery(from: touchLocation, allowing: .estimatedPlane, alignment: .horizontal) {
                
                let results = sceneView.session.raycast(query)
                
                if let hitResult = results.first {
                    
                    addDice(atLocation: hitResult)
                    
                }
            }
        }
    }
    
    func addDice(atLocation location: ARRaycastResult) {
        
        let diceScene = SCNScene(named: "art.scnassets/diceCollada copy.scn")!
        
        if let diceNode = diceScene.rootNode.childNode(withName: "Dice", recursively: true) {
            
            diceNode.position = SCNVector3(
                location.worldTransform.columns.3.x,
                location.worldTransform.columns.3.y + diceNode.boundingSphere.radius,
                location.worldTransform.columns.3.z
            )
            
            diceArray.append(diceNode)
            
            sceneView.scene.rootNode.addChildNode(diceNode)
            
            roll(dice: diceNode)
            
        }
    }
    
    func roll(dice: SCNNode) {
        
        let randomX = Float(arc4random_uniform(4) + 1) * (Float.pi/2)
        //        let randomY = Float(arc4random_uniform(4) + 1) * (Float.pi/6)
        let randomZ = Float(arc4random_uniform(4) + 1) * (Float.pi/2)
        
        dice.runAction(
            SCNAction.rotateBy(
                x: CGFloat(randomX * 5),
                y: 0,
                z: CGFloat(randomZ * 5),
                duration: 0.5)
        )
        
    }
    
    func rollAll() {
        
        if !diceArray.isEmpty {
            for dice in diceArray {
                roll(dice: dice)
            }
        }
        
    }
    
    
    @IBAction func rollAgain(_ sender: UIBarButtonItem) {
        rollAll()
    }
    
    @IBAction func removeAllDice(_ sender: UIBarButtonItem) {
        
        if !diceArray.isEmpty {
            for dice in diceArray {
                dice.removeFromParentNode()
            }
        }
        
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        rollAll()
    }
    
    //MARK: - ARSCNViewDelegateMethod
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        
        guard let planeAnchor = anchor as? ARPlaneAnchor else {return}

        let planeNode = createPlane(with: planeAnchor)

        node.addChildNode(planeNode)
    }
    
    //MARK: - Plane Rendering Methods
    
    func createPlane(with planeAnchor: ARPlaneAnchor) -> SCNNode {
        
        let plane = SCNPlane(width: CGFloat(planeAnchor.extent.x), height: CGFloat(planeAnchor.extent.z))
        
        let planeNode = SCNNode()
        
        planeNode.position = SCNVector3(planeAnchor.center.x, 0, planeAnchor.center.z)
        
        planeNode.transform = SCNMatrix4MakeRotation(-Float.pi/2, 1, 0, 0)
        
        let gridMaterial = SCNMaterial()

        gridMaterial.diffuse.contents = UIImage(named: "art.scnassets/grid.png")

        plane.materials = [gridMaterial]
        
        planeNode.geometry = plane
        
        return planeNode
    }

}




