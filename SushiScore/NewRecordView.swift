import SwiftUI
import PhotosUI
import SwiftData

struct NewRecordView: View {
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) private var dismiss

    @State private var scoreText: String = ""
    @State private var selectedImage: PhotosPickerItem? = nil
    @State private var selectedImageData: Data? = nil
    @State private var showAlert = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                //ここにコードを書くよ！
                TextField("点数を入力", text: $scoreText)
                    .keyboardType(.numberPad)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .clipShape(.rect(cornerRadius: 8))
                
                if let selectedImageData {
                    let uiImage = UIImage(data: selectedImageData) ?? UIImage()
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                }

                PhotosPicker(selection: $selectedImage) {
                    Text("画像を選択 \(Image(systemName: "photo.fill"))")
                }
                .padding()
                .background(Color.blue)
                .foregroundStyle(.white)
                .clipShape(.capsule)
                .onChange(of: selectedImage) {
                    Task {
                        selectedImageData = try? await selectedImage?.loadTransferable(type: Data.self)
                    }
                }

                Spacer()

            }
            .padding()
            .alert("全ての項目を入力してください", isPresented: $showAlert) {
                Button("OK", role: .cancel) {}
            }
            .navigationTitle(Text(dateFormatter.string(from: Date())))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("保存") {
                        Task {
                            await saveRecord()
                        }
                    }
                }

                ToolbarItem(placement: .topBarLeading) {
                    Button("キャンセル") {
                        dismiss()
                    }
                }
            }
        }
    }

    private func saveRecord() async {
        guard let score = Int(scoreText),
              let selectedImage = selectedImage,
              let imageData = try? await selectedImage.loadTransferable(type: Data.self)
        else {
            showAlert = true
            return
        }

        //ここにコードを書くよ！
        let newRecord = SushiRecord(score: score, date: Date(), image: imageData)
        context.insert(newRecord)
        dismiss()
    }
}

#Preview {
    NewRecordView()
        .modelContainer(for: [SushiRecord.self])
}
