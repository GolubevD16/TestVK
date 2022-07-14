//
//  MainViewModel.swift
//  VKProgect
//
//  Created by Дмитрий Голубев on 14.07.2022.
//

import Foundation

final class MainViewModel {
    var onStateChanged: ((State) -> Void)?
    var services: [Service] = []
    
    private(set) var state: State = .initial {
        didSet {
            onStateChanged?(state)
        }
    }

    func send(_ action: Action) {
        switch action {
        case .viewIsReady:
            fetchDevices()
        case .openService(let num):
            state = .serviceTapped(services[num].link)
        }
    }
    
    private func fetchDevices() {
        NetworkManager.shared.featchServices {[weak self] services in
            self?.services = services
            self?.state = .loaded
        }
    }
}

extension MainViewModel {

    enum Action {
        case viewIsReady
        case openService(Int)
    }

    enum State {
        case initial
        case loaded
        case serviceTapped(String)
        case error(String)
    }
}

