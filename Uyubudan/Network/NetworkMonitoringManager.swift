//
//  NetworkMonitoringManager.swift
//  Uyubudan
//
//  Created by SangRae Kim on 4/30/24.
//

import Foundation
import Network
import RxSwift
import RxCocoa

final class NetworkMonitoringManager {
    
    static let shared = NetworkMonitoringManager()
    private let queue = DispatchQueue.global()
    private let monitor: NWPathMonitor
    private(set) var isConnected = BehaviorRelay(value: true)
    
    private init() {
        monitor = NWPathMonitor()
    }
    
    func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            guard let self else { return }
            
            if path.status == .satisfied {
                self.isConnected.accept(true)
            } else {
                self.isConnected.accept(false)
            }
        }
        monitor.start(queue: queue)
    }
    
    func stopMonitoring() {
        monitor.cancel()
    }
}
