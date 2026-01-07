//
//  AboutView.swift
//  GenomeLens
//
//  Created by Esha Pai on 1/7/26.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        NavigationStack {
            List {
                Section("GenomeLens") {
                    Text("An educational tool that helps you explore and ask questions about a raw genotype file.")
                }

                Section("Privacy") {
                    Text("This prototype is designed to process files in-memory and avoid storing raw genome data.")
                }

                Section("Limitations") {
                    Text("Not medical advice. Associations may be population-specific and incomplete.")
                }
            }
            .navigationTitle("About")
        }
    }
}
