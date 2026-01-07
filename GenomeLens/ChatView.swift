//
//  ChatView.swift
//  GenomeLens
//
//  Created by Esha Pai on 1/7/26.
//

import SwiftUI

struct ChatView: View {
    @EnvironmentObject private var appState: AppState
    @State private var draft: String = ""
    @State private var messages: [String] = []

    var body: some View {
        NavigationStack {
            VStack {
                if !appState.hasGenomeLoaded {
                    ContentUnavailableView(
                        "No genome loaded",
                        systemImage: "exclamationmark.triangle",
                        description: Text("Upload a genome file first, then come back to chat.")
                    )
                    .padding()
                } else {
                    List {
                        ForEach(messages.indices, id: \.self) { i in
                            Text(messages[i])
                        }
                    }
                }

                HStack(spacing: 8) {
                    TextField("Ask a question…", text: $draft)
                        .textFieldStyle(.roundedBorder)

                    Button("Send") {
                        guard !draft.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }

                        if appState.hasGenomeLoaded {
                            messages.append("You: \(draft)")
                            messages.append("GenomeLens: (Milestone 1 placeholder) I can chat once parsing + knowledge base exist.")
                        } else {
                            messages.append("GenomeLens: Please upload a genome file first.")
                        }

                        draft = ""
                    }
                    .buttonStyle(.borderedProminent)
                }
                .padding()
            }
            .navigationTitle("Chat")
        }
    }
}

#Preview {
    ChatView()
}
