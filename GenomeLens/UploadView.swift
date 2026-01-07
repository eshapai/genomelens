//
//  UploadView.swift
//  GenomeLens
//
//  Created by Esha Pai on 1/7/26.
//
import SwiftUI
import UniformTypeIdentifiers

struct UploadView: View {
    @EnvironmentObject private var appState: AppState
    @State private var showingImporter = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                Text("Upload your genome file")
                    .font(.title2)
                    .fontWeight(.semibold)

                Text("V1 supports 23andMe-style raw text files (.txt).")
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

                Button {
                    showingImporter = true
                } label: {
                    Label("Choose file", systemImage: "doc")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .padding(.horizontal)
                .disabled(appState.isLoading)

                if appState.isLoading {
                    ProgressView("Parsing…")
                }

                if let err = appState.errorMessage {
                    Text(err)
                        .foregroundStyle(.red)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }

                if appState.hasGenomeLoaded,
                   let name = appState.genomeFileName,
                   let count = appState.variantCount {
                    VStack(spacing: 6) {
                        Text("Loaded ✅")
                            .font(.headline)
                        Text("File: \(name)")
                            .foregroundStyle(.secondary)
                        Text("Variants: \(count.formatted())")
                            .foregroundStyle(.secondary)
                    }
                } else {
                    Text("Nothing loaded yet.")
                        .foregroundStyle(.secondary)
                }

                Spacer()
            }
            .padding()
            .navigationTitle("Upload")
            .fileImporter(
                isPresented: $showingImporter,
                allowedContentTypes: [.plainText, .text],
                allowsMultipleSelection: false
            ) { result in
                handleImport(result)
            }
        }
    }

    private func handleImport(_ result: Result<[URL], Error>) {
        switch result {
        case .failure(let error):
            appState.errorMessage = error.localizedDescription

        case .success(let urls):
            guard let url = urls.first else { return }

            // Security-scoped access is important for files from Files app/iCloud
            let didStartAccessing = url.startAccessingSecurityScopedResource()

            appState.isLoading = true
            appState.errorMessage = nil

            Task {
                defer {
                    if didStartAccessing { url.stopAccessingSecurityScopedResource() }
                }

                do {
                    let summary = try GenomeParser.parse23AndMe(url: url)
                    await MainActor.run {
                        appState.setLoaded(fileName: summary.fileName, variantCount: summary.variantCount)
                        appState.isLoading = false
                    }
                } catch {
                    await MainActor.run {
                        appState.errorMessage = (error as? LocalizedError)?.errorDescription ?? error.localizedDescription
                        appState.isLoading = false
                    }
                }
            }
        }
    }
}
