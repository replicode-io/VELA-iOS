//
//  OpenOrdersDTO.swift
//  Parallax
//
//  Created by Robert Canton on 2024-01-09.
//

import Foundation

struct OpenOrdersDTO:Codable {
    let triggerOrders:[TriggerOrder]
    let pendingOrders:[PendingOrder]
}
