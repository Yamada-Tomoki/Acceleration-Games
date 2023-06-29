//
//  ContentView.swift
//  connect
//
//  Created by member on 2023/06/15.
//

import SwiftUI
import WatchConnectivity

struct ContentView: View {
    @ObservedObject var wconnector = WatchConnector()
    
    var body: some View {
        VStack{
            HStack(alignment: .top) {
                VStack(alignment: .trailing){
                    Text("AccelerationX = ").frame(width: 150, alignment: .trailing)
                    Text("AccelerationY = ").frame(width: 150, alignment: .trailing)
                    Text("AccelerationZ = ").frame(width: 150, alignment: .trailing)
                    Text("GyroX = ").frame(width: 150, alignment: .trailing)
                    Text("GyroY = ").frame(width: 150, alignment: .trailing)
                    Text("GyroZ = ").frame(width: 150, alignment: .trailing)
                    Text("MaxAcceleration = ").frame(width: 150, alignment: .trailing)
                }
                
                VStack(alignment: .trailing) {
                    Text(wconnector.labelaX).frame(width: 80, alignment: .trailing)
                    Text(wconnector.labelaY).frame(width: 80, alignment: .trailing)
                    Text(wconnector.labelaZ).frame(width: 80, alignment: .trailing)
                    Text(wconnector.labelgX).frame(width: 80, alignment: .trailing)
                    Text(wconnector.labelgY).frame(width: 80, alignment: .trailing)
                    Text(wconnector.labelgZ).frame(width: 80, alignment: .trailing)
                    Text(String(format: "%.3f", wconnector.maxAcceleration)).frame(width: 80, alignment: .trailing)
                    Spacer().frame(height: 100)
                }
            }.padding()
            
            Image("arrow")
                .rotationEffect(.degrees(-Double(wconnector.labelgZ)! + 360))
                .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
