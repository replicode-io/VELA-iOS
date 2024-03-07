//
//  Manager+Extensions.swift
//  Rune
//
//  Created by Robert Canton on 2023-02-28.
//

import Foundation

public protocol Service {
    var name:String { get }
    
    func log(_ msg:String)
}

extension Service {
    public func log(_ msg:String) {
        print("[Service] \(name) \(msg)")
    }
}
