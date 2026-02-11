//
//  SushiPreviewContainer.swift
//  SushiScore
//
//  Created by 保坂篤志 on 2025/06/12.
//

import UIKit
import SwiftData

@MainActor
let sushiRecordContainer: ModelContainer = {
    do {
        let container = try ModelContainer(
            for: SushiRecord.self,
            configurations: ModelConfiguration(isStoredInMemoryOnly: true)
        )
        let modelContext = container.mainContext

        guard let uiImage = UIImage(named: "previewImage"),
              let imageData = uiImage.pngData() else {
            fatalError("Failed to load previewImage")
        }

        if try modelContext.fetch(FetchDescriptor<SushiRecord>()).isEmpty {
            modelContext.insert(SushiRecord(score: 1000, date: Date(), image: imageData))
        }

        return container
    } catch {
        fatalError(error.localizedDescription)
    }
}()

let previewRecords = [
    SushiRecord(
        score: 300,
        date: Date(),
        image: UIImage(named: "previewImage")!.pngData()!
    ),
    SushiRecord(
        score: -150,
        date: Date().addingTimeInterval(-86400),
        image: UIImage(named: "previewImage")!.pngData()!
    ),
    SushiRecord(
        score: 500,
        date: Date().addingTimeInterval(-86400 * 2),
        image: UIImage(named: "previewImage")!.pngData()!
    )
]
