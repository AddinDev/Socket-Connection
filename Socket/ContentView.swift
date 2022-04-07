//
//  ContentView.swift
//  Socket
//
//  Created by Addin Satria on 07/04/22.
//

import SwiftUI

struct ContentView: View {
  @StateObject private var ssm = StudentSocketManager.sharedInstance
  @StateObject private var tsm = TeacherSocketManager.sharedInstance
  
  @State private var loginId = ""
  @State private var sendId = ""
  
  @State private var message = ""
  
  var body: some View {
    VStack {
      VStack {
        if loginId != "" {
        Text("listening at: \(loginId)")
          ForEach(ssm.frames, id: \.self) { frame in
            Text(frame)
          }
        }
      }
      HStack {
        TextField("id", text: $loginId)
        Button("Login") {
          ssm.login(loginId)
        }
      }
      .padding()
      VStack {
        HStack {
          TextField("id", text: $sendId)
          Button("Send") {
            tsm.sendNotification(sendId, message)
          }
        }
        TextField("message", text: $message)
      }
      .padding()
    }
    //    .onAppear {
    //      print(self.sios.frames)
    //    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
