//
//  AddNewProduct.swift
//  Assignment-SwiftUI
//
//  Created by APPLE on 11/11/24.
//

//import SwiftUI
//import PhotosUI
//struct AddProductView: View {
//    var products:Products
//    @State private var image = ""
//    @State private var product_type = ""
//    @State private var product_name = ""
//    @State private var selling_price = 0.0
//    @State private var tax_rate = 0.0
//    @State private var selectedImageData: Data?
//    @State private var pickerItem: PhotosPickerItem?
//    let options = ["Vehicle","Phone","Product","Electronics","Service","Home Applianc"]
//    var body: some View {
//        NavigationStack {
//            Form{
//                Picker("Product Type", selection: $product_type) {
//                    ForEach(options, id: \.self) { option in
//                        Text(option)
//                    }
//                }
//                TextField("Product Name", text: $product_name)
//                TextField("Selling Price", value: $selling_price,format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
//                    .keyboardType(.decimalPad)
//                TextField("Tax Rate", value: $tax_rate,format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
//                    .keyboardType(.decimalPad)
//                VStack {
//                    PhotosPicker(selection: $pickerItem, matching: .images){
//                        if let selectedImageData, let uiImage = UIImage(data: selectedImageData) {
//                            Image(uiImage: uiImage)
//                                .resizable()
//                                .scaledToFit()
//                                .frame(maxWidth: .infinity)
//                                .frame(height: 200)
//                        } else {
//                            ContentUnavailableView("No picture",systemImage: "photo.badge.plus",description: Text("Tap to import a photo"))
//                        }
//                    }
//                }
//                .onChange(of: pickerItem){
//                    Task{
//                        selectedImageData = try await pickerItem?.loadTransferable(type: Data.self)
//                    }
//                }
//                
//                Button("Submit"){
//                    addNewProduct()
//                }
//            }
//            .navigationTitle("Add Product")
//        }
//    }
//   func addNewProduct(){
//       let newProduct = Product(image: selectedImageData, price: selling_price, product_name: product_name, product_type: product_type, tax: tax_rate)
//       products.listProducts.append(newProduct)
//       
//      
//    }
//}
//
//#Preview {
//    AddProductView(products:Products())
//}
