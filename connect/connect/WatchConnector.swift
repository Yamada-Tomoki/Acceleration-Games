//
//  WatchConnector.swift
//  connect
//
//  Created by member on 2023/06/21.
//

import Foundation
import WatchConnectivity

class WatchConnector: NSObject, ObservableObject, WCSessionDelegate {
    
    @Published var labelaX = "0.0"
    @Published var labelaY = "0.0"
    @Published var labelaZ = "0.0"
   
    @Published var labelgX = "0.0"
    @Published var labelgY = "0.0"
    @Published var labelgZ = "0.0"
    
    @Published var maxAcceleration: Double = 0.0
    
    override init() {
        super.init()
        if WCSession.isSupported() {
            WCSession.default.delegate = self
            WCSession.default.activate()
        }
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("activationDidCompleteWith state= \(activationState.rawValue)")
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        print("sessionDidBecomeInactive")
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        print("sessionDidDeactivate")
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        print("didReceiveMessage: \(message)")
        
        if message["acceleX"] != nil || message["acceleY"] != nil || message["acceleZ"] != nil {
            let ax : Double = message["acceleX"] as! Double
            let ay : Double = message["acceleY"] as! Double
            let az : Double = message["acceleZ"] as! Double
                        
            let currentAcceleration = sqrt(ax * ax + ay * ay + az * az)
            if currentAcceleration > maxAcceleration {
                maxAcceleration = currentAcceleration
            }
            
            DispatchQueue.main.async {
                self.labelaX = String(ax)
                self.labelaY = String(ay)
                self.labelaZ = String(az)
            }
        }
        
        if message["gyroX"] != nil || message["gyroY"] != nil || message["gyroZ"] != nil {
            let gx : Double = message["gyroX"] as! Double
            let gy : Double = message["gyroY"] as! Double
            let gz : Double = message["gyroZ"] as! Double
            
            DispatchQueue.main.async {
                self.labelgX = String(gx)
                self.labelgY = String(gy)
                self.labelgZ = String(gz)
            }
        }
    }
}
