//
//  HomeView.swift
//  GenomeLens
//
//  Created by Esha Pai on 1/7/26.
//

import SwiftUI

struct HomeView: View{
    @EnvironmentObject private var appState: AppState
    
    var body: some View{
        NavigationStack{
            List{
                Section("Status"){
                    if appState.hasGenomeLoaded{
                        VStack(alignment: .leading, spacing: 6){
                            Text("Genome loaded successfully").font(.headline)
                            if let name = appState.genomeFileName{
                                Text("File: \(name)")
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                            }

                            if let count = appState.variantCount{
                                Text("Variants: \(count.formatted())")
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                            }
                        }
                        
                        Button(role: .destructive){
                            appState.clearGenome()
                        }
                        label: {
                            Text("Clear genome data")
                        }
                    }
                    else{
                        Text("No genome data loaded yet.")
                            .foregroundStyle(.secondary)
                    }
                }
                
                Section("Quick actions") {
                    NavigationLink("Upload a genome file", destination: UploadView())
                    NavigationLink("Open chat", destination: ChatView())
                }
                }
            .navigationTitle("GenomeLens")
            }
        }
    }

#Preview{
    HomeView()
        .environmentObject(AppState())
}
