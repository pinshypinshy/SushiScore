import SwiftUI
import SwiftData

struct ContentView: View {
    @Query(sort: \SushiRecord.date, order: .reverse) var records: [SushiRecord]
    @State var showNewRecordView = false

    var body: some View {
        ZStack {
            VStack {
                List {
                    GraphView(records: records)
                        .frame(height: 200)
                    ForEach(records) { record in
                        VStack {
                            HStack {
                                Text("\(record.score)円")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundStyle(record.score >= 0 ? Color.yellow : Color.blue)

                                Spacer()

                                Text(dateFormatter.string(from: record.date))
                                    .font(.headline)
                            }

                            if let uiImage = UIImage(data: record.image) {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .scaledToFit()
                            }
                        }
                        .padding(.vertical, 5)
                    }
                }
            }
            .navigationTitle("記録一覧")

            VStack {
                Spacer()

                Button {
                    showNewRecordView.toggle()
                } label: {
                    Text("点数を記録する  \(Image(systemName: "plus.circle.fill"))")
                        .padding()
                        .background(Color.blue)
                        .foregroundStyle(.white)
                        .clipShape(.capsule)
                }
                .shadow(radius: 10)
                .padding()
                .sheet(isPresented: $showNewRecordView) {
                    NewRecordView()
                }
            }
        }
    }

}

#Preview {
    ContentView()
        .modelContainer(sushiRecordContainer)
}
