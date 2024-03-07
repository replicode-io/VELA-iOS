//
//  API+RPC.swift
//  Parallax
//
//  Created by Robert Canton on 2024-01-21.
//

import Foundation
import Combine

extension API {
    struct RPC {
        static func getTokenAccountBalance(chainID: String, address: String, contractAddress: String) -> AnyPublisher<Response.TokenAccountBalance, Error> {
            return NetworkManager.shared.request(
                .GET,
                .rpc,
                .tokenAccountBalance(chainID: chainID, address: address, contractAddress: contractAddress),
                ofType: Response.TokenAccountBalance.self
            )
        }
    }
}

extension API.RPC {
    struct Response {
        struct TokenAccountBalance:Codable {
            let status: String
            let message: String
            let result: String
        }
    }
}
