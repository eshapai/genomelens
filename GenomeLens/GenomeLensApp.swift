//
//  GenomeLensApp.swift
//  GenomeLens
//
//  Created by Esha Pai on 1/6/26.
//
import Combine
import SwiftUI

@main
struct GenomeLensApp: App {
    @StateObject private var appState = AppState()
    
    var body: some Scene{
        WindowGroup{
            RootView().environmentObject(appState)
        }
    }
}
