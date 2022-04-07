//
//  TeacherSocketManager.swift
//  Socket
//
//  Created by Addin Satria on 07/04/22.
//

import Foundation
import SocketIO
import SwiftUI

class TeacherSocketManager: NSObject, ObservableObject {
  
  @Published var frames: [String] = []
  static let sharedInstance = TeacherSocketManager()
  
  let manager = SocketManager(socketURL: URL(string: "http://localhost:3000")!)
  
  var socket: SocketIOClient!
  
  override init() {
    super.init()
    
    socket = manager.defaultSocket
    
    socket.on(clientEvent: .connect) { data, ack in
      print("CONNECTED DATA: \(data)")
      print("CONNECTED ACK: \(ack.description)")
    }

    self.establishConnection()
  }
  
  func sendNotification(_ id: String, _ message: String) {
    print("Send Notification")
    socket.emit("notification", id, message)
  }
  
  func establishConnection() {
    socket.connect()
    print("Connected to Socket !")
  }
  
  func closeConnection() {
    socket.disconnect()
    print("Disconnected from Socket !")
  }
}
