//
//  PhoneConnector.swift
//  connect Watch App
//
//  Created by member on 2023/06/21.
//

import Foundation
import CoreMotion
import WatchConnectivity

class PhoneConnector: NSObject, ObservableObject, WCSessionDelegate, WKExtendedRuntimeSessionDelegate {
    
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
