//
//  RootViewModel.swift
//  BowlShopSwiftUI
//
//  Created by Baris OZGEN on 8.11.2022.
//

import Firebase

class RootViewModel: ObservableObject {
    private let authManager = AuthManager.shared
    
    @Published var userSession: Firebase.User?
    @Published var animIsOver = false
    @Published var viewIsLoaded = false
    
    init() {
        setupApp()
    }
    
    func setupApp() {
#if os(macOS)
        Task{
            userSession = authManager.userSession
           // try await Task.sleep(until: .now + .seconds(1), clock: .continuous)
            animIsOver = true
           // try await Task.sleep(until: .now + .seconds(0.7), clock: .continuous)
            viewIsLoaded = true
            
        }
        
        
#else
        Task {
            userSession = authManager.userSession
            try await Task.sleep(until: .now + .seconds(1), clock: .continuous)
            self.animIsOver = true
            try await Task.sleep(until: .now + .seconds(0.7), clock: .continuous)
            self.viewIsLoaded = true
        }
#endif
    }
}
