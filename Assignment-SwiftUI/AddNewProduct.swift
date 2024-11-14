//
//  AddNewProduct.swift
//  Assignment-SwiftUI
//
//  Created by APPLE on 11/11/24.
//

import SwiftUI
import PhotosUI
struct AddProductView: View {
    @State private var product_name = ""
    @State private var product_type = "Product"
    @State private var price = 0.0
    @State private var tax = 0.0
    @State private var selectedImageData: Data? = nil
    @State private var pickerItem: PhotosPickerItem? = nil
    let options = ["Vehicle", "Phone", "Product", "Electronics", "Service", "Home Appliance"]

    var body: some View {
        NavigationStack {
            Form {
                TextField("Product Name", text: $product_name)
                Picker("Product Type", selection: $product_type) {
                    ForEach(options, id: \.self) { option in
                        Text(option)
                    }
                }
                TextField("Selling Price", value: $price, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    .keyboardType(.decimalPad)
                TextField("Tax Rate", value: $tax, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    .keyboardType(.decimalPad)

                VStack {
                    PhotosPicker(selection: $pickerItem, matching: .images, photoLibrary: .shared()) {
                        if let selectedImageData, let uiImage = UIImage(data: selectedImageData) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: .infinity)
                                .frame(height: 200)
                        } else {
                            ContentUnavailableView("No picture", systemImage: "photo.badge.plus", description: Text("Tap to import a photo"))
                        }
                    }
                }
                .onChange(of: pickerItem) {
                    Task {
                        selectedImageData = try await pickerItem?.loadTransferable(type: Data.self)
                    }
                }

                Button("Submit") {
                    Task {
                        await uploadProductData()
                    }
                }
            }
            .navigationTitle("Add Product")
        }
    }


    func uploadProductData() async {
        guard let imageData = selectedImageData else {
            print("No image selected.")
            return
        }

        guard let url = URL(string: "https://app.getswipe.in/api/public/add") else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        let boundary = "Boundary-\(UUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        let httpBody = createMultipartBody(
            boundary: boundary,
            parameters: [
                "product_name": product_name,
                "product_type": product_type,
                "price": "\(price)",
                "tax": "\(tax)"
            ],
            fileData: imageData,
            fileName: "selectedImage.jpg",
            mimeType: "image/jpeg"
        )

        request.httpBody = httpBody

        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            if let response = response as? HTTPURLResponse {
                print("Response Code: \(response.statusCode)")
            }

            if let jsonResponse = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                print("Response: \(jsonResponse)")
                if let message = jsonResponse["message"] as? String {
                    print("Message: \(message)")
                }
                if let success = jsonResponse["success"] as? Bool, success {
                    print("Product added successfully!")
                }
            }
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }

   
    func createMultipartBody(boundary: String, parameters: [String: String], fileData: Data, fileName: String, mimeType: String) -> Data {
        var body = Data()

        for (key, value) in parameters {
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
            body.append("\(value)\r\n".data(using: .utf8)!)
        }

        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"files[]\"; filename=\"\(fileName)\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: \(mimeType)\r\n\r\n".data(using: .utf8)!)
        body.append(fileData)
        body.append("\r\n".data(using: .utf8)!)
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)

        return body
    }
}

#Preview {
    AddProductView()
}
