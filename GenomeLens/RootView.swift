//
//  RootView.swift
//  GenomeLens
//
//  Created by Esha Pai on 1/7/26.
//

import SwiftUI

struct RootView: View{
    var body: some View{
        TabView{
            HomeView().tabItem {Label("Home", systemImage: "house")}
            UploadView().tabItem {Label("Upload", systemImage: "square.and.arrow.up")}
            ChatView().tabItem {Label("Chat", systemImage: "message")}
            AboutView().tabItem {Label("About", systemImage: "info.circle")}
        }
    }
}
