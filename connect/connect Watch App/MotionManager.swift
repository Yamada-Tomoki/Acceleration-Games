//
//  MotionManager.swift
//  connect Watch App
//
//  Created by member on 2023/06/21.
//

import Foundation
import CoreMotion
import WatchConnectivity
import SwiftUI

class MotionManager: NSObject, ObservableObject, WCSessionDelegate, WKExtendedRuntimeSessionDelegate {
    let motionManager = CMMotionManager()
    
    @Published var isStarted = false
    
    @Published var acceleX = "0.0"
    @Published var acceleY = "0.0"
    @Published var acceleZ = "0.0"
    
    @Published var gyroX = "0.0"
    @Published var gyroY = "0.0"
    @Published var gyroZ = "0.0"
    
    @Published var dataDic:[String:Any] = [:]
    
    var erSession = WKExtendedRuntimeSession()
    
    override init() {
        super.init()
        erSession.delegate = self
        if WCSession.isSupported() {
            WCSession.default.delegate = self
            WCSession.default.activate()
        }
    }
    
    func start() {
        if motionManager.isDeviceMotionAvailable {
            motionManager.deviceMotionUpdateInterval = 0.1
            motionManager.startDeviceMotionUpdates(to: OperationQueue.current!, withHandler: {(motion:CMDeviceMotion?, error:Error?) in self.updateMotionData(deviceMotion: motion!)})
        }
        
        isStarted = true
        
        erSession.start()
    }
    
    func stop() {
        isStarted = false
        motionManager.stopDeviceMotionUpdates()
        erSession.invalidate()
    }
    
    private func updateMotionData(deviceMotion:CMDeviceMotion) {
        let pi = Double.pi
        
        var aX = deviceMotion.userAcceleration.x
        var aY = deviceMotion.userAcceleration.y
        var aZ = deviceMotion.userAcceleration.z
        
        aX = round(aX * 1000)/1000
        aY = round(aY * 1000)/1000
        aZ = round(aZ * 1000)/1000
        
        dataDic["acceleX"] = aX
        dataDic["acceleY"] = aY
        dataDic["acceleZ"] = aZ

        acceleX = String(aX)
        acceleY = String(aY)
        acceleZ = String(aZ)
        
        var gyX = deviceMotion.attitude.roll
        var gyY = deviceMotion.attitude.pitch
        var gyZ = deviceMotion.attitude.yaw
        
        gyX = round(gyX * (180 / pi) + 180)
        gyY = round(gyY * (180 / pi) + 180)
        gyZ = round(gyZ * (180 / pi) + 180)
        
        dataDic["gyroX"] = gyX
        dataDic["gyroY"] = gyY
        dataDic["gyroZ"] = gyZ

        gyroX = String(gyX)
        gyroY = String(gyY)
        gyroZ = String(gyZ)
        
        print(dataDic)
        send()
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("activationDidCompleteWith state= \(activationState.rawValue)")
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        print("didReceiveMessage: \(message)")
    }

    func send() {
        if WCSession.default.isReachable {
            WCSession.default.sendMessage(dataDic, replyHandler: nil){
                error in
                print(error)
            }
        }
    }
    
    func extendedRuntimeSession(_ extendedRuntimeSession: WKExtendedRuntimeSession, didInvalidateWith reason: WKExtendedRuntimeSessionInvalidationReason, error: Error?) {
    }
    
    func extendedRuntimeSessionDidStart(_ extendedRuntimeSession: WKExtendedRuntimeSession) {
    }
    
    func extendedRuntimeSessionWillExpire(_ extendedRuntimeSession: WKExtendedRuntimeSession) {
    }
}
