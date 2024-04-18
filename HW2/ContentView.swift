import SwiftUI

struct ContentView: View {
    @State private var image: UIImage?
    @State private var showImagePicker: Bool = false
    @State private var inputText: String = ""
    @State private var loadedText: String = UserDefaults.standard.string(forKey: "userInput") ?? ""

    var body: some View {
        NavigationView {
            VStack {
                if let image = image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 300, maxHeight: 300)
                } else {
                    Image(systemName: "photo.on.rectangle.angled")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.gray)
                }

                Button("Load Image") {
                    loadImage()
                }
                .padding()

                Button("Pick Image") {
                    showImagePicker = true
                }
                .padding()

                TextField("Enter some text", text: $inputText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Button("Save Text") {
                    saveUserSetting(key: "userInput", value: inputText)
                }
                .padding()

                Text("Loaded Text: \(loadedText)")
                    .padding()

                Button("Load Text") {
                    if let savedText = UserDefaults.standard.string(forKey: "userInput") {
                        loadedText = savedText
                    }
                }
                .padding()
            }
            .navigationTitle("Media and Settings")
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(image: $image, onSave: saveImage)
            }
        }
    }

    func saveImage(image: UIImage) {
        guard let data = image.jpegData(compressionQuality: 1.0) ?? image.pngData() else { return }
        guard let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let fileURL = directory.appendingPathComponent("savedImage.jpg")
        try? data.write(to: fileURL)
    }

    func loadImage() {
        guard let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let fileURL = directory.appendingPathComponent("savedImage.jpg")
        if let loadedImageData = try? Data(contentsOf: fileURL) {
            image = UIImage(data: loadedImageData)
        }
    }

    func saveUserSetting(key: String, value: Any) {
        UserDefaults.standard.set(value, forKey: key)
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Environment(\.dismiss) var dismiss
    @Binding var image: UIImage?
    var onSave: (UIImage) -> Void

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        var parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
                parent.onSave(uiImage)  // Save the image using the onSave closure passed from ContentView
            }
            parent.dismiss()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
