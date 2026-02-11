//
//  GraphView.swift
//  SushiScore
//
//  Created by 保坂篤志 on 2024/11/22.
//

import SwiftUI
import Charts

struct GraphView: View {
    var records: [SushiRecord]

    var body: some View {
        Chart {
            ForEach(records) { record in
                LineMark(
                    x: .value("日付", record.date, unit: .day),
                    y: .value("点数", record.score)
                )
                .foregroundStyle(.yellow)
            }
        }
        .chartXAxis {
            AxisMarks(values: .automatic) { value in
                if let date = value.as(Date.self) {
                    AxisValueLabel {
                        Text(date.formatted(.dateTime.month(.twoDigits).day(.twoDigits)))
                    }
                }
            }
        }
        .chartYAxis {
            AxisMarks(values: .automatic) { value in
                AxisValueLabel(value.as(Int.self)?.description ?? "")
            }
        }
    }
}

#Preview {
    GraphView(records: previewRecords)
        .frame(height: 300)
        .padding()
}
