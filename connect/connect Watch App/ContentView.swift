//
//  ContentView.swift
//  connect Watch App
//
//  Created by member on 2023/06/15.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var motionManager = MotionManager()
    @State private var maxAcceleration: Double = 0.0
    @State var labelButton = "start"
    
    var body: some View {
        ScrollView {
            VStack {
                HStack(alignment: .top) {
                    VStack(alignment: .trailing) {
                        Text("acceleX =").frame(width: 80, alignment: .trailing)
                        Text("acceleY =").frame(width: 80, alignment: .trailing)
                        Text("acceleZ =").frame(width: 80, alignment: .trailing)
                        Text("gyroX =").frame(width: 80, alignment: .trailing)
                        Text("gyroY =").frame(width: 80, alignment: .trailing)
                        Text("gyroZ =").frame(width: 80, alignment: .trailing)
                    }
                    
                    VStack(alignment: .trailing) {
                        Text(motionManager.acceleX).frame(width: 65, alignment: .trailing)
                        Text(motionManager.acceleY).frame(width: 65, alignment: .trailing)
                        Text(motionManager.acceleZ).frame(width: 65, alignment: .trailing)
                        Text(motionManager.gyroX).frame(width: 65, alignment: .trailing)
                        Text(motionManager.gyroY).frame(width: 65, alignment: .trailing)
                        Text(motionManager.gyroZ).frame(width: 65, alignment: .trailing)
                    }
                }
                Button(labelButton) {
                    if(motionManager.isStarted){
                        motionManager.stop()
                        labelButton = "start"
                        print(motionManager.dataDic)
                    } else {
                        motionManager.start()
                        labelButton = "stop"
                        WKExtension.shared().isAutorotating = true
                    }
                }
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

