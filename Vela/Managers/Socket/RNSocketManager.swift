//
//  RNSocketManager.swift
//  TradeLink
//
//  Created by Robert Canton on 2021-01-16.
//

import Foundation
import SocketIO

protocol RNSocketDelegate {
    func socketConnected()
    func socketDisconnected()
}

class RNSocketManager:NSObject, Service {
    
    let name = "RNSocketManager"
    
    static let shared = RNSocketManager()
    
    private let socket:SocketIOClient
    private let socketManager:SocketManager
    private let socketURL = URL(string: API.Hosts.rpc.rawValue)!
    
    private(set) var isConnected = false
    
    private var eventHandlers = [String:NormalCallback]()
    
    var delegate:RNSocketDelegate?
    
    private override init() {
        socketManager = SocketManager(socketURL: socketURL,
                                      config: [.log(false), .compress])
        socket = socketManager.defaultSocket
        
        super.init()
        
    }

    
    
    func connect() {
        var count = 0
        socket.disconnect()
        
        socket.on(clientEvent: .connect) {data, ack in
            self.isConnected = true
            
            self.delegate?.socketConnected()
            
            self.log("Connected")
            
            self.on(.msg) { data, ack in
                count += 1
            }
            
            self.emit(.msg("Hello"))
            
        }
        
        socket.on(clientEvent: .disconnect) { data, ack in
            self.isConnected = false
            
            self.delegate?.socketDisconnected()
            
            self.log("Disconnected")

            self.socket.connect()
        }

        socket.connect()
    }
    
    func emit(_ emittable:Emittable) {
        let data = emittable.data
        socket.emit(data.0, data.1)
    }
    
    func on(_ event:Event, callback: @escaping NormalCallback) {
        socket.on(event.name, callback: callback)
    }
    
    func off(_ event:Event) {
        socket.off(event.name)
    }
    
    
}
