//
//  ARCoinSceneService.swift
//  CT_AR
//
//  Created by Giovanni Cavaliere on 11/09/22.
//

import Foundation
import SwiftUI
import Combine
import RealityKit

class ARCoinViewSceneService {
   
    var arView: ARView!
    let coinSceneAnchor: Experience.Box!
    
    init() {
        let cameraAnchor: AnchorEntity = AnchorEntity(.camera)
        self.coinSceneAnchor = try! Experience.loadBox()
        cameraAnchor.addChild(coinSceneAnchor)
        coinSceneAnchor.transform.translation = [0, 0, 0]
        arView = ARView(frame: .zero)
        arView.scene.addAnchor(cameraAnchor)
      
    }
    
    
    //per permettere al coin virtuale di essere ridotto, traslato nello spazio e ruotato
    func installGestures(on object: HasCollision) {
        object.generateCollisionShapes(recursive: true)
        arView.installGestures([.scale],for: object)
    }
   
    //Aggiorna entita di reality composer con il prezzo corrente del btc
func updateCurrentPrice(currentPrice: Double) {
    let coinNameEntity = (coinSceneAnchor.cpExprerience?.children[0].children[0])! as Entity
    var coinNameComponent: ModelComponent = (coinNameEntity.components[ModelComponent])!
    coinNameComponent.mesh = .generateText(
        "€\(String(currentPrice))",
        extrusionDepth: 0.007,
        font: UIFont(name: "Arial", size: 0.25) ?? .systemFont(ofSize: 0.025),
containerFrame: CGRect.init(x: 0.075, y: 0.0, width: 0, height: 0.0),
alignment: .center,
lineBreakMode: .byCharWrapping)
    coinNameEntity.components.set(coinNameComponent)
    }
    
    func updatePercentageChange24H(percentage: Double) {
        let coinNameEntity = (coinSceneAnchor.percentageChange24H?.children[0].children[0])! as Entity
        var coinNameComponent: ModelComponent = (coinNameEntity.components[ModelComponent])!
        coinNameComponent.mesh = .generateText(
            "%\(String(percentage))",
            extrusionDepth: 0.007,
            font: UIFont(name: "Arial", size: 0.25) ?? .systemFont(ofSize: 0.025),
    containerFrame: CGRect.init(x: 0.075, y: 0.0, width: 0, height: 0.0),
    alignment: .center,
    lineBreakMode: .byCharWrapping)
        coinNameEntity.components.set(coinNameComponent)
        }
}

