//
//  SushiRecord.swift
//  SushiScore
//
//  Created by 平石悠生 on 2026/02/11.
//

import Foundation
import SwiftData

@Model
class SushiRecord: Identifiable {
    var score: Int
    var date: Date
    var image: Data
    
    init(score: Int, date: Date, image: Data) {
        self.score = score
        self.date = date
        self.image = image
    }
}
