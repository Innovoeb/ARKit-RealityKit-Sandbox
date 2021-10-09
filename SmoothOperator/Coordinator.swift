//
//  Coordinator.swift
//  SmoothOperator
//
//  Created by Beovonni on 10/3/21.
//

import SwiftUI
import RealityKit
import ARKit
import AVFoundation

// delegate for AR view representable
class Coordinator: NSObject, ARSessionDelegate
{
    // test
    var parent: ARViewContainer
    var videoPlayer: AVPlayer!

    init(parent: ARViewContainer)
    {
        self.parent = parent
    }
    
    // this method is called when an anchor has been added to the AR session
    func session(_ session: ARSession, didAdd anchors: [ARAnchor])
    {
        //print("image detected!")
        /*
        // play an audo file when an image anchor is added
        // Sounds.playSounds(soundfile: "SmoothOperator.mp3")
         */
        
        // if an ARImageAnchor exists, store it in a variable
        guard let imageAnchor = anchors[0] as? ARImageAnchor
        // print an error code if the app cannot load the image anchor
        else
        {
            print("Problems loading anchor.")
            return
        }
        //Assigns video to be overlaid
        guard let path = Bundle.main.path(forResource: "Sade - Smooth Operator", ofType: "mp4")
        else
        {
            print("Unable to find video file.")
            return
        }
        
        let videoURL = URL(fileURLWithPath: path)
        let playerItem = AVPlayerItem(url: videoURL)
        videoPlayer = AVPlayer(playerItem: playerItem)
        let videoMaterial = VideoMaterial(avPlayer: videoPlayer)
        let width = Float(imageAnchor.referenceImage.physicalSize.width)
        var height = Float(imageAnchor.referenceImage.physicalSize.height)
        height.negate()
        
        //Sets the aspect ratio of the video to be played, and the corner radius of the video
        let videoPlane = ModelEntity(mesh: .generatePlane(width: width, depth: height, cornerRadius: 0.2), materials: [videoMaterial])
        
        //Assigns reference image that will be detected
        if let imageName = imageAnchor.name, imageName  == "sade"
        {
            // AnchorEntity(world: ) creates an anchor entity with a target fixed at the given position in the scene.
            // transform = A matrix encoding the position, orientation, and scale of the anchor relative to the world
            let anchor = AnchorEntity(world: imageAnchor.transform)
            //Adds specified video to the anchor
            anchor.addChild(videoPlane)
            // sets position of the created videoPlane anchor to be right above the tracked image (z coordinate)
            videoPlane.setPosition(SIMD3(x: 0 ,y: 0 ,z: height), relativeTo: anchor)
            parent.arView.scene.addAnchor(anchor)
            videoPlayer.play()
        }
    }
}

