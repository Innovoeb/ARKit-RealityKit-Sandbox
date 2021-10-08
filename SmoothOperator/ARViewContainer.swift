//
//  ARViewContainer.swift
//  SmoothOperator
//
//  Created by Beovonni on 10/3/21.
//

import SwiftUI
import RealityKit
import ARKit

// UIKit view
struct ARViewContainer: UIViewRepresentable
{
    let arView = ARView(frame: .zero, cameraMode: .ar, automaticallyConfigureSession: true)
    
    // creates custom instance that you use to communcate changes from your view to other parts of your swiftUI interface
    func makeCoordinator() -> Coordinator
    {
        Coordinator(parent: self)
    }
    
    // implement this method and use it to create your view object -- called initially once
    func makeUIView(context: Context) -> ARView
    {
        arView.setupImageDetectionConfigs()
        //Assigns coordinator to delegate the ARViewContainer
        arView.session.delegate = context.coordinator
        
        return arView
    }
    
    
    
    // SwiftUI calls this method for any changes affecting the corresponding SwiftUI view
    func updateUIView(_ uiView: ARView, context: Context)
    {}
}

extension ARView: ARSessionDelegate
{
    func setupImageDetectionConfigs()
    {
        // image to track
        guard let imagesToDetect = ARReferenceImage.referenceImages(inGroupNamed: "Pics", bundle: Bundle.main)
        else
        {
            fatalError("Missing expected asset catalog resources.")
        }
        
        //configure image detection
        let configuration = ARWorldTrackingConfiguration()
        configuration.detectionImages = imagesToDetect
        configuration.maximumNumberOfTrackedImages = 1
        self.session.run(configuration)
    }
}
