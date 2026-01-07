//
//  AppState.swift
//  GenomeLens
//
//  Created by Esha Pai on 1/7/26.
//
import Combine
import Foundation
import SwiftUI

@MainActor
final class AppState: ObservableObject {
    @Published var hasGenomeLoaded: Bool = false
    @Published var variantCount: Int? = nil
    @Published var genomeFileName: String? = nil
    
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    func setLoaded(fileName: String, variantCount: Int){
        self.hasGenomeLoaded = true
        self.genomeFileName = fileName
        self.variantCount = variantCount
        self.errorMessage = nil
    }
    
    func clearGenome(){
        hasGenomeLoaded = false
        genomeFileName = nil
        variantCount = nil
        errorMessage = nil
        
    }
}
