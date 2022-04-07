//
//  StudentSocketManager.swift
//  SocketIOStream
//
//  Created by Addin Satria on 25/01/22.
//

import Foundation
import SocketIO
import SwiftUI

class StudentSocketManager: NSObject, ObservableObject {
  
  @Published var frames: [String] = []
  static let sharedInstance = StudentSocketManager()
  
  let manager = SocketManager(socketURL: URL(string: "http://localhost:3000")!)
  
  var socket: SocketIOClient!
  
  override init() {
    super.init()
    
    socket = manager.defaultSocket
    
    socket.on(clientEvent: .connect) { data, ack in
      print("CONNECTED DATA: \(data)")
      print("CONNECTED ACK: \(ack.description)")
      self.receive()
    }

    self.establishConnection()
  }
  
  func login(_ id: String) {
    print("Login")
    socket.emit("login", id)
  }
  
  func establishConnection() {
    socket.connect()
    print("Connected to Socket !")
  }
  
  func receive() {
    print("Receiving Data")
    socket.on("notification") { data, ack in
      if let data = data as? [String] {
        self.frames = data
      }
      print(data[0])
    }
  }
  
  func closeConnection() {
    socket.disconnect()
    print("Disconnected from Socket !")
  }
}
