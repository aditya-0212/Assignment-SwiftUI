//
//  AddNewProduct.swift
//  Assignment-SwiftUI
//
//  Created by APPLE on 11/11/24.
//

import SwiftUI
import PhotosUI
struct AddProductView: View {
    @Bindable var products: Products
    @State private var selectedImageData: Data?
    @State private var pickerItem: PhotosPickerItem?
    let options = ["Vehicle","Phone","Product","Electronics","Service","Home Applianc"]
    var body: some View {
        NavigationStack {
            Form{
                Picker("Product Type", selection: $products.product_type) {
                    ForEach(options, id: \.self) { option in
                        Text(option)
                    }
                }
                TextField("Product Name", text: $products.product_name)
                TextField("Selling Price", value: $products.price,format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    .keyboardType(.decimalPad)
                TextField("Tax Rate", value: $products.tax,format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    .keyboardType(.decimalPad)
                VStack {
                    PhotosPicker(selection: $pickerItem, matching: .images){
                        if let selectedImageData, let uiImage = UIImage(data: selectedImageData) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: .infinity)
                                .frame(height: 200)
                        } else {
                            ContentUnavailableView("No picture",systemImage: "photo.badge.plus",description: Text("Tap to import a photo"))
                        }
                    }
                }
                .onChange(of: pickerItem){
                    Task{
                        selectedImageData = try await pickerItem?.loadTransferable(type: Data.self)
                    }
                }
                
                Button("Submit"){
                    Task{
                        await addNewProduct()
                    }
                    
                }
            }
            .navigationTitle("Add Product")
        }
    }
   func addNewProduct() async {
       guard let encoded  = try? JSONEncoder().encode(products) else{
           print("order object is not encoded")
           return
       }
       print("1111 encoded \(String(data:encoded,encoding: .utf8) ?? "nodata")")
       let url = URL(string: "https://app.getswipe.in/api/public/add.")!
       print("2222 url is \(url)")
       var request = URLRequest(url:url)
       print("3333 request is \(request)")
       request.setValue("application/json", forHTTPHeaderField: "Content-Type")
     request.httpMethod = "POST"
       print("4444 request is \(request)")
       do{
           let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
           print("55555 data is \(String(data: data, encoding: .utf8) ?? "No data")")
           if let decoded = try? JSONDecoder().decode(Response.self, from: data){
              print("734 decoded data is \(decoded)")
           }
       }
       catch{
          
       }
    
      
    }
}

#Preview {
    AddProductView(products:Products())
}
