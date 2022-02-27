//
//  ViewController.swift
//  Planet
//
//  Created by Suhyoung Eo on 2021/11/02.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = false
        
        // Create a new scene
        let sphere = SCNSphere(radius: 0.25)
        
        let material = SCNMaterial()
        
        material.diffuse.contents = UIImage(named: "art.scnassets/jupiter.jpg")
        
        sphere.materials = [material]
        
        let node = SCNNode()
        
        node.position = SCNVector3(0, 0.8, -0.8)
        
        node.geometry = sphere
        
        sceneView.scene.rootNode.addChildNode(node)
        
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


}
