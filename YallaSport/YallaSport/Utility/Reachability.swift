//
//  Reachability.swift
//  YallaSport
//
//  Created by husayn on 29/04/2024.
//

import Foundation
import Reachability
class NetworkManager{
    static let networkM = NetworkManager()
    private let reachability = try! Reachability()
    private init(){
        NotificationCenter.default.addObserver(self, selector: #selector(networkStatusChanged), name: .reachabilityChanged, object: nil)
        try! reachability.startNotifier()
    }
    @objc private func networkStatusChanged() {
        if IsInternetAvailable(){
            print("Internet is connected")
        }else{
            print("no internet")
        }
    }
    func IsInternetAvailable() -> Bool {
        return reachability.connection != .unavailable
    }
}
