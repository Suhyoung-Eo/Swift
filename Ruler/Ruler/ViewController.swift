//
//  ViewController.swift
//  Ruler
//
//  Created by Suhyoung Eo on 2021/11/03.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    var dotNodes = [SCNNode]()
    
    var textNode = SCNNode()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
        
        sceneView.autoenablesDefaultLighting = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if dotNodes.count >= 2 {
            for dotNode in dotNodes {
                dotNode.removeFromParentNode()
            }
            
            dotNodes = [SCNNode]()
        }
        
        if let touchLocation = touches.first?.location(in: sceneView) {
            
            if let query = sceneView.raycastQuery(from: touchLocation, allowing: .estimatedPlane, alignment: .any) {
                
                let results = sceneView.session.raycast(query)
                
                if let hitResult = results.first {
                    
                    addDot(at: hitResult)
                    
                }
            }
        }
    }
    
    func addDot(at hitResult: ARRaycastResult) {
        
        let  dotGeometry = SCNSphere(radius: 0.005)
        
        let material = SCNMaterial()
        
        material.diffuse.contents = UIColor.systemRed
        
        dotGeometry.materials = [material]
        
        let dotNode = SCNNode(geometry: dotGeometry)
        
        dotNode.position = SCNVector3(
            hitResult.worldTransform.columns.3.x,
            hitResult.worldTransform.columns.3.y,
            hitResult.worldTransform.columns.3.z
        )
        
        sceneView.scene.rootNode.addChildNode(dotNode)
        
        dotNodes.append(dotNode)
        
        if dotNodes.count >= 2 {
            calculate()
        }
    }
    
    func calculate() {
        
        let startPoint = dotNodes[0]
        let endPoint = dotNodes[1]
        
        let tempX = endPoint.position.x - startPoint.position.x
        let tempY = endPoint.position.y - startPoint.position.y
        let tempZ = endPoint.position.z - startPoint.position.z
        
        let distance = sqrt(pow(tempX, 2) + pow(tempY, 2) + pow(tempZ, 2))
        
        let distanceStr = String(format: "%.4f", distance)
        
        let centerX = (startPoint.position.x + endPoint.position.x)/2
        let centerY = (startPoint.position.y + endPoint.position.y)/2
        let centerZ = (startPoint.position.z + endPoint.position.z)/2
        
        let centerPoint = ["x": centerX, "y": centerY, "z": centerZ]
        
        updateText(text: distanceStr, atPosition: centerPoint)
        
    }
    
    func updateText(text: String, atPosition position: [String : Float]) {
        
        textNode.removeFromParentNode()
        
        let textGeometry = SCNText(string: text, extrusionDepth: 1.0)
        
        textGeometry.firstMaterial?.diffuse.contents = UIColor.systemRed
        
        textNode = SCNNode(geometry: textGeometry)
        
        textNode.position = SCNVector3(position["x"]!, position["y"]! + 0.01, position["z"]!)
        
        textNode.scale = SCNVector3(0.005, 0.005, 0.005)
        
        sceneView.scene.rootNode.addChildNode(textNode)
        
    }

}

//extension Float {
//    func rounded(digits: Int) -> Float {
//        let multiplier = pow(10.0, Float(digits))
//        return (self * multiplier).rounded() / multiplier
//    }
//}
