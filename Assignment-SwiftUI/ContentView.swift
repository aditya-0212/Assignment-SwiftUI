//
//  ContentView.swift
//  Assignment-SwiftUI
//
//  Created by APPLE on 11/11/24.
//

import SwiftUI

struct ContentView: View {
    @State private var products = Products()
    @State private var isShowingSheet = false
    var body: some View {
        NavigationStack{
            List(products.listProducts){ product in
                Section{
                    HStack{
                        if let imageUrl = URL(string: product.image ?? ""){
                            AsyncImage(url: imageUrl){ image in
                                         image
                                           .resizable()
                                           .scaledToFit()
                                           .frame(height: 200)
                            }placeholder: {
                                ProgressView()
                            }
                        }
                        
                            
                        VStack{
                            Text("\(product.product_name)")
                            Text("\(product.product_type)")
                            Text(product.price.formatted())
                            Text(product.tax.formatted())
                        }
                    }
                }
            }
            .navigationTitle("All Products")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                Button{
                    isShowingSheet.toggle()
                } label: {
                    Image(systemName: "plus")
                }
                
            }
            .sheet(isPresented: $isShowingSheet){
                
//                AddProductView(products: products)
            }
            .task{
                await loadData()
            }
        }
    }
    func loadData() async {
        guard let url = URL(string: "https://app.getswipe.in/api/public/get") else {
            return
        }
        print("123 url is \(url)")
        do {
            let (data, _) = try await URLSession.shared.data(from:url)
            print("234 data is \(data)")
            if let decoded = try? JSONDecoder().decode([Product].self,from: data){
                print("567 decoded is \(decoded)")
                products.listProducts = decoded
                print("7854 \(products.listProducts)")
            }else {
                print("Failed to decode JSON data")
            }
           
            }
     catch{
            print("invalid url")
        }
//        do {
//            let (data, _) = try await URLSession.shared.data(from: url)
//            print("Data received: \(String(data: data, encoding: .utf8) ?? "No data")")
//
//            do {
//                let decodedProducts = try JSONDecoder().decode([Product].self, from: data)
//                print("Decoded products: \(decodedProducts)")
//                products.listProducts = decodedProducts
//            } catch let decodingError {
//                print("Failed to decode JSON data: \(decodingError)")
//            }
//        } catch {
//            print("Error fetching data: \(error)")
//        }
    }
}

#Preview {
    ContentView()
}
