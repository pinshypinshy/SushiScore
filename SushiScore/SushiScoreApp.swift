import SwiftUI
import SwiftData

@main
struct SushiScoreApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: [SushiRecord.self])
        }
    }
}
