//
//  GenomeParser.swift
//  GenomeLens
//
//  Created by Esha Pai on 1/7/26.
//
import Foundation

enum GenomeParserError: Error, LocalizedError{
    case unsupportedFormat
    case emptyFile
    
    var errorDescription: String?{
        switch self{
        case .unsupportedFormat:
            return "This doesn't look like a 23andMe-style raw data file. Please try again."
        case .emptyFile:
            return "Whoops! Looks liek you provided an empty file. Please try again."
        }
    }
}

struct GenomeSummary{
    let fileName: String
    let variantCount: Int
}

struct GenomeParser {
    /// Expected columns: rsid <tab> chrom <tab> position <tab> genotype
    static func parse23AndMe(url: URL) throws -> GenomeSummary {
        let fileName = url.lastPathComponent
        let contents = try String(contentsOf: url, encoding: .utf8)
        if contents.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            throw GenomeParserError.emptyFile
        }

        var count = 0
        var sawDataLine = false

        for line in contents.split(whereSeparator: \.isNewline) {
            if line.hasPrefix("#") { continue }        // comments/headers
            let parts = line.split(whereSeparator: { $0.isWhitespace })
            if parts.count < 4 { continue }            // skip malformed lines

            //rsid usually starts with "rs"
            if !parts[0].hasPrefix("rs") { continue }

            sawDataLine = true
            count += 1
        }

        if !sawDataLine {
            throw GenomeParserError.unsupportedFormat
        }

        return GenomeSummary(fileName: fileName, variantCount: count)
    }
}
