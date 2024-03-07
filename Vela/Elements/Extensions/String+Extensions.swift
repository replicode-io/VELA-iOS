//
//  String+Extensions.swift
//  Parallax
//
//  Created by Robert Canton on 2024-01-04.
//

import Foundation

extension String {
    
    
    var prefixAddress:String {
        if self.count < 6 {
            return self
        }
        return "\(self.prefix(6))"
    }
    
    var shortAddress:String {
        
        if self.count < 12 {
            return self
        }
        return "\(self.prefix(6))...\(self.suffix(4))"
    }
    
    var shortHash:String {
    
        if self.count < 10 {
            return self
        } else {
            let start = self.index(self.startIndex, offsetBy: 2)
            let end = self.index(self.startIndex, offsetBy: 2+4)
            let range = start..<end

            return String(self[range])
        }
    }
    
    func shortenedHash(_ limit:Int=4, prefixed:Bool=false) -> String {
        let startIndex = prefixed ? 0 : 2
        if self.count < 10 {
            return self
        } else {
            let start = self.index(self.startIndex, offsetBy: startIndex)
            let end = self.index(start, offsetBy: limit + (prefixed ? 2 : 0))
            let range = start..<end

            return String(self[range])
        }
    }
    
    var functionDisplayName:String {
        let firstBracket = self.firstIndex(of: "(") ?? self.endIndex
        let pureName = String(self[self.startIndex..<firstBracket])
        return pureName
    }
    
}
