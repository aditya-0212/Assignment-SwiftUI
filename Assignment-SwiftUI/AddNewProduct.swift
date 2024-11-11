//
//  AddNewProduct.swift
//  Assignment-SwiftUI
//
//  Created by APPLE on 11/11/24.
//

import SwiftUI
import PhotosUI
struct AddProductView: View {
    @State private var image = ""
    @State private var product_type = ""
    @State private var product_name = ""
    @State private var selling_price = 0.0
    @State private var tax_rate = 0.0
    @State private var processedImage: Image?
    @State private var selectedItem: PhotosPickerItem?
    let options = ["Vehicle","Phone","Product","Electronics","Service","Home Applianc"]
    var body: some View {
        NavigationStack {
            Form{
                Picker("Product Type", selection: $product_type) {
                    ForEach(options, id: \.self) { option in
                        Text(option)
                    }
                }
                TextField("Product Name", text: $product_name)
                TextField("Selling Price", value: $selling_price,format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    .keyboardType(.decimalPad)
                TextField("Tax Rate", value: $tax_rate,format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    .keyboardType(.decimalPad)
                PhotosPicker(selection: $selectedItem){
                    if let processedImage {
                        processedImage
                            .resizable()
                            .scaledToFit()
                    } else {
                        ContentUnavailableView("No picture",systemImage: "photo.badge.plus",description: Text("Tap to import a photo"))
                    }
                }
                
                Button("Submit"){
                    
                }
            }
            .navigationTitle("Add Product")
        }
    }
   
}

#Preview {
    AddProductView()
}
